---
layout: post
title: "Asynchronous Ruby Tasks with DelayedJob"
date: 2014-02-17 14:02
comments: true
categories: ruby rails concurrency delayedjob
---

As promised in my previous entry, it's time to talk about how one can better optimize asynchronous tasks in the Ruby programming language via **DelayedJob**. If you haven't already, I strongly recommend you read my **[last blog post](http://carlosplusplus.github.io/blog/2014/02/01/testing-rake-tasks-with-rspec/)**, as I will be working on the example previously presented there.

So, what does *asynchronous* even mean and why should we care?

## Asynchronous? Why Bother?

> What does asynchronous mean?  Talk about serialized nature of Ruby.
> Why is speed important in data migration tasks? Large data?

## Issue with Previous Implementation

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