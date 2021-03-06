---
layout: post
title: Mysql 5.5 忘記root密碼/如何重設mysql root密碼？
published: true
date: 2011-08-22 16:15
tags: []
category: [tw]
comments: true
redirect_from:
  - /2011/08/mysql-55-rootmysql-root.html
---


昨天才搞了一個忘記[Mac OS X 10.7 Lion 忘記密碼][1]，今天就換忘記mysql密碼=_=|||

okay，直接動手吧！


		killall -TERM mysqld # 把運行中的mysql幹掉



		# 說明一下接下來兩行，照理安裝mysql後都會把mysql路徑放到PATH變數裡，但如果沒有的話，請把完整路徑打上，他的預設資料夾是/usr/local/mysql/bin/

		mysqld_safe --skip-grant-tables &

		mysql



		#進入mysql了



		use mysql

		update user set password=password("新密碼") where user="root";

		flush privileges;

		exit


然後重啟mysql應該就ok了


[參考][2] (但mysql版本並不同，步驟不太一樣)

[1]: http://littlebmix.blogspot.com/2011/08/mac-os-x-107-lion.html
[2]: http://azsxdc.blog.ithome.com.tw/post/192/645
