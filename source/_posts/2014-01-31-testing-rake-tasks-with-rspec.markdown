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
class Question
  include Mongoid::Document

  field :answers_count, type: Integer, default: 0
  field :approved_answers_count, type: Integer, default: 0

  has_many :answers
end
```

A few bullet points on the code above:

- With Mongoid, we include the `Mongoid::Document` module.
	- An individual instance of a model is known as a `document`.
	- The group of all Question models is known as a `collection`.
- With Mongoid, our schema is defined **within the model**.
	- This means there are no migrations to run.
	- We define fields: `answers_count` and `approved_answers_count`.
- This model `has_many: answers`, so `question.answers` should yield me its answers.

Great! Now let's look at the rake task that will recompute those fields.

## RSpec

- Context for aggregation.
- Actual Rspec Test.
- Talk about the individual lines

## Future Optimizations

- No huge deal in Development, but HUGE deal in production.
- Perfect candidate for DelayedJob.