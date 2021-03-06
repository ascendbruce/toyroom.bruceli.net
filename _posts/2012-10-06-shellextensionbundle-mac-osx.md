---
layout: post
title: 解決「ShellExtension.bundle 正在使用中 無法清空垃圾桶」問題 (MAC OSX)
published: true
date: 2012-10-06 21:05
tags: []
categories: [tw]
comments: true

---


這個檔案應該是來自SugarSync，在[SugarSync論壇][1]上有找到臨時解決方案，但到目前官方似乎還未處理這個問題。  
  
  

[![][2]][2]

  
  

## 解決方法：

1. 在垃圾桶上按右鍵
2. 此時再按cmd，就會出現「安全清空垃圾桶」選項
3. 用它就可以強制刪掉ShellExtension.bundle了

  
但是用「安全清空垃圾桶」會比平常久，而且刪掉的東西幾乎不可能救回來了，所以建議只剩ShellExtension.bundle後再用這招。  
  
另外這個檔案的功能，我也不是很清楚，但反正我也不常用SugarSync所以不擔心會有問題。如果你擔心，那麼可以考慮等官方修正。

[1]: http://sugarsync.hivelive.com/posts/95a79047a0
[2]: http://4.bp.blogspot.com/-CKF4Y63umPs/UHFuZF89hJI/AAAAAAAAA48/sw7-Hl2fWuE/s1600/secure_empty_trash.png
