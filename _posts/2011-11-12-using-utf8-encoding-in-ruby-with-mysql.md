---
title: Using utf8 encoding in Ruby with MySQL 5.1 and 5.5
published: true
date: 2011-11-12 18:49
tags: []
category: [en]
comments: true
redirect_from:
  - /2011/11/using-utf8-encoding-in-ruby-with-mysql.html
---


remember to require mysql gem first

		require "rubygems"
		require 'mysql'


> with MySQL 5.1
> 		db = Mysql.init
> 		db.options(Mysql::SET_CHARSET_NAME,"utf8")
> 		db.real_connect("localhost", "username", "password", "database")
>
> with MySQL 5.5
> 		db = Mysql.real_connect("localhost", "username", "password", "database")
> 		db.charset = "utf8"
>


check the result:
		puts db.character_set_name

If you got **utf8**, Congratulations!



