---
title: Ruby Multi-threading simple tutorial
published: true
date: 2010-07-10 19:01
tags: []
category:
- en
comments: true
redirect_from:
  - /2010/07/ruby-multi-threading-simple-tutorial.html
---



Thread Lifecycle

Create a new thread:

		puts "main thread start"
		t1=Thread.new{
		 puts "new thread"
		}
		puts "main thread end"

Remember, if you didn't join the thread instance. The new thread will be interrupt when the main thread ended. Try following code:
		puts "main thread start"
		t1=Thread.new{
		 sleep 5
		 puts "new thread"
		}
		# sleep 10 # uncomment this line and try again
		puts "main thread end"

Join the thread t1:
		puts "main thread start"
		t1=Thread.new{
		 sleep 5
		 puts "new thread"
		}
		t1.join
		puts "main thread end"


But if you want 2 or more threads run at the same time. Don't join right after new it:
		puts "main thread start"
		t1=Thread.new{
		 sleep 5
		 puts "new thread 1"
		}
		t1.join # main thread will wait here until thread t1 finished
		t2=Thread.new{
		 sleep 5
		 puts "new thread 2"
		}
		#t1.join # should place here
		t2.join
		puts "main thread end"


Exceptions

If main thread throw an exception. The script will exit and print error message. But if exception in new threads. It exit only the thread and keep others running, by default. If you want they interrupt the script, than you can set t1.abort_on_exception to true.

But if you use t1.join or t1.value, they interrupt the script by default. Because the main thread will wait at that 2 commands. (t1.value is that return value of the thread block.)
		puts "main thread start"
		t1=Thread.new{
		 sleep 5
		 puts a # Exception: undefined
		 puts "new thread"
		}
		t1.abort_on_exception = true # Default is false，If you uncomment this line. You will find out that it doesn't run the line: puts "new thread"
		sleep 10
		puts "main thread end"

But if it throws exception on the first line in the thread block. It can throw before setting abort_on_exception. So we can use like this:
		puts "main thread start"
		t1=Thread.new{
		 Thread.current.abort_on_exception=true # Thread.current is the thread object itself
		 puts a # Exception: undefined
		 puts "new thread"
		}
		sleep 10
		puts "main thread end"

Variable scope

In new threads can get/set and shared variables at same scope. But local variables in Thread.new {} block are not shared with other threads. And there is a special usage: Use Thread instance like hash:
		outside = "DDDDD"
		t1=Thread.new{
		 puts outside # get DDDDD
		 local_var = "AAAAA"
		 Thread.current["var"] = "BBBBB"
		}
		puts t1["var"] # get BBBBB
		puts local_var # Exception: undefined




Hope this simple ruby multi-threading tutorial have helped you :-)

[Reference][2] (More detail)

[2]: http://www.tutorialspoint.com/ruby/ruby_multithreading.htm
