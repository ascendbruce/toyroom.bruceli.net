---
layout: post
title: acts as authenticated為什麼無法寫入actived_at欄位？
published: true
date: 2008-02-18 19:15
tags: []
categories: [tw]
comments: true
redirect_from:
  - /2008/02/acts-as-authenticatedactivedat.html
---


如果你跟我遇到一樣的狀況
在rails的acts as authenticated套件啟用activation認證碼開通功能的時候
發現activation_code這個欄位會被清除，但actived_at欄位卻還是NULL沒有變成寫入時間(導致登入時被擋掉)
那麼肯定跟我中同一個標了


> Be careful !! *
> User Activation is not secured. You need to add the following line
> to your user model : attr_protected :activated_at



這段取自acts as authenticated的說明網頁
他叫你在user model加入「attr_protected :activated_at」這行

如果你乖乖的加入了
現在請把它刪除

嗯...然後這部份就正常了...


我猜可能是rails版本不同的關係
當時用「acts as authenticated activated_at」當keywords也沒搜尋到資料
總之
我花了23次的try and error才發現的（一切搞定時，table users已經autoindex到23了）

辛苦我自己了= ="

