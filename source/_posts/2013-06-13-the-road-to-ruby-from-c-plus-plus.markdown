---
layout: post
title: "The Road to Ruby from C++"
date: 2013-06-13 14:42
comments: true
categories: flatironschool c++ ruby proglang
---

## My Life and C++

Since 10th grade of high school, I've been programming in C++. Whether in school or in my previous life as an engineer working for the DoD, it's the programming language I've grown to know the best. At this point, the structure and syntax just feels right, and although I've programmed in other languages, C++ has always been my strong point.

Enter the Flatiron School, whose primary focus is to teach me to be a full stack web developer. The language of choice here is Ruby, one of the rising programming languages in the web development world. It's been a battle these past 2 weeks working with Ruby given my background in C++. Forcing yourself to detach from one mindset you've been used to for so long is always a challenge.

While I could syntactically see the differences between C++ and Ruby, I thought it would be an awesome idea to pick a simple programming problem, implement the same solution with both programming languages, and quantify the results.

## A Wild "HISTOGRAM" Has Appeared!

The problem of choice was to develop a simple solution that calculates the **HISTOGRAM**, or frequency, of words that appear in a simple sting. I purposefully made the output from both programs identical so one can see that they do the same thing:

-> {% img /images/posts/2013-06-13-the-road-to-ruby-from-c-plus-plus/C++_v_Ruby.png 700 1000 %} <-

-> Great - the output from the programs is the same. But now, it's time to analyze the code. <-

## C++ vs. Ruby - Whose Code Cuisine Reigns Supreme?

This analysis is predicated on a few assumptions:  

    - Using basic C++ / Ruby structures (e.g. no classes).
    - Using current knowledge of Ruby programming language (9 days worth).

Here is my implementation of a histogram in C++:

{% include_code Histogram function in C++ 2013-06-13-the-road-to-ruby-from-c-plus-plus/histogram.cpp %}

Here is my implementation of a histogram in Ruby:

{% include_code Histogram function in Ruby 2013-06-13-the-road-to-ruby-from-c-plus-plus/histogram.rb %}

To analyze the code, I created six (6) criteria on which I'll be "judging" the languages.

**DATA** = Unique Data Structures  
**LIBR** = Libraries Imported (Non Default)  
**LOFC** = Lines of Code (Functional; e.g. no prints, var declarations)  
**LOOP** = Explicit Loops [O(n)]  
**READ** = Readability : 1 => n00b, 10 => t3h w!nZ  
**VARS** = Unique Variables

-> **Histogram Comparison : C++ vs Ruby.** <-

|**Language**|`C++`|`Ruby`|
|:-: |:-:|:---: 
|DATA|06|**02**
|LIBR|05|**00**
|LOFC|13|**07**
|LOOP|04|**02**
|READ|-1|**10**
|VARS|08|**03**  

-> The clear victor, under these set of criteria, is **RUBY**. <-

## Final Thoughts

Understandably, all programming languages have their advantages and disadvantages. The embedded systems world loves C++ and its ability to easily access lower levels of the stack and hardware in general.  

In terms of general ease of learning and forgiveness, it's **Ruby** all the way. For those that also come from a C / C++ background, here's a **[cool website](http://www.ruby-lang.org/en/documentation/ruby-from-other-languages/to-ruby-from-c-and-c-/ "Transitioning from C / C++ --> Ruby")** that talks about transitioning from C / C++ --> Ruby.

-> **10 days of Ruby vs. 10 years of C++** <-

Ruby, you've won over my <3 already, & we've only just begun getting to know each other.  

CJL