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
* Each level is laid out differently, and can have a variety of components.
	* Monsters, Captives, Bombs, Walls, etc.
* Each level grants the warrior more abilities.
	*	You get to perform one and only one action(!) per turn based on whatever logic you choose to define.
	* More abilities lead to harder levels (e.g. more directions to move in).
* A score is given per level based on different things: level clear speed, amount of action! used, captives rescued, etc.

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
|Stairs|>|-|-

### Level 01

Here is the representation of Level 01:

-> {% img /images/posts/2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/Level01.png 175 175 %} <-

This level is pretty straightforward. Having only one action available [`warrior.walk!`], the logic here is simple:  

{% include_code Ruby Warrior: Level 01 2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/player_h01.rb %}

Level 01 was completed and I achieved maximum points.  

#### Lessons learned:

* Model heuristic functionality based on immediate sufficiency.

### Level 02

Here is the representation of Level 02:

-> {% img /images/posts/2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/Level02.png 175 175 %} <-

This level introduced the first monster. I realized I needed to add logic to check to see if a monster was in front of me based on my available actions. Still pretty straightforward.  

{% include_code Ruby Warrior: Level 02 2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/player_h02.rb %}

Level 02 was completed now completed.

#### Lessons learned:

* Decision logic is going to get completed quick.
	* Probably worth refactoring and "setting the stage" in Level 03.
* Able to make assumption that `Player` class is being initialized one time, with `play_turn` being called in a loop. Take advantage of the `initialize` method.

### Level 03

Here is the representation of Level 03:

-> {% img /images/posts/2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/Level03.png 175 175 %} <-

Four (4) monsters. **Oh snap son**.  

As I began writing my code, I realized I didn't want to do annoying amounts of nested logic. Projecting into the future, I felt the need to begin splitting parts of the agent into logical methods in an organized structure. I also needed to figure out when was the right time to rest, to keep moving forward, and when to attack.  

{% include_code Ruby Warrior: Level 03 2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/player_h03.rb %}

Overall, I was really happy with my code - beat this level with no issues. Even though it grew in size, the `play_turn` method is readable and tells me exactly what the Warrior is to do at any given point in time.

#### Lessons learned:

* (+) Breaking out logic into well-named functions was a great idea!
* (-) Potential issues in the future with additional functionality (like more actions).
* (-) Don't like how each function needs to have `warrior` as a parameter.
	* Can this be fixed with instance variables in Level 04?
* (-) ALL actions are evaluated even if an action is already called.

Given all the negatives, there was going to be some heavy-duty refactoring in Level 04. All in all though, I was fairly certain that the logic in the code was 'just going to work'.  

I couldn't have been more wrong.

### Level 04

Here is the representation of Level 04:

-> {% img /images/posts/2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/Level04.png 175 175 %} <-

Enter the dreaded **Archer** - umm... f*ck.  

This unit can attack from multiple spaces away. With my current logic, I'd rest when the space in front of me was empty and I wasn't in combat. **BUT I WAS IN COMBAT**, since my health was decreasing by 1HP even though I was resting (rest = +2HP, attack = -3HP).  

This now forced new state logic into my methods, along with some well-needed refactoring.

{% include_code Ruby Warrior: Level 04 2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/player_h04.rb %}

Awesome! This now gets around the 'distance attack' issue. If I'm being attacked from afar and the space in front of me is empty, **do not rest** and continue walking until you find and slay the offending monster.

#### Lessons learned:

* (+) Building modular code makes it easy to add in edge cases.
* (+) Constant refactoring makes for better flow.
* (-) `class Player` is getting huge.
	* Consider splitting things into separate classes?

Interestingly enough, your Agent can always be "more intelligent".

## Shooting for the Top

I have a long way to go to reach the top of the **Beginner** tower, but this has been a tremendous learning experience. I've been able to apply Ruby principles to the challenging yet fun problem space of Artificial Intelligence.  

A few things I'm thinking about going forward:

#### Future considerations:

* Classes and further simplification makes sense.
* The levels are only going to get harder:
	* Ability to move in different directions.
	* 2-dimensional maps.
		* How will I track movement?
		* How will I behave when I hit a wall?
	* Rescuing captives.
	* Shooting ranged weapons.
	* Commanding a 'golem' during my turn.
	* Avoiding bombs that detonate.

I'm convinced that my upfront work will help prevent the following from happening:

{% include_code Ruby Warrior: Level 09 (HORRIBAD CODE) 2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/level09_example.rb %}

>->DON'T DO THIS!<-

>->YOU WILL HAVE LESS FRIENDS THAN YOU PROBABLY ALREADY DO.<-

Slowly but surely, I will become the Ruby Warrior I'm destined to be.  

-> {% img /images/posts/2013-07-14-becoming-a-ruby-warrior-with-artificial-intelligence/RubyWarrior.png 750 750 %} <-

A shoutout to my boy [Dan Friedman](http://dfriedm.github.io/) for working on this with me.  

There's still much learning to do and more levels to conquer. Onward and upward!  

CJL