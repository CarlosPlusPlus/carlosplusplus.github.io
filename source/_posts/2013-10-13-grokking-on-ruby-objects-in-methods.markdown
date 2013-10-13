---
layout: post
title: "Grokking on Ruby: Objects in Methods"
date: 2013-10-13 10:04
comments: true
categories: datastructures ruby
---

In a concerted effort to start posting more content to my blog, I've decided to start a new recurring segment called **Grokking on Ruby**. Every now and then, I'll post some cool tips and tricks I find awesome or important to know as you're learning the Ruby programming language. There's a ton out there to share, so let's get to it.  

## Pass Parameters by 'Value' or 'Reference'

Prior to learning about Ruby, my primary programming language was C++. When passing arguments to methods, most statically typed programming languages require you to _explicitly_ declare variables as **value** or **reference** parameters when passed into methods.

- Pass by **value**: a _copy_ of the parameter is passed into method.
- Pass by **reference**: the _actual_ parameter passed into method.

In other words, when passed by value, the original parameter passed into the method is not changed, whereas when passing by reference, the original object may actually be changed.

## Object Modifications in Ruby Methods

Ruby is powerful in that it is a dynamically typed language which is good for duck-typing and meta-programming. This means that you (1) don't have to explicitly define variable types or (2) distinguish between value / reference parameters.

In order to illustrate this, check out the code below:  


```ruby
def modifyStrings(aString,anotherString)
  aString.capitalize!
  anotherString.reverse!.capitalize!
 	aString.swapcase +  " " + anotherString.swapcase!
end
```  

This method takes in two strings and performs modifications. It turns out that the original objects passed into this method *will be changed* as a result of the bang (!) methods performed in the strings, regardless of them being in this method scope.

Take a look at this code - it checks Object ID and values at different stages of the example to reinforce the fact that the original objects are being modified:  

-> {% img /images/posts/2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/Level04.png 175 175 %} <-

{% include_code Ruby Warrior: Level 04 2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/player_h04.rb %}