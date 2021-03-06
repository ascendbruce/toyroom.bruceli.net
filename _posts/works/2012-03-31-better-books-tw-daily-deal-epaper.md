---
layout: post
title: '博客來66折優化電子報'
published: true
date: 2012-03-31 15:32
tags: []
category: [tw, works]
comments: true
image: https://lh6.googleusercontent.com/-eWLoyIVHA94/UcW_q-cNffI/AAAAAAAABW0/nA3oveKlEyQ/s640/books66.png
---

博客來與一些網路書店都有提供「每日一書66折」的活動，但官方的電子報通常非常惱人，三不五時就發電子報、又包含很多不相干的促銷訊息。偶爾遇到有興趣的書，可能也會因為忘記而錯過。

因此我製作了這個優化電子報，除了可以預約「到了當天請通知我」之外，平常只有一週一次隨著官方更新。

![](https://lh6.googleusercontent.com/-eWLoyIVHA94/UcW_q-cNffI/AAAAAAAABW0/nA3oveKlEyQ/s640/books66.png)

網址: http://books66.bruceli.net/

## 主要組成

* 前台、每日特價書 RSS feed
* 後台（訂閱者列表、Remider 預約狀況、每日特價書銷售狀況記錄）
* 爬博客來66折資訊的 Bot
* Email 寄送（訂閱確認信、週報、Remider）

## 使用工具

* Sinatra
* ActiveRecord
* Hpricot
* Gmail gem
* ERB (用在 e-mail body)

## 開發成員

* 我

## CHANGELOG

* 初版上線 (約 2012-03-31)
