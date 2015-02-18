---
layout: post
title: '騙卡馬 Pan Karma'
published: true
date: 2010-05-09 15:31
tags: []
categories: works
comments: true

---
這是一個 Plurk 機器人，只要在朋友中看到有人的發言含有「騙卡馬」等字樣，就會回覆三則搞笑留言，目的是藉以提升 Karma 值。但實際上對 Karma 幫助非常低，主要目的反而是搞笑。

當初是因為觀察到有人會發「只是騙卡馬」之類的廢文，所以就做成一個專門回應「騙卡馬」關鍵字的機器人，後來很多人模仿。

官方修正 Karma 公式忽視機器人後，改成每天自動從資料庫抓一則文章連結發佈、供人轉貼，再更後來就停止服務了。

網址: http://www.plurk.com/pan_karma

## 主要組成

* Plurk bot
* 後台 (管理文章連結)

## 使用工具

* plurk gem (plurk api v1)
* ActiveRecord
* YAML (留言詞庫、設定檔)

## 開發成員

* 我

## 其他資訊

* 超過 30,000 個使用者

## CHANGELOG

* 停止服務 (2012-11-29)
* 改成每天貼一文 (2012-3-28)
* 初版上線 (2010-05-09)
