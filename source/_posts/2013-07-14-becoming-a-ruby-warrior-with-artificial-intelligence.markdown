---
layout: post
title: "Becoming a Ruby Warrior with Artificial Intelligence"
date: 2013-07-14 15:33
comments: true
categories: ai flatironschool ruby
---

In Weeks 3 - 6 at Flatiron School, the focus has been on learning both the Sinatra and Rails web frameworks. Understanding the paradigms has been crucial in spinning up web applications "the right way".  

However, it's important to remember the foundation on which these frameworks are built - the **Ruby** language. With only 6 weeks of Ruby knowledge under my belt, I want to continue understanding the principles of abstraction, modeling, and scope.  

Enter the realm of **Artificial Intelligence (AI)**.

##Basic AI Principles

I've had the honor and pleasure of working with AI concepts in the Scheme programming language. I wanted to explore this realm in Ruby, and it turns out there's a great venue. Before I get into that, let me define two common terms used in AI:  

**Agent**: an autonomous entity which observes through sensors and acts upon an environment using actuators and directs its activity towards achieving goals.  

**Heuristic**: a function that ranks alternatives in various search algorithms at each branching step based on the available information in order to make a decision about which branch to follow during a search.  

Here's a cool image that will make these definitions clearer:

-> {% img /images/posts/2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/AI_Agent.png 575 575 %} <-

Now with that background, onto **Ruby Warrior**.

## What is Ruby Warrior?

The **Ruby Warrior** project (**[Github](https://github.com/ryanb/ruby-warrior)** and **[Ruby Gem](http://rubygems.org/gems/rubywarrior)**) was built as a vehicle to teach Ruby. How? Through the gamification of artificial intelligence.  

Here's a quick overview:

* You (the player) are a Warrior in this world, with your primary objective being to scale levels of a tower.
	* There is a beginner / intermediate tower, both with 'epic' modes.
* Each level is laid out differently, and can have a variety of components: monsters, captives, bombs, etc. 
* Each level grants the warrior more abilities.
	*	You get to perform one and only one action! per turn based on whatever logic you choose to define.
	* More abilities lead to harder levels (e.g. more directions to move in).
* More points are given per level based on different things: level clear speed, amount of action! used, captives rescued, etc.

Every turn, the `play_turn` method is called in `player.rb` file - this and any other files can be used, as long as `play_turn` calls one and only one action.

## Climbing the Tower

For this post, my goal is to share how I've applied my Ruby skills to the first 4 levels. Here's a quick legend regarding level layouts:

-> **Legend: Tower Level Symbols** <-

|`Name`|`Symbol`|`HP`|`Atk`|
|:-:|:-:|:-:|:-:
|Warrior|@|20|5
|Sludge|s|12|3
|Thick Sludge|S|24|3
|Archer|a|7|3

### Level 01

Here is the representation of Level 01:

-> {% img /images/posts/2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/Level01.png 175 175 %} <-

This level is pretty straightforward. Having only one action available [`warrior.walk!`], the logic here is simple:

{% include_code Ruby Warrior: Level 01 2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/player_h01.rb %}

Level 01 was completed and I achieved maximum points.  

#### Lessons learned:

* Model heuristic functionality based on immediate sufficiency.

### Level 02


### Level 03


### Level 04



## Future Considerations

	Picture