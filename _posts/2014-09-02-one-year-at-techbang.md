---
layout: post
title: 在T客邦工作滿一年紀念
published: true
date: 2014-09-02 14:26
tags:
- career
- Techbang
category:
- tw
comments: true

---
今天正好是在T客邦工作滿一年。

這一年發生的事太多了，值得寫一篇紀念文

## 成長

去年我整個就是亂寫，知道的也不多，Ruby debugger, Capistrano, Unicorn 之類的東西也都只聽過沒用過。

這一年來除了接觸很多有的沒的工具（現在看來，都是很基礎的東西，但當時對我來說像天書...），甚至小事如 coding style 也有固定下來。

> 附帶一題，在T客邦會抓 coding style 問題，多一個或少一個不符合團隊習慣的空格都會被退回去修改。

今年也買了 Aeron 椅，加上「在公司登入 Facebook 測試帳號，就會懶得登入主要帳號」的政策（自己訂的），讓我每天的效率提升不少；以 2014年2月跟8月相比，RescueTime 花在 Software Development 類數據增加了 23%。

> Aeron 椅的部分有寫了一篇文章：[改坐 Aeron 椅提升工作生產力]({% link _posts/2014-07-04-how-herman-miller-aeron-chair-affects-productivity.md %})。

## 回顧這段時間發的技術相關文章

有一些讀基礎文件的心得

* [Rails 打基礎 - Rails Guides 3.2.13 閱讀筆記 Part 1]({% link _posts/2013-09-23-rails-guides-reading-notes-first-4-chapters.md %}) （荒廢中... 如果有人想看這個系列請出個聲）
* [讀 Sublime Text 3 文件學到的新招]({% link _posts/2014-06-18-sublime-text-3-document-reading-summary.md %})

也有因為不順手而進階研究了一些工具

* [避免 pow 動不動就很長等待時間、以及 pow 如何跟 spring/zeus 合作]({% link _posts/2014-06-24-extend-pow-kill-idle-timeout-and-pow-working-with-spring-or-zeus.md %})
* [讓 Sublime Text 也擁有 "Navigate to Definition" 功能 (設定 CTags)]({% link _posts/2014-02-23-sublime-text-integration-with-ctags.md %})
* [安裝 Sublime Text 3 互動式 Ruby Debug 外掛]({% link _posts/2014-03-04-sublime-text-3-with-rails-debugger-tutorial.md %})
* [超棒的 rails console 設定]({% link _posts/2014-08-13-awesome-rails-console-customization-using-pry.md %})
* [Capistrano 自動選擇當前 branch deploy 到 staging]({% link _posts/2014-05-27-capistrano-automatically-select-current-branch-to-deploy-to-staging.md %})
* [如何簡化「常常在 rails console 裡反覆輸入某些指令」的狀況]({% link _posts/2014-06-14-using-irbrc-to-serve-frequent-used-commands-in-rails-console.md %})

也跑去參加一些上課、活動

* [「Deliver Project on Time 敏捷專案管理實務」上課心得]({% link _posts/2014-06-22-deliver-project-on-time-lesson-afterthought.md %})
* [RailsConf 2014 行 - 學習的部份]({% link _posts/2014-05-01-railsconf-2014-chicago-what-i-learned.md %})

希望今年也可以繼續學學新東西、寫寫部落格 XD

## 這一年在工作上最高興的成就

維護中的 rails projects (7個) RSpec 全都修成綠燈了

我應該跟不少人提過，我對現代軟體開發有三件事情很在意，分別是：

* 程式碼版本管理
* Issue tracking
* 自動測試

在我進T客邦前，版本管理跟 Issue tracking 就已經有了，但各 projects 的測試都有幾個壞掉以致於不能跑完。

終於在滿一年之前幾個禮拜開始，把維護中的 project 的測試全部重寫，現在全都是 pass 狀態了。(不過 coverage 還很低，這是接下來這年的任務)

而且為了避免老是忘記跑 test 而逐漸敗壞，雖然沒有架 CI，但是有土砲一個「測試失敗就會中斷 deploy 流程」的機制。

## 新計畫

最近在準備一些新計畫，有些是會公開的，敬請期待。
