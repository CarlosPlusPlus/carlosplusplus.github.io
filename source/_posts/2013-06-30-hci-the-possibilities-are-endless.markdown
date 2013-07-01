---
layout: post
title: "HCI - The Possibilities are Endless"
date: 2013-06-30 14:11
comments: true
categories: flatironschool hci ruby
---

One of the things that has most fascinated me about the world of technology is our ability (and even sometimes, inability) to interact with computers. You hear about things like **[Artificial Intelligence](https://en.wikipedia.org/wiki/Artificial_intelligence "Definition of Artificial Intelligence")**, self-realizations regarding the possibilities seen in the movie **[The Matrix](http://www.imdb.com/title/tt0133093/)**, and prophecies of when **[SkyNet](http://terminator.wikia.com/wiki/Skynet)** will take over the world.  

Interestingly enough, this is where **HCI** comes into play.

## What is HCI?

As defined by [Wikipedia](https://en.wikipedia.org/wiki/Human%E2%80%93computer_interaction):

> Human–computer Interaction (HCI) involves the study, planning, and design of the interaction between people (users) and computers.

HCI extends in to a variety of different realms, encompassing things we take for granted like website interaction all the way to virtual reality. Our day to day communication with our computers, whether physical or emotional, defines our overall user experience (UX). The user interaction (UI) is a large part of what we as web developers can control.  

Coming from a computer engineering / hardware background, I've always had a great interest exploring the combined space of gaming, hardware, and HCI. So that got me thinking... does an API exist that allows me to interface with the Microsoft Kinect?

## Hacking the Microsoft Kinect

I've owned a Microsoft Kinect since the day it was publicly released, and to this day, am continually impressed by its raw power and how it's changed the space of gaming. In doing some research, it appears like there are a few Ruby wrappers in existence that allow for direct interface with the hardware. Luckily, the only requirements for the software were a computer with USB ports and lots of time.  

At the high level, here are some quick data points I discovered while analyzing two ruby gems - **Kinect-Ruby Processing** and **Ruby-Freenect**:

    - Released as Ruby Gems with dependencies.
    - Interface directly with hardware via USB.
    - Allow for control of image / video type.
        > Allow for image capture.
        > Allow for video capture.
    - Allow for control of camera tilt mechanism.
    - Allow for control of LED.
    - Video feed in RGB / InfraRed (IR) / Depth provided.
    - Average of about 30 Frames per Second (FPS).
    - Support of gem halted > 1yr ago! :(

Now to see the contenders in a little more detail!  

---

### Kinect-Ruby Processing

The **[Kinect-Ruby Processing](https://github.com/mudphone/Kinect-Ruby-Processing "Github of Kinect-Ruby Processing gem")** gem interfaces directly with the Ruby Processing (rp5) library. Using this raw power that many don't realize Ruby can handle, it interfaces directly with the hardware and can provide functionality as described in the previous section.  

Here are images taken directly from the Kinect:

-> {% img ./images/posts/2013-06-30-hci-the-possibilities-are-endless/rp5_rgb_depth.png 750 1250 %} <-

-> **Kinect-Ruby Processing: RGB with Depth Map.** <-

-> {% img ./images/posts/2013-06-30-hci-the-possibilities-are-endless/rp5_ir_depth.png 750 1250 %} <-

-> **Kinect-Ruby Processing: Infrared with Depth Map.** <-

So... you're probably asking yourself, what does some of this code look like? Let's see:

```ruby

```

#### Celebrate Failure! Or not...?

-> {% img ./images/posts/2013-06-30-hci-the-possibilities-are-endless/rp5_error.png 500 750 %} <-

---

### Ruby-Freenect

Information on Ruby-Freenect project.

-> {% img ./images/posts/2013-06-30-hci-the-possibilities-are-endless/libfree_depth_rgb.png 750 1250 %} <-

-> {% img ./images/posts/2013-06-30-hci-the-possibilities-are-endless/libfree_depth_ir.png 750 1250 %} <-

-> {% img ./images/posts/2013-06-30-hci-the-possibilities-are-endless/libfree_3spectra.png 750 1250 %} <-

-> {% img ./images/posts/2013-06-30-hci-the-possibilities-are-endless/libfree_packetloss_cmd.png 500 750 %} {% img ./images/posts/2013-06-30-hci-the-possibilities-are-endless/libfree_packetloss_img.png 500 750 %}<-

## The Future is Now

My current plan is to explore the world of HCI via the Microsoft Kinect during my semester here at the Flatiron School. The exploration of this hardware interface, perhaps through gamification, will allow me to hopefully (1) contribute to open source and (2) understand the what is possible and what isn't.  

Simply stated:

>->**The possibilities are endless.**<-

Stay tuned for more information on the Kinect.