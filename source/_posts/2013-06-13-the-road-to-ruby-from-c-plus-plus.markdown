---
layout: post
title: "The Road to Ruby from C++"
date: 2013-06-13 14:42
comments: true
categories: flatironschool c++ ruby proglang
---

## My Life and C++

[Talk about previous experience with C++]

## A Wild "HISTOGRAM" Has Appeared!

[Talk about the histogram approach.]

-> {% img /images/posts/C++_v_Ruby.png 700 1000 %} <-

[Talk about the histogram benchmark and how code is the same.]

## C++ vs. Ruby - Whose Code Cuisine Reigns Supreme?

Preface to section.

{% include_code Histogram function in C++ histogram.cpp %}

Here is how Ruby does it.

{% include_code Histogram function in Ruby histogram.rb %}

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

The clear victor, under these set of criteria, is **RUBY**.

## Final Thoughts

[Talk about final thoughts]