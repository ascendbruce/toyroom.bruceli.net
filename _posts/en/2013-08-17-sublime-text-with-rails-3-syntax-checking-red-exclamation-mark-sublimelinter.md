---
layout: post
title: Sublime Text wtih Ruby 1.9/Rails 3 syntax checking
published: true
date: 2013-08-17 02:17
tags:
- ruby
- rails
categories: [en]
comments: true

---
The Ruby 1.9 hash syntax causes syntax check errors in Sublime Text 2 with a red exclamation mark.


## TL;DR

`Preferences -> Package Settings -> SublimeLinter -> Settings - User`

    {
        "sublimelinter_executable_map":
        {
            "ruby": "rvm-auto-ruby"
        }
    }

And restart Sublime Text 2

[Configuring the SubLime Linter Plugin to use Ruby 1.9 Syntax](http://stackoverflow.com/questions/9153210/configuring-the-sublime-linter-plugin-to-use-ruby-1-9-syntax)
