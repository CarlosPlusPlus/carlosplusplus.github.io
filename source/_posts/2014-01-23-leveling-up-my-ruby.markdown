---
layout: post
title: "Leveling Up my Ruby"
date: 2014-01-23 22:37
comments: true
categories: ruby rails
---

In an effort to share more with the world and write, I'm going to give this micro-post idea a try.

## An Evolution Through Time

It's been about 6 months since I've started learning Ruby, and until recently, I didn't realize how much I've learned in such little time. Both at work and through self-study, I continue to build, define, and hone my programming knowledge. I've been investing a lot of time at work with Ruby / Rails / RSpec, and decided to mix it up with some Front-End skill development off hours. Whatever path you choose on your conquest to become a better developer, be receptive to learning and stay focused.

It's a fun exercise to see how your programming skill evolves as a function of time. Recently, I was helping a friend write a scraper for the StreetEasy website. This is only a small sample of the overall code.

This is how I would've written this portion a few months ago:

```ruby
class StreetEasyScraper
  attr_accessor :browser, # ...

  def initialize(browser)
  	@type = "rent" if browser.contains?("rent")
  	@type = "sale" if browser.contains?("sale")
    # ...
  end

  # ...
end

```

And here's how I wrote it a few days ago:

```ruby
class StreetEasyScraper
  attr_reader :browser, # ...

  def initialize(browser)
    @type = browser['rent'] || 'sale'
    # ...
  end

  # ...
end
```

Let's look at some of the differences:

- `attr_reader` instead of `attr_accessor`, as won't be changing.
- A **really cool** way to search & return a substring if it exists.
- Use of the `||` operator, as I know API will only ever be two values.
- `' '` vs `" "` for strings that will not be interpolated (Ruby best practice).

As simple as these four differences may be, they took me by surprise and made me feel amazing. The things I'm both learning and seeing are beginning to stick, and rather than going back and refactoring, they're being expressed in my code upfront. Pretty awesome!

## Introspect Often

Amidst the chaos we know as life, I encourage you to take the time to **introspect**, regardless of whether you're new to programming or not. There are days when you feel feel down (happens to me all the time). However, remind yourself that as long as you've learned something that day, you will always come out on top. Be sure to also take breaks from programming (this is healthy and strongly recommended), and to get regular sleep. Your body and mind need rest to be at their prime!

Don't forget that more often than not:

>->**The best teachers are also students.**<-

Stay strong and continue learning, friends.  
Have faith in yourselves, and continue being pillars of support for each other.

CJL