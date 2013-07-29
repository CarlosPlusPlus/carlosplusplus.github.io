---
layout: post
title: "Code to Joy"
date: 2013-06-16 13:16
comments: true
categories: flatironschool lovetocode codetojoy ruby
---

In the search to educate myself a bit more on Ruby principles, both procedural and technical, I came upon a presentation by Avdi Grimm (**[avdi](https://speakerdeck.com/avdi "SpeakerDeck Website for avdi")**) on **[SpeakerDeck](http://speaderdeck.com "SpeakerDeck")**.  

These slide decks goes into things I'm passionate about when it comes to programming:
    - Sharing your happiness of coding with others.
    - Constantly exploring the possibilities of programming.
    - Trying new things and getting messy.

In this day and age, it is my firm belief that we, as programmers, are our own best source of motivation. Through constant exploration and profound expressiveness of programming languages, it is within our power to shape the world as we know it today.  

## Joyful, Joyful We Adore Thee (Ruby)

In **[@avdi](http://www.twitter.com/avdi "Avdi Grimm's Twitter")**'s slide deck, **Code to Joy**, he discusses many things about the Ruby programming language that he loves. He begins first by staying that both his job and that ruby is awesome, stating:

>->It (Ruby) still finds ways to make me smile after all these years.<-

Avdi then goes into the Ruby language and standard library, calling out a few of his favorite idioms and tools. Reading through these was a great learning experience (given my current n00b status with Ruby itself). Here's are a few things I learned:  

* Functions can have multiple `return` values:
```ruby
001 > def sum_diff(x,y)
002?>   return x+y,x-y
003?>   end
 => nil 
004 > a,b = sum_diff(5,3)
 => [8, 2] 
005 > a
 => 8 
006 > b
 => 2 
```

* The ability to access the local file structure:
```ruby
001 > require 'pathname'
 => true 
002 > Dir.chdir('/Users/carloslazo/Development/FlatironSchool')
 => 0 
003 > Pathname.pwd.ascend{|dir| puts dir}
# /Users/carloslazo/Development/FlatironSchool
# /Users/carloslazo/Development
# /Users/carloslazo
# /Users
# /
 => nil 
```

* The concept of `ensure` in `enumerable lists`:
```ruby
001 > def names
002?>   yield 'Carlos'
003?>   yield 'Dan'
004?>   yield 'Sagar'
005?>   yield 'Thomas'
006?>   ensure
007 >     puts "Avi"
008?>   end
 => nil 
009 > i = 0
010 > names do |name|
011 >     puts name
012?>   break if i >= 1
013?>   i += 1
014?>   end
# Carlos
# Dan
# Avi
 => nil 
```

* The ability to `break` with a value:
```ruby
001 > def names
002?>   yield 'Carlos'
003?>   yield 'Dan'
004?>   yield 'Sagar'
005?>   yield 'Thomas'
006?>   end
 => nil 
007 > result = names do |name|
008 >     break name if name =~ /^S/
009?>   end
 => "Sagar" 
010 > result
 => "Sagar" 
```

## Be Confident in your Ruby

The remainder of the technical topics went over my head, as my level of Ruby knowledge is not there yet.  One thing I **can** understand is the crux of Avdi's advice:

>->Practice joyful coding.<-

All in all, there is no rubric to tell you what is considered "joyful coding" in this world. Spread knowledge to those around you, always. Inspire through example and by teaching what you know. Cherish those "A-HA" moments, both when you have them and when you witness them in others. The world of coding, and the world in general, will be a better place for it.  

CJL