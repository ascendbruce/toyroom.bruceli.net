---
layout: post
title: ubuntu linux用rename指令批次改檔名
published: true
date: 2011-01-21 13:30
tags: []
categories: [tw]
comments: true

---


ubuntu上好像比較少批次改檔名軟體，不過其實有一個可以用正規式改檔名的指令，某個層面來說是超級方便的工具。  
  
如果你熟悉Perl的Regular Expression(正規表達式)，這個工具對你來說可能理所當然。不幸的是，我雖然會一點正規表達式，但完全沒碰過Perl，好在看到一篇[國外的文章][1]有稍微講細一點，不然[man rename][2]我也整個看不懂。所以這篇文章是寫給看過[man rename][2]但還整個搞不懂他的perlexpr參數的人：  
  
語法：  

		rename [ -v ] [ -n ] [ -f ] perlexpr [ files ]  
		  
-n 是把模擬的結果印在螢幕上，不實際改檔名  
-v 是改檔名同時把結果印在螢幕上  
-f 是當檔名重複時強制覆蓋  
perlexpr 是perl的正規表達式，下面再解釋  
files 是要被改的檔案，可以使用星號*與?  
  
  
範例：  
		# 把出現在檔名內任何地方的「全金屬狂潮」都改成「驚爆危機」，時常用到的功能，你懂的  
		rename 's/(全金屬狂潮)/驚爆危機/' *  
		# 把英文統一改成小寫  
		rename 'y/A-Z/a-z/' *  
		# 把檔案名稱結尾的.bak刪掉，這是man rename的範例  
		rename 's/\.bak$//' *.bak  
		  
  
因此perlexpr其實是這樣的：  
  
's/舊檔名的正規式/新檔名的正規式/'  
  
那個s是取代(substitute)的意思  
至於y…因為我也找不到資料，會perl的大大歡迎提供資訊  
  
  
然後！  
給不會正規式的網友們：  
  

1. [Google it][3]
2. 用[Rubular][4] Lvie玩RegExp，不過這是for Ruby的，有一些細節可能不太一樣。



[1]: http://tips.webdesign10.com/how-to-bulk-rename-files-in-linux-in-the-terminal
[2]: http://blog.csdn.net/disikexing/archive/2009/05/06/4154205.aspx
[3]: http://www.google.com.tw/search?sourceid=chrome&ie=UTF-8&q=%E6%AD%A3%E8%A6%8F%E5%BC%8F
[4]: http://www.rubular.com/regexes/
