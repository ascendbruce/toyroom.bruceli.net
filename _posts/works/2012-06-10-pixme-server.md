---
layout: post
title: 'Pixme Server'
published: true
date: 2012-06-10 15:32
tags: []
categories: works
comments: true

---
Pixme 是我在 CloudOnline 的第二個案子，Pixme 是一個 iOS 上的拍照軟體，主打對「自拍」特別方便的流程。

Pixme 除了 App 本身以外的功能幾乎都在這裡實作，包括 APIs、背台、Facebook Canvas App。

![](https://lh5.googleusercontent.com/-ejbnAgCJEFk/Ud7KZYvBcMI/AAAAAAAABac/WhraKtJXSCo/s640/pixme.png)

網址: http://pixme.cc/

## 主要組成

* 前台（FAQ、活動網頁。產品頁面則主要是設計師完成）
* 後台（裝置狀態、會員狀態、問卷統計、裝置數量統計、廣播 APN 等）
* APIs（手機 App 用到的 APIs、Facebook、Weibo的授權APIs）
* Facebook Canvas App

## 使用工具

* Rails
* apn_on_rails
* ruby-pinyin
* Maruku
* RSpec
* VCR (錄製與重播外部 HTTP response 以利自動測試)

## 開發成員 (依 commit 數)

到我離職為止，下同

* 我 (99%)
* [Boris](http://www.linkedin.com/profile/view?id=56941896) + [Allen](http://www.linkedin.com/profile/view?id=136347421) (1%)

## 其他資訊

* 22 個 Models, 21 個 Controllers
* LOC 3,543
* 555 commits
* Code to Test Ratio: 1:0.3
* 從 Rails 3.0 更新到 3.2

## CHANGELOG

* 初版上線 (約 2012-06-10)
