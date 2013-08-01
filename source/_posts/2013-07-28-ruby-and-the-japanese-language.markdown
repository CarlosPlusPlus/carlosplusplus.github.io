---
layout: post
title: "Ruby and the Japanese Language"
date: 2013-07-28 20:18
comments: true
categories: flatironschool japanese languages ruby
---

## **こんにちは世界** (Kon'nichiwa sekai!)

The inspiration for this blog post comes from a few places:

1. My love of languages and world-wide celebration of culture.
2. This [slide deck](http://www.slideshare.net/inouemak/ruby-and-japanesepdf) by [Makoto Inoue](https://twitter.com/makoto_inoue) on **Ruby and Japanese**.
3. General curiosity on the topic.

Growing up, my first **spoken** language was Spanish, followed shortly there after by English and French, all three of which I'm fluent in. In the present, I split my time between learning 5 other languages - Japanese, Mandarin Chinese, German, Italian, and Russian.  

Interestingly enough, during this same time period, I've also worked with a variety of different **programming** languages - C, C++, C#, Java, Python, Scheme, and MATLAB. I continue to learn languages, like Ruby, JavaScript, and HTML/CSS.  

That begs me to ask the question:  

>-> **Is there a link between programming languages and spoken languages?** <-

Why yes, yes there is - let's take a look at **Ruby and the Japanese Language**.

## Insight into the Japanese Language

The Japanese language has a total of three (3) different alphabets, all of which serve their own purpose:

1. **Hiragana** - syllabic alphabet for domestic use.
2. **Katakana** - syllabic alphabet used for "borrowed" / new words.
3. **Kanji**	  - symbolic alphabet used to import Chinese words.


Most students learn the syllabic alphabets first through memorization and mnemonics, using charts like this one to assist in the memorization:

-> {% img /images/posts/2013-07-28-ruby-and-the-japanese-language/alphabet_chart.png 750 750 %} <-

Thousands of Kanji characters are in existence today - an individual in Japanese is considered fluent when they have mastery of the base 2000 characters. These are generally learned through memorization and constant practice.  

Cool - so how does the Japanese language relate to the Ruby programming language?

## Japanese <=> Ruby - What's the Deal?

Based on the definitions of the alphabets, we can see the following comparisons between the Japanese spoken language and the Ruby programming language:

1. **Hiragana** - syllabic alphabet for domestic use.
> In Ruby: built for **domestic** ease-of-use (focus on programmer happiness).
2. **Katakana** - syllabic alphabet used for "borrowed" / new words.
> In Ruby: continually evolving and adapting **new** functionality.
3. **Kanji**	  - symbolic alphabet used to import Chinese words.
> In Ruby: merge (**import**) concepts of Object Orientated / Functional programming.

So, how then can the Japanese language be considered object oriented and functional?

### Object Oriented Comparison

Thinking back to when we were learning English, our teachers taught us that sentences are formed in the following order: Subject - Verb - **Object** (SVO). It's fair to state that English is an "Object-Oriented Language," where context revolves around the object in question.  

Japanese is quite similar, with the exception of the normal form of expressions being in the following form: Subject - **Object** - Verb (SOV).  

For example, take the following sentence:

|`English`|`Japanese`|`Pronunciation`|`Structure`|`Literal English`
|:-:|:-:|:-:|:-:|:-:
|I eat bacon.|私はベーコンを食べます。|Watashi ha bacon wo tabemasu.|SOV|"I bacon eat."

Ruby's primary focus, much like the Japanese language, targets the object as the center of attention. Although the grammatical structure may be different, the intention remains the absolute same.  

In terms of code, Ruby also allows us to define functionality in both object oriented and procedural ways:  

```ruby
# Object Oriented
File.open("foo.txt")	# => SVO (Japanese)

# Procedural
open("file","foo.txt)
``` 
The example above shows the flexibility of Ruby to implement the same solution using two different grammatical orders. In most cases, when dealing with a complex problem, functionality is encapsulated within a class. Object Orientation proves to be a great aspect of the Ruby language.

### Functional Comparison

Japanese grammar is different in that it is _post-positional_:

> postposition - a word placed after the word it governs (e.g. the 'ward' in homeward). 

These _post-positional_ words are used to decide the role of the noun which it supports. This would allow a Japanese speaker to change the order of the grammar pretty easily, *chaining as many sentences as desired*, and even *omitting the subject* altogether.

Here are some examples:

-> {% img /images/posts/2013-07-28-ruby-and-the-japanese-language/functional_japanese.png 750 750 %} <-

|`English`|`Japanese`|`Pronunciation`|`Structure`|`Literal English`
|:-:|:-:|:-:|:-:|:-:
|I eat bacon.|私はベーコンを食べます。|Watashi ha bacon wo tabemasu.|SOV|"I bacon eat."
|I eat bacon.|ベーコンを私は食べます。|Bacon wo watashi ha tabemasu.|OSV|"Bacon I eat."
|I eat bacon.|ベーコンを食べます。|Bacon wo tabemasu.|OV|"Bacon eat."

Where do we see this sort of behavior in Ruby?

```ruby

##########################
# Expressively Iterative #
##########################

# .times enumerator	=> 5x
5.times do
	# => Perform action here.
end

i = 0
c = 5

# while loop => 5x
while i < c do
	# Perform action here.
	c += 1
end

# for loop => 5x
for i in 0..5
	# Perform action here.
end

##########################
# Functional Flexibility #
##########################

str  = "Hello World!"

expr1 = str.upcase.delete('o').gsub('O','X')	
	# => "HELLX WXRLD!"
expr2 = str.delete('o').upcase.gsub('O','X')
	# => "HELL WRLD!"
expr3 = str.gsub('O','X').upcase.delete('o')
	# => "HELLO WORLD!"

#########################
# Contextual Evaluation #
#########################

# Opens a file.
File.open("foo.txt")

# Open a file and then yield to a block.
File.open("foo.txt").each do |line|
	puts line
end
```

Functional programming in Ruby allows for hard-core abstraction and meta-programming, which is something that other programming languages do not support as easily.

## Ruby in Japanese

## Embracing Language Diversity in the World

Too often, I overhear people argue over which language is:  

- Better.
- Faster.
- Stronger.
- More Robust.
- More Semantically Correct.

As programmers and as citizens of a diverse world, it's up to us to **respect** language in general, whether programming or spoken. It should come as no surprise that programming and spoken languages are so similar, _as one is used to express_ the other.  

>-> **どうもありがとうございました。** (Dōmo arigatōgozaimashita!)<-

Check-out this awesome blog post, titled [Learning Japanese the Rubyist Way](http://blog.new-bamboo.co.uk/2010/12/17/learning-japanese-the-rubyist-way) for more info.  

CJL