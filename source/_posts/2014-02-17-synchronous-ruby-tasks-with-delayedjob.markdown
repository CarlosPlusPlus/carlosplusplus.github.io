---
layout: post
title: "Synchronous Ruby Processing with DelayedJob"
date: 2014-02-17 14:02
comments: true
categories: ruby rails delayedjob
---

As promised in my previous entry, it's time to talk about how one can better optimize asynchronous tasks in the Ruby programming language via **DelayedJob**. If you haven't already, I strongly recommend you read my **[last blog post](http://carlosplusplus.github.io/blog/2014/02/01/testing-rake-tasks-with-rspec/)**, as I will be using the example presented there.

So, what the deal with *synchronization* and why should we care?

## Asynchronous? Synchronous?

First, a quick refresher on what these two words mean, in their simplest forms:

> **Asynchronous** - NOT occurring at the same time.  

> **Synchronous** -  occurring at the same time.

When we first start learning Ruby, or most programming languages, we are taught to think of events as asynchronous. In other words, a program is:

1. Executed in the order it is written.
2. Run from top-to-bottom in a serial fashion.
3. The next line runs after the previous completes.

There are, however, situations where you may want to think synchronously. In other words, perhaps it may be preferable for events to happen at the same time, or more commonly, **in the background**. This would allow your web service to keep servicing operations while intense work was being performed elsewhere. A few uses cases for this may be:

- Batch imports of updates to your database.
- HTTP downloads (steaming intensive operations).
- Image resizing (size intensive operations).
- Sending mass emails (newsletters) to your user base.

Let's explore the use case for batch updates as it relates to Rails rake tasks.

## Issue with Previous Rake Task Implementation

As described in my **[last blog post](http://carlosplusplus.github.io/blog/2014/02/01/testing-rake-tasks-with-rspec/)**, I implemented a set of Rake tasks that recomputed custom counter caches for some of my Rails models. While the solution certainly solved the problem, it was implemented in an asynchronous fashion. In other words, each **unit of work** needed to complete before the previous one. In this case, a unit of work was equal to one model having its counter caches recomputed.  

To further highlight the issue, here's a look at what the full rake task does:

```ruby
# lib/tasks/aggregation.rake
namespace :mongo_import do
  MODELS    ||= %w(answer comment question resource)
  WORK_SIZE ||= 1000.freeze

  desc 'Rebuilds ALL aggregation columns and counter caches.'
  task :aggregation => :environment do
    MODELS.each { |model| Rake::Task["mongo_import:aggregation_#{model}"].invoke }
  end

```

As you can see, there are a total of four (4) rake tasks that will be run in sequence, each with varying levels of work based on the number of models present in the database and the amount of counter caches for each model. Given that this work needs to be done while the data set is in production, these rake tasks need to finish fast - this is impossible with the current implementation. Wouldn't it be great if there was a way to split up this work and run these tasks in parallel, or synchronously, in order to get the task done faster?

Let's see what `DelayedJob` can do for us.

## DelayedJob to the Rescue

For those who have never heard of or used `DelayedJob`, I recommend you check out the following resources: [DelayedJob Github Repository](www.example.com) and [RailsCast on DelayedJob](www.example.com). This gem integrates pretty seamlessly with Rails applications and different database configurations, like SQLite3 and MongoDB. The documentation provides great use cases for when and why you would want to use this service.

### Background Process and Workers

I won't go into the implementation detail of how precisely to get setup with DelayedJob (check out the documentation), but I do want to mention a few key concepts that are important:

> **Enqueue**: add unit of work to DelayedJob priority queue for processing.

> **Perform**: method required for DelayedJob to recognize class as actionable.

> **Workers**: specific background processes setup to handle **units of work**.

At the high level, your processing work flow will probably look something like this:

1. Spin up amount of workers based on (a) server capability and (b) need.
2. Enqueue DelayedJobs whenever required (e.g. mass mailings and rake tasks).
    - You can add jobs to different queues, establish Job priorities, etc.!
3. Workers will perform queued up jobs as soon as they are 'free'.

Great - let's dive into some code and see how I re-did my rake task.

### Plan of Attack

The following was the original **asynchronous** code. Notice how each individual model must be updated before the next one can be processed. This is a great time to think about [O(n)](www.example.com) - in other words, how would this algorithm (loop) perform as `Question.all` gets infinitely large? With the current implementation, not too well - it would act as a bottleneck for the application, potentially halting other requets from being served:

```ruby
# lib/tasks/aggregation.rake
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

What I want to do is abstract the computation itself to a `DelayedJob` task. Instead of processing on `Question.all` asynchronously, let us use the current `WORK_SIZE` constant to `slice` models in groups and `enqueue` them via DelayedJob. It's also important to be mindful of making optimized database calls, as you don't want to be slamming your database with unnecessary processing.

Great - now with our plan of attack in place, let's get to work.

### Rake Task Implementation via DelayedJob



## Improvements and Closing Thoughts

> Finalized Rake Tasks
> Speed Increase
> Other Great Use Cases for DelayedJob