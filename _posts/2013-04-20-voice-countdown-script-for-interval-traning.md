---
layout: post
title: Voice countdown ruby script for interval training
published: true
date: 2013-04-20 23:09
tags:
- ruby
categories: []
comments: true

---


## README
This is a simple script used for interval training. (Mac only)

It's helpful when you do stationary bike exercise and watch TV at the same time. The voice alert will tell you when to sprint or relax. So you don't have to keep watch on timer. Just enjoy the TV show, and the training.

The time period is suggested by [WebMD: Interval Training Burns More Calories in Less Time](http://www.webmd.com/fitness-exercise/news/20121012/interval-training-burns-more-calories-less-time). Which are:

* 2 minutes warm up
* (30 seconds sprint + 4 minutes relax) x 5 iterations

But you can change it. they are between line 22 and 28.

## Sorucecode

``` ruby interval_training.rb
    # by Bruce Li 2013-04-21
    class Fixnum
      alias_method :minute, :minutes
      alias_method :second, :seconds
      def minutes
        self*60
      end
      def seconds
        self
      end
    end

    def say(msg, options = {})
      voice = options[:v]
      if voice and not voice.empty?
        system("say -v #{voice} '#{msg}' &")
      else
        system("say '#{msg}' &")
      end
    end

    # === configs ===
    warm_up_duration = 2.minutes
    sprint_duration = 30.seconds
    relax_duration = 4.minutes
    iterations = 5
    voice = "" # leave blank or nil to use the default
    # ===============

    say "warm-up", :v => voice
    sleep warm_up_duration
    iterations.times.each do |idx|
      say "sprint", :v => voice
      sleep sprint_duration
      if idx != iterations - 1
        say "relax", :v => voice
        sleep relax_duration
      end
    end
    say "cooling down", :v => voice
```

Run `ruby interval_training.rb`

## Configuration
`voice`: Run `say -v ?` in terminal to get a full list of available voices.
