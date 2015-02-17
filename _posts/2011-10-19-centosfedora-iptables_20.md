---
layout: post
title: CentOS/Fedora 重開機後維持iptables設定值的作法
published: true
date: 2011-10-19 18:50
tags: []
categories: []
comments: true

---


我用的實際上是CentOS 5.5，但RedHat系的應該都沒什麼差別（吧）  
  
有一個iptables-save指令，雖然叫做save，實際上他並沒有寫入設定檔，所以重開機以後還是會失去上次修改的設定值  
  
依據iptables-save的說明，他其實只是把目前設定轉成一個標準的格式、輸出到螢幕(STDOUT)上，你必須自己把它寫到設定檔裡。  
  
設定檔是在/etc/sysconfig/iptables  
  
所以  

		iptables-save > /etc/sysconfig/iptables  
		  
就ok了！  
  
  
你可以先  
		more /etc/sysconfig/iptables  
		iptables-save  
		看看兩者的內容

