---
layout: post
title: sikuli在存檔之後就失效 (問題：中文路徑)
published: true
date: 2010-03-14 13:24
tags: []
category: [tw]
comments: true
redirect_from:
  - /2010/03/sikuli.html
---


在windows xp上試玩sikuli，但是很奇怪，明明一切都很順利，怎麼突然一個都偵測不到，出現紅色背景？

得到錯誤訊息：

    edu.mit.csail.uid.FindFailed: FindFailed: 1268625522234.png can't be found.
    ps: 那個xxxxxx.png就是截圖的檔名

如果點圖片preview，會得到以下訊息

    0 matches found
    ps: 但是正常情況時，會有50 matches，一次掉到0也太奇怪了

經過幾次測試，我發現在存檔之後才出現失效狀況，猜測是因為存檔路徑有中文，移到別的目錄後，發現一切正常了。

vgod的plurk也有討論到這個狀況（我google「sikuli 路徑 中文」時才找到的...）

