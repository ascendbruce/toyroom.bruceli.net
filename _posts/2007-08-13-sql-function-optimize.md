---
layout: post
title: sql function最佳效能寫法
published: true
date: 2007-08-13 00:55
category:
- tw
tags:
- dev
comments: true
redirect_from:
  - /2007/08/sql-function.html
---
**警語：這是舊資料了，現在用 `COUNT(*)` 才是最佳化的**

sql提供一些方便的查詢function，例如count、min、max、sum等等
但究竟怎麼寫效能會比較好呢？
一般常見的寫法有以下三種（假設主鍵是id）
SELECT COUNT(*) FROM `table`
SELECT COUNT(1) FROM `table`
SELECT COUNT(`id`) FROM `table`

小弟廢話不多說了，直接po上我自己的測試數據

>

> ___COUNT(*) ______ COUNT(1) ______ COUNT(`id`)____
> 0.1283900737760 | 0.1033070087430 | 0.0965209007263
> 0.0977160930634 | 0.0935349464417 | 0.0874459743500


這是一次連續查詢1000次，對三者輪流查詢100次的total
可以發現COUNT(`id`)　的寫法明顯獲勝，感謝CFC大大提示可能是因為主鍵具有索引性(index)，所以查詢速度較快。

分享給大家 :)

