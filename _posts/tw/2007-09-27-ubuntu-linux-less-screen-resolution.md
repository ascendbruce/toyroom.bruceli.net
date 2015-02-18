---
layout: post
title: ubuntu linux提供的螢幕解析度選項太少…怎麼會這樣
published: true
date: 2007-09-27 18:43
tags: []
categories: [tw]
comments: true

---


昨天筆者新電腦灌好了ubuntu，發現怎麼解析度那麼少（只給到1024*768），明明顯卡螢幕都OK的，求問了一下google大神，有人建議修改/etc/X11/xorg.conf檔案，但我懶、而且也怕怕，所以我在終端機執行以下指令：  

> sudo dpkg-reconfigure xserver-xorg

這指令會一步一步問答，全部重設一次（包括鍵盤…等等設定），就像一開始在安裝過程會問你的鍵盤layout等等…就照情況選擇就OK了，會有一個選擇螢幕解析度，按空白鍵把要的幾個解析度打星號即可。  
  
最後重開機 ，或Ctrl+Alt+Backspace重啟X應該就解決了

