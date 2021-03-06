---
title: (Ruby) Write service with daemons gem
published: true
date: 2010-06-12 15:56
tags: []
category: [en]
comments: true
redirect_from:
  - /2010/06/ruby-write-service-with-daemons-gem.html
---

<a href="{% link _posts/2010-06-12-ruby-write-service-with-daemons-gem-en.md %}" class="lang-btn lang-current">EN</a>
<a href="{% link _posts/2010-06-12-ruby-write-service-with-daemons-gem.md %}" class="lang-btn">TW</a>


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
