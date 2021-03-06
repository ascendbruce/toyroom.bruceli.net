---
layout: post
title: 幫rails 3 加個nl2br函數，把\n換成br tag
published: true
date: 2011-11-10 18:36
tags: []
categories: [tw]
comments: true
redirect_from:
  - /2011/11/rails-3-nl2brn.html
---


Rails其實有內建轉換行的method叫simple_format，但是他會把連續兩個以上換行換成<p>...</p>，這有點太聰明了，又不知道有沒有其他更好的做法，所以我只好自己寫。

simple_format還[可以擋javascript][1]


在application_helper.rb

		def nl2br(html)
		 raw(h(html).gsub(/[(\n)(\r)]/, "\n" => "<br/>", "\r" => "" ))
		end
		先將內容擋掉不該有的html tag，再把\n替換成<br>，這樣子可以避免被塞入有危險性的tag，但又能放行自己的換行tag。


h
		<%=h "<br/>" %>
		# 其實是 h("<br/>")
		# => &lt;br/&gt;
raw
		<%=raw "<br/>" %>
		# 其實是 raw("<br/>")
		# => <br/>
.html_safe
		<%= "<br/>".html_safe %>
		# 跟 raw("<br/>") 是一樣的
		# => <br/>

在Rails 2，預設是raw，在Rails 3剛好相反，預設是harm
也就是說：
	Rails 3:
		<%= "<br/>" %> 擋掉html
		<%=raw "<br/>" %> 直接出html

		Rails 2:
		<%=h "<br/>" %> 擋掉html
		<%= "<br/>" %> 直接出html

在Rails 3加h也是沒關係的

[1]: http://apidock.com/rails/ActionView/Helpers/TextHelper/sanitize
