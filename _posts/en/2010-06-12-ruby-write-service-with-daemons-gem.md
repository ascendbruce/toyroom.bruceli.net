---
layout: post
title: (Ruby) Write service with daemons gem
published: true
date: 2010-06-12 15:56
tags: []
categories: [en]
comments: true

---

正體中文版: [(Ruby) Write service with daemons gem]({% post_url tw/2010-06-12-ruby-write-service-with-daemons-gem %})


How to make a ruby script run only one instance at a time? and with start/stop command?

Actually, it's very simple, just use [Daemons][1] gem.

installation (ubuntu):

		sudo gem install daemons

Simplest example: test.rb
		require 'rubygems'
		require 'daemons'

		Daemons.run_proc('myproc.rb') do
		 loop do
		 sleep(5)
		 puts "Hello World"
		 end
		end

Than you can use following commands:
``ruby test.rb [start|stop|restart|run|zap]``
(Run 'ruby test.rb' will get command usage.)

And when you try to run 'test.rb start' twice. you will get:
		ERROR: there is already one or more instance(s) of the program running


[1]: http://daemons.rubyforge.org/