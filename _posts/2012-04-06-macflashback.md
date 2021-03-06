---
layout: post
title: 檢查你的Mac是否有中標Flashback木馬
published: true
date: 2012-04-06 18:29
tags: []
categories: [tw]
comments: true
redirect_from:
  - /2012/04/macflashback.html
---


這幾天新聞有報出來：[Mac也中毒？全球已有60萬部Mac遭木馬入侵][1]，快檢查一下你的mac有沒有中獎：

打開終端機(Terminal)，執行以下兩行：

> defaults read /Applications/Safari.app/Contents/Info LSEnvironment
> defaults read ~/.MacOSX/environment DYLD_INSERT_LIBRARIES

如果都回應裡有 ... does not exist 代表沒有事。

但是請記得安裝系統更新「Java for OS X 2012-002」項目，否則之後還是有機會中招。（點左上角蘋果 > 軟體更新）

不幸中的了話[參考這篇][2]，不過是英文的。


另外，一個重要的觀念：其實Mac系統本身安全性不見得較佳，而是大環境沒什麼人在鑽研攻mac的病毒。真要避免中毒的話，養成良好的習慣才是重點，不要亂點連結、不要亂開email附檔、更新要安裝。

廣告詞「Mac 不會感染 Windows 電腦上成千上萬的病毒。」其實也沒有錯，大部分Windows病毒在Mac上是跑不起來的，不過還是有跨平台的病毒，也有Mac only的病毒。這句的意思是不會感染「有限但數量非常多」的病毒，而非「完全不會」感染病毒，不過很多人都解讀錯啦，甚至是賣電腦的工讀生也是。

延伸閱讀：
[防毒軟體真的有用嗎？][3]
[MAC大哉問，在買MAC前你要知道的事情][4]


[來源][5]

[1]: http://blog.cnyes.com/My/dunhill925/Article747349
[2]: http://www.f-secure.com/v-descs/trojan-downloader_osx_flashback_i.shtml
[3]: http://wired.tw/2012/03/30/antivirus/index.html
[4]: http://www.mobile01.com/topicdetail.php?f=481&t=2552389&last=34881001
[5]: https://www.facebook.com/sodas.tsai/posts/383305948366423
