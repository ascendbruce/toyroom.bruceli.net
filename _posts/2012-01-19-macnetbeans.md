---
layout: post
title: Mac下NetBeans打中文怪怪的，要如何輸入中文？ (已解決)
published: true
date: 2012-01-19 20:18
tags: []
categories: []
comments: true

---


這問題困擾我很久了，今天心血來潮搜尋一下，發現其實早就有人有解決辦法，雖然路徑不一樣，但是稍微搜尋一下就找到了，以下是Mac OS X 10.7 + NetBeans 7.0.1下的解決方案：  
  
**1. 先找到 netbeans.conf 檔案**  
這個檔案的路徑應該是 /Applications/NetBeans/NetBeans\ 7.0.1.app/Contents/Resources/NetBeans/etc/netbeans.conf  
但有可能因為版本不同而名字不太一樣，稍微搜尋一下  
  
**2. 用vim或你熟悉的編輯器打開那個檔案，找到 netbeans_default_options 項目**  
  
**3. 在那個很長一串的項目中加上 -J-Djava.awt.im.style=on-the-spot**  
謹慎一點可以在加上去之前先找找看 -J-Djava.awt.im.style 是否已經存在  
  
重開NetBeans後應該就ok了！  
  
  
2012-01-31 補充：  
目前還是有Bug，有時候仍然會失效，此時試試看在打開NetBeans前先切換到中文輸入法，在我的電腦上這樣就一切正常，但網路上也有回報相反的狀況（必須先切到英文輸入法才能work）。  
  
[參考][1]



[1]: http://www.douban.com/note/82403581/