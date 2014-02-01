---
layout: post
title: "Testing Rake Tasks with RSPec"
date: 2014-01-31 19:53
comments: true
categories: 
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

## RSpec, FactoryGirl, and Contextual Magic

I have to give credit where it's due - this post titled **[How to Test Rake Tasks Like a BOSS](http://robots.thoughtbot.com/test-rake-tasks-like-a-boss)** from [ThoughtBot](http://www.thoughtbot.com) made this all possible, with a few modifications.

#### Sharing is Caring via RSpec Context

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

- `let(:task_name)` => my task_name will equal the top level description of my Rspec example.
- `let(:task_path)` => here's where I link to my aggregation.rake file.
- `subject { ... }` => the subject in my RSpec example will be set to my specifc rake task.

This context is automagically loaded in all specs thanks to this line in `spec_helper.rb`:

```ruby
Dir[Rails.root.join("spec/support/**/*.rb")].sort.each {|f| require f}
```

Now with this context setup, let's move onto the Factories:

#### FactoryGirl to the Rescue

In the Rspec Tests, you will see things like the following:

```ruby
FactoryGirl.create(:question)
FactoryGirl.create(:answer, question: question) }
FactoryGirl.create(:answer, question: question, approved: true)

```

Factories are defined elsewhere that give me the flexibility to create new documents (models) in particular configurations. In this case, I know I want to specifically test my two aggregation fields, so I'll be setting those when I use my factories in my RSpec examples. So the associations are upheld, I want to assign the newly create answers to the question that was created.

With my factories all setup, I'm ready to look at my RSpec tests.

## RSpec 

# Future Considerations

- After doing this the first time, I was able to write my tests first.
- No huge deal in Development, but HUGE deal in production.
- Perfect candidate for DelayedJob.