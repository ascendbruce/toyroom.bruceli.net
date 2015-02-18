---
layout: post
title: (Ruby) Write service with daemons gem
published: true
date: 2010-06-12 15:56
tags: []
categories: [tw]
comments: true

---


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
		  
  
  
==Traditional Chinese version==  
  
  
如何讓一支ruby程式一次只有一個instance？並且有start/stop等指令呢？  
  
其實，這非常簡單，只要用[Daemons][1] gem就可以了。  
  
安裝 (ubuntu):  
		sudo gem install daemons  
		  
最簡單的範例: test.rb  
		require 'rubygems'  
		require 'daemons'  
		  
		Daemons.run_proc('myproc.rb') do  
		 loop do  
		 sleep(5)  
		 puts "Hello World"  
		 end  
		end  
		  
然後你就可以用以下指令了：  
``ruby test.rb [start|stop|restart|run|zap]``  
(執行 'ruby test.rb' 會提示你指令用法)  
  
當你嘗試執行 'test.rb start' 兩次，你會得到以下錯誤:  
		ERROR: there is already one or more instance(s) of the program running  
		

[1]: http://daemons.rubyforge.org/
