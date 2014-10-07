---
layout: post
title: "MicroPost: Ruby's Integer #to_s Method"
date: 2014-10-06 22:25
comments: true
categories: ruby
---

I'm GOING to make time for this blog. I've found tech blogging so therapeutic in the past, and it really doesn't need to be a huge chore. Deciding to finally saddle up and do this MicroPost idea I've had for quite some time. No huge, elaborate posts - instead, small little morsels of awesome.

Alright, so here goes! First one is about Ruby's **Integer#to_s** (to string) method.

### Ruby's Integer#to_s Method

As I continue to level up my Ruby, I continue to be amazed by the beauty of the language.

I remember wayyyy back in High School and even in my Digital Logic Design college courses how I would constantly use binary (base 2), octal (base 8), and hexadecimal (base 16) number systems more than decimal (base 10). As I work through **[Project Euler](http://www.projecteuler.net)** problems for coding practice, I saw Problem 36:

```ruby
<<-PROBLEM

The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
(Please note that the palindromic number, in either base, may not include leading zeros.)

PROBLEM
```

Awesome, makes sense - here's my solution first, with some cool points to follow:

```ruby
class String
  def palindrome?
    self == self.reverse
  end
end

def is_double_palindrome?(n)
  n.to_s.palindrome? && n.to_s(2).palindrome?
end

solution = (1..999999).select { |n| is_double_palindrome?(n) }.inject(:+)
puts "Sum of all numbers < 1E6 which are palindromic in B10 & B2 = #{solution}"

```

1. I **love** how Ruby lets you **[monkey-patch](http://en.wikipedia.org/wiki/Monkey_patch)** base classes like `String`.
2. Ruby's `Integer#to_s` **[method](http://www.ruby-doc.org/core-2.1.3/Fixnum.html#method-i-to_s)** can take an argument, which does a numeric base conversion!
3. Methods like `Enumerable#select` [**[link](http://ruby-doc.org/core-2.1.3/Enumerable.html#method-i-select)**] and `Enumerable#inject` [**[link](http://ruby-doc.org/core-2.1.3/Enumerable.html#method-i-inject)**] are **so damn cool**.

No need for elaborate classes or modules - short, sweet, and to the point!

<br>
---

That's it for this post - until next time, keep being awesome.

CJL
