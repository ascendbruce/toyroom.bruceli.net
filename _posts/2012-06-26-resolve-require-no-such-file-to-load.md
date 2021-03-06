---
title: 'Resolve `require'': no such file to load -- readline (LoadError) exception
  (especially ruby build from source code)'
published: true
date: 2012-06-26 17:52
tags: []
categories: [en]
comments: true

---


It gives the exception when I run "rails console". This is how I resolve the problem.
My environment: Ubuntu 12.04, Ruby 1.9.2p290 build from source, Rails 3.0.10

For ruby builded frome source code:
1. Make sure you have libreadline-dev and libncurses5-dev
2. Go to the ruby source code directory
3. Build readline up

Install libreadline-dev

		sudo apt-get install libreadline-dev libncurses5-dev
		or Some older ubuntu didn't have libreadline-dev try:
		sudo apt-get install libreadline5-dev libncurses5-dev

cd (ruby_sourcecode_dir)/ext/readline
		ruby extconf.rb
		make
		sudo make install

For RVM:
Basically same to above. But the path to ext/readline is under .rvm directory.
eg. /home/your_name/.rvm/src/ruby-1.9.2-p290/ext/readline

