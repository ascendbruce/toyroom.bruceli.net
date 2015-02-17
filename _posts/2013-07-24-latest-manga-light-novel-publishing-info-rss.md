---
layout: post
title: '最新出版漫畫/輕小說資訊 RSS'
published: true
date: 2013-07-24 15:33
tags: []
categories: works
comments: true

---
自動抓 [蛙蛙書局的最新出版漫畫清單](http://wawabook.com.tw/comic/0102.php)，除了官方網站有公布外，蛙蛙書局也會張貼到 Komica 討論網站，但對於沒有那麼積極查看這些網站的人，例如我，會覺得 RSS 更方便，所以便製作這個小工具。

![](https://lh5.googleusercontent.com/-_pq496B_p-I/Ue_q34kWTGI/AAAAAAAABc0/9RE4fSz8aVE/s640/wawa_rss.png)

網址: http://bruce.non.tw/wawa_rss

# 主要組成

* 前台
* 爬蛙蛙書局網站的 Bot
* RSS
* (Email 電子報是透過 Google FeedBurner 產生)

# 使用工具

* Sinatra
* [sinatra-template](https://github.com/ascendbruce/sinatra-template) (我的一個 open source project)
* Bootstrap
* Nokogiri

# 開發成員

* 我

# CHANGELOG

* 初版上線 (2013-07-24)
