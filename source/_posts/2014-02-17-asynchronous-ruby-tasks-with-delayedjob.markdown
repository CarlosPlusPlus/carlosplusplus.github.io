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
- HTTP Downloads (steaming intensive operations).
- Image Resizing (size intensive operations).
- Sending mass emails (newsletters) to your user base.

Let's explore the use case for batch updates as it relates to Rails rake tasks.

## Issue with Previous Rake Task Implementation

As described in my **[last blog post](http://carlosplusplus.github.io/blog/2014/02/01/testing-rake-tasks-with-rspec/)**, I implemented a set of Rake tasks that recomputed custom counter caches for some of my Rails models.

> Show the entire rake task.

> Speed is an issue in this serialized operation - can take forever.
> Wouldn't it be great for a server to spin up multiple processes

## Delayed Job to the Rescue

> References to DelayedJob
> Code Implementation + Idea of Workers

## Improvements and Closing Thoughts

> Finalized Rake Tasks
> Speed Increase
> Other Great Use Cases for DelayedJob