---
layout: post
title: 使用acts as authenticated plugin在if current_user判斷出錯
published: true
date: 2007-08-30 00:51
tags: []
categories: []
comments: true

---


如果跟著「Ruby on Rails專業網站案例實作」這本書走，在第八章安全性應該教到使用acts as authenticated插件，但奇怪的是layout中下面那行總會出錯，拿書商的範例檔來run也一樣。  

> 

  
小弟花了幾天的時間才搞定(小弟不才orz)，current_user是在.../lib/authenticated_system.rb 中的一個method，在未登入狀況下會傳回:false，因此將範例原始檔中、出錯的那行改成如下，便可正確執行。  

>  

另外一種做法是只將.../lib/authenticated_system.rb 中的current_user method改成如下  

> def current_user  
>  @current_user ||= (session[:user] && User.find_by_id(session[:user])) || nil #原本最後一個是:false  
> end

小弟使用前者。

