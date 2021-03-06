---
layout: post
title: Mac 10.7 以後如何恢復長按鍵盤重複輸入
published: true
date: 2012-04-22 10:00
tags: []
categories: [tw]
comments: true
redirect_from:
  - /2012/04/how-to-enable-key-repeat-in-mac-osx-107.html
---

<a href="{% link _posts/2012-04-22-how-to-enable-key-repeat-in-mac-osx-en.md %}" class="lang-btn">EN</a>
<a href="{% link _posts/2012-04-22-how-to-enable-key-repeat-in-mac-osx.md %}" class="lang-btn lang-current">TW</a>

升級到Lion以後，長按鍵盤的行為變成字母選擇（例如長按a會出現 [àáâ...]）、而不是重複輸入，按方向鍵不能連續跳字讓我很困擾。

恢復方法：

1. 打開終端機(Terminal)，執行：
defaults write -g ApplePressAndHoldEnabled -bool false

2. 然後重開機



