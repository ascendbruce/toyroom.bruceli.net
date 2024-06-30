---
layout: post
title: Mac下NetBeans的切換Tab (跳到左/右邊的Tab)
published: true
date: 2012-01-29 22:07
tags: []
category:
- tw
comments: true
redirect_from:
  - /2012/01/switch-between-tabs-jump-to.html
---


(Switch between tabs, jump to next/previous tab in NetBeans for mac)

預設的組合鍵是...

* Cmd + Page Up
* Cmd + Page Down

另外也有選單式的快捷鍵：Ctrl + Tab

修改組合鍵的方法
到 NetBeans > Preferences > Keymap

搜尋 Previous Tab 跟 Next Tab項目，在Shortcut欄點兩下進入修改模式，然後按下你想要的組合鍵。

我習慣改成：

* Cmd + Shift + [
* Cmd + Shift + ]

因為這是大部分程式都適用的切換分頁快捷鍵。
（他會顯示成 Shift + Meta + CLOSE_BRACKET 跟 Shift + Meta + OPEN_BRACKET）

如果有衝突到其他功能的話，他會跳出提示，如果你用不到那個舊功能，覆蓋掉(Override)即可。

[來源][1]

[1]: http://stackoverflow.com/questions/3579458/switch-between-tabs-in-netbeans-on-mac
