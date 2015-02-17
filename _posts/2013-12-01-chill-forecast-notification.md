---
layout: post
title: '氣溫驟降預報'
published: true
date: 2013-12-01 15:34
tags: []
categories: works
comments: true

---
雖然氣象預報常常失準（例如說晴天結果下雨、說下雨結果只是陰天等），但氣溫趨勢還蠻準的，但又不可能每天都記得去查看中央氣象局網站，如果能在天氣要變冷前提早提醒，就不怕預估錯誤而穿不夠暖了。

![](https://lh5.googleusercontent.com/-oebT3ESxZRE/UsgHR-MqhAI/AAAAAAAABnA/ugdVlKEbumU/s640/chill.png)

網址: http://bruce.non.tw/chill/

# 主要組成

* 前台
* 爬中央氣象局資料的 Bot
* 輸出 RSS （寄送 Email、貼到 Facebook/Plurk 都是利用其他服務接收 RSS 達成）

# 使用工具

* Foundation 5
* [sinatra-template](https://github.com/ascendbruce/sinatra-template) (我的一個 open source project)
* Nokogiri

# 開發成員

* 我

# CHANGELOG

* 初版上線 (2013-12-01)
