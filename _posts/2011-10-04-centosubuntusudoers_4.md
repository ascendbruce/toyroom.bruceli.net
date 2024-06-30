---
layout: post
title: 在CentOS以及Ubuntu上新增sudoers
published: true
date: 2011-10-04 08:00
tags: []
category:
- tw
comments: true
redirect_from:
  - /2011/10/centosubuntusudoers.html
---


先說在Ubuntu上，其實只要把指定的使用者加到admin群組即可：

		sudo adduser yourname admin


CentOS上就稍微麻煩一點，而比較之前版本的Ubuntu也是使用這個方法：修改/etc/sudoers檔案

這個檔案比較特殊，無法直接用慣用的文字編輯器修改，即使你用sudo vim /etc/sudoers，他也會告訴你read only

你需要用

		sudo visudo /etc/sudoers
		# 或者
		sudo sudoedit /etc/sudoers


在我的環境（CentOS 5.3）是要用sudoedit（因為沒有visudo指令），您可以打vi然後按兩下tab，看看有沒有visudo。也可以打su然後也按兩下tab，看看有沒有sudoedit。

