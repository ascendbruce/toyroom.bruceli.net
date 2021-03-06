---
title: "清空 error monitoring 錯誤列表的策略（bugsnag/airbrake/sentry）"
date: 2018-05-26 17:40
categories: [tw]
tags: []
og_image: /images/posts/010-line-chart-heading-down.png
excerpt: "Error monitoring 工具已經是必備工具了，但你是否也見過這樣的狀況：Bugsnag 裡每天有數千個大小錯誤混在一起，因為太多了，大家也變得愛看不看。Monitoring 名存實亡。 以下的策略是我過去幾年來，每次加入新團隊時引入的策略："
---

![](/images/world.png) English version: [Strategies for emptying error reports from bugsnag/airbrake/sentry]({% link _posts/2018-05-26-strategies-clearing-bugsnag-error-reports-en.md %})

![cover]({{ "/images/posts/010-line-chart-heading-down.png" | absolute_url }})

Error monitoring 工具已經是必備工具了，但你是否也見過這樣的狀況：Bugsnag 裡每天有數千個大小錯誤混在一起，因為太多了，大家也變得愛看不看。Monitoring 名存實亡。

以下的策略是我過去幾年來，每次加入新團隊時引入的策略：

* 打開 bugsnag → Slack 的通知 (依照使用的服務)，但不要通知 Info 等級的（或是使用的通知系統的 low severity level）
* **要求所有成員打開 slack channel 通知** ★️ 重點
* 區分出不需要處理的，一次性調整成 Info
* 在寫 [handled error](https://docs.bugsnag.com/platforms/ruby/rails/reporting-handled-errors/) 時，情況允許的話直接用程式設定成 Info
* 有統一的管票系統，以免重複工。Bugsnag 也有一鍵開票的功能
* 當出現洪水般的錯誤時，確認狀況後 snooze，並盡快修復

結果：

所有成員都會收到通知，不時會發生洪水攻擊，但是大家都開心：

* 工程師知道有通知跳出來時都是要緊的事
* business 方知道 user 看到錯誤畫面這種等級的錯誤很快就會被注意到，不用整天盯工程師
* user 不會被晾在一邊老是看到一樣的 500 Internal Server Error 錯誤

延伸閱讀：

* [Strategies for improving your debugging workflow](https://blog.bugsnag.com/debugging-workflow/)
