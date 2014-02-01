---
layout: post
title: "Testing Rake Tasks with RSpec"
date: 2014-02-01 08:00
comments: true
categories: ruby rails rake rspec testing
---

One of the projects I'm currently supporting at work involves migrating an entire database from the [Oracle](http://www.oracle.com/index.html) framework to the [MongoDB](http://www.mongodb.org/) framework. This Rails application is crucial in that it serves as one of the primary JSON APIs for my company's web services.

My colleagues had written an import task which will takes the (deprecated) Oracle versions of our models and migrate them to the new MongoDB representations. However, there are aggregation columns and custom [counter caches](http://railscasts.com/episodes/23-counter-cache-column) that must be recomputed once the migration is done. I was asked to write a rake task to perform this operation on all relevant models. It was also recommended I find a way to test this locally, as the task was going to be performed on millions of rows of data in production, making it imperative to get it right the first time.

No better way to get started than to dive in head first!

## The Model Space

The Rails model I'll be using is **Question**. The `Mongoid` Ruby driver is used instead of `ActiveRecord` - I'll do my best to explain any Mongoid syntax in case you have never worked with MongoDB.

Here are the parts of the **Question** model we care about in the Rails app:

```ruby
# app/models/question.rb
class Question
  include Mongoid::Document

  field :answers_count, type: Integer, default: 0
  field :approved_answers_count, type: Integer, default: 0

  has_many :answers
end
```

So, what's happening with the code above?

- With Mongoid, we include the `Mongoid::Document` module.
	- An individual instance of a model is known as a `document`.
	- The group of all Question models is known as a `collection`.
- With Mongoid, our schema is defined **within the model**.
	- This means there are no migrations to run.
	- We define fields: `answers_count` and `approved_answers_count`.
- This model `has_many: answers`, so `question.answers` should yield me its answers.

Great! Now let's look at the rake task that will recompute those fields.

## Rake Task to Compute Aggregation Fields

Let's get right to it and look at the rake task I wrote to re-compute these fields:

```ruby
# lib/tasks/aggregation.rake

WORK_SIZE ||= 1000

desc 'Aggregation Task for: Question'
task :aggregation_question => :environment do
  Question.all.batch_size(WORK_SIZE).each do |q|
    attrs = {}

    answers_count          = q.answers.count
    approved_answers_count = q.answers.where(approved: true).count

    attrs[:answers_count]          = answers_count          unless answers_count.zero?
    attrs[:approved_answers_count] = approved_answers_count unless approved_answers_count.zero?

    Question.where(id: q.id).update(attrs) unless attrs.empty?
  end
end
```

Let's dissect what's happening above:

- I define `WORK_SIZE` to control the # of Questions I load at a time.
	- Attempting to load all models into memory at once is NOT recommended.
- Each field is computed and added to the `attrs` hash if it's non-zero.
	- Recall how the model defaults these to 0 - no need to update if not needed, right?
- In order to perform just one vs. multiple updates, I pass in my hash to update if non-empty.
	- This query is *optimized** via Mongoid / MongoDB. You'll have to believe me here.

Great, so now I have a rake task built. How can I test this?

## Contextual Magic with FactoryGirl and RSpec

I have to give credit where it's due - this post titled **[How to Test Rake Tasks Like a BOSS](http://robots.thoughtbot.com/test-rake-tasks-like-a-boss)** from [ThoughtBot](http://www.thoughtbot.com) made this all possible, with a few modifications. Please read this for a more in-depth explanation at how this upcoming RSpec context works.

### Sharing is Caring via RSpec Context

Since I knew I was going to be performing this operation across multiple models (all with different fields), I started out by making an RSpec context (as described in the blog post):

```ruby
# spec/support/shared_contexts/aggregation.rb

shared_context 'aggregation' do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "lib/tasks/aggregation" }
  subject         { rake[task_name] }

  def loaded_files_excluding_current_rake_file
    $".reject {|file| file == Rails.root.join("#{task_path}.rake").to_s }
  end

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path, [Rails.root.to_s], loaded_files_excluding_current_rake_file)

    Rake::Task.define_task(:environment)
  end
end
```

Here are the lines we care the most about:

- `let(:task_name)` => my task_name will equal the top level description of my RSpec example.
- `let(:task_path)` => here's where I link to my aggregation.rake file.
- `subject { ... }` => the subject in my RSpec example will be set to my specifc rake task.

This context is automagically loaded in all specs thanks to this line in `spec_helper.rb`:

```ruby
Dir[Rails.root.join("spec/support/**/*.rb")].sort.each {|f| require f}
```

Now with this context setup, let's move onto the Factories.

### It's a Bird... It's a Plane... It's FactoryGirl!

In my RSpec tests, you will see things like the following:

```ruby
FactoryGirl.create(:question)
FactoryGirl.create(:answer, question: question) }
FactoryGirl.create(:answer, question: question, approved: true)

```

Factories are defined elsewhere that give me the flexibility to create new documents (models) in particular configurations. In this case, I know I want to specifically test my two aggregation fields, so I'll be setting those when I use my factories in my RSpec examples. So the associations are upheld, I want to assign the newly create answers to the question that was created.

With my factories all setup, I'm ready to look at my RSpec tests.

### RSpec, Do That Voodoo That You Do So Well

Now with everything in place, let's write some RSpec examples. I'm going to break this up into two sections so that it's easier to digest.

#### INITIALIZATION

```ruby
# spec/lib/aggregation_spec.rb

describe 'aggregation_question' do
  include_context 'aggregation'

  describe 'Initialization' do
    its(:prerequisites) { should include('environment') }

    it 'should initialize fields to zero' do
      q = FactoryGirl.create(:question)

      q.answers_count.should be_zero
      q.approved_answers_count.should be_zero
    end
  end

  # Execution

  end
end
```

So, what's going on here?

- The top level description of my example is purposely named `aggregation_question`.
	- If you recall, this is the name of my rake task, which will be set as the `subject`.
- For this to all work, I must include my shared_context we created previously.
- I create a few examples to test out the initialization of my model.

Awesome! This all works as intended. I know my rake task (`:aggregation_question`) is wired correctly due to the `:prerequisites` example. Now, onto the execution of the rake task.

#### EXECUTION

```ruby
# spec/lib/aggregation_spec.rb

describe 'aggregation_question' do
  include_context 'aggregation'

	# Initialization

	describe 'Execution' do
    before do
      (1..3).each do |n|
        question = FactoryGirl.create(:question)
        n.times  { FactoryGirl.create(:answer, question: question) }
        n.times  { FactoryGirl.create(:answer, question: question, approved: true) }

        question.set(:answers_count, 0)
        question.set(:approved_answers_count, 0)
      end
    end

    it 'should contain the correct instance count' do
      Question.count.should == 3
    end

    it 'should properly set aggregation fields for Questions' do
      Question.all.each do |q|
        q.answers_count.should be_zero
        q.approved_answers_count.should be_zero
      end

      subject.invoke

      Question.all.each_with_index do |q,i|
        q.answers_count.should == (i + 1) * 2
        q.approved_answers_count.should == i + 1
      end
    end
  end
end
```

Now, onto the execution of the rake task:

- Using my factories, I use a loop to setup a total of three (3) questions as follows:
	- Q1: 2 total answers, 1 of which  is approved.
	- Q2: 4 total answers, 2 of which are approved.
	- Q3: 6 total answers, 3 of which are approved.
- I force my aggregation fields to 0, as counter caches are increasing upon document creation.
- Just to be sure, I check to see that my test database has the correct number of questions.

The magic all happens in my last example:

1. First, I check to ensure all Questions I created have zero values for their aggregation fields.
2. Given that `subject` is the rake task I want to execute, I `invoke` the task, running it.
3. Based on my creation criteria, I then check to ensure all fields equal their expected values.

Running these tests yields four (4) **passing** examples!

## Future Considerations

Having gone through the first model in this exact fashion, I was able to write my **tests first** for the other models and write similar examples. However, there's a really big issue here that is hard to ignore.

While the tests are great, they in no way represent the volume of data I'll be finding in production. As you can see, the rake task is executed 1000 documents at a time, in serial fashion. The time this takes in unacceptable when processing millions of documents, as this data needs to be available as soon as possible. So, how can we solve this problem?

Stay tuned for a future blog post on how I re-did my rake task as a `DelayedJob`.

Thanks for reading; keep calm and carry on!

CJL