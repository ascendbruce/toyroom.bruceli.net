---
layout: post
title: 在T客邦 新進工程師如何學習 Rails
published: true
date: 2014-11-12 03:46
tags:
- rails
- career
- Techbang
categories: [tw]
comments: true

---
T客邦有許多優秀前輩經手並建立起來的 codebase 與 infrastructure、數個以維護為主的產品、不固定的新網站開發需求、已實行一段時間的軟體工程與專案管理方法等，因此在許多人眼中是不錯的 Rails 開發者練功環境。

也因此這是許多對T客邦工作有興趣的人會想知道的事，這次趁機會寫出來給大家參考，T客邦是個好溝通、氣氛佳、愛學習的團隊，歡迎來應徵。

> 但是，若抱著「我什麼都不會，但是我願意學習」的心態來應徵，恐怕機會是比較小的。如果有心，應該會展現在「我在某某線上課程完成多少課」、「我做過這個那個 side projects」或「我有個技術筆記分享部落格」等結果上，如果跟你競爭的應徵者多少有這類的成果可參考，那結果...你知道的。
>
> 這部分還可以參考我的另一篇文章 [應徵 Rails 工作的心得]({% post_url tw/2014-02-26-my-experience-on-applying-rails-jobs %})。

## Rails 101 訓練

T客邦長期都使用 XDite 的教材 [Rails 101](https://leanpub.com/rails-101) 進行新人訓練，但一直有隨著時間進化，目前除了熟悉 Rails 功能、coding style，也會順便練習實際的工作流程。

* 使用 Rails 101 的題目，但會加上一些限制，例如不准使用 scaffold generator
* 負責帶新人的同事會用 Redmine 派票，也會要求養成回報到票上的習慣
* Git 分支策略採用 GitHub flow，branch 名稱也有命名原則
* 每個 PR 都會抓效能問題、不良的開發習慣、可改寫得更漂亮的地方與 coding style 等問題

這套練習還包含架設一台 Ubuntu server、用 Unicorn 跟 Capistrano 達到 zero-downtime deploy 等。

## 線上課程與文章

公司會要求的只有上述 Rails 101 的練習，其他的就只能看個人願意花多少時間學習/練習了。

所以觀看線上教學、閱讀 tutorial 或官方文件等都都是要自己去安排的。不過公司會補助一些線上課程的費用，例如 Code School, RailsCast, TeaLeaf 等。就算不在目前補助範圍內的，有需要的話也可以談。

另外就是工程師之間都會互相丟好文章連結、推薦不錯的書籍或 Leanpub 電子書等。最近復活的 [Techbang 技術部 粉絲頁](https://www.facebook.com/techonrails) 前 20 幾則文章基本上都是從頻道紀錄裡撈出來貼的。

## 追程式碼與查資料

由於 Techbang 的許多專案都累積幾年了，有些架構不直覺可能是有原因的，因此接到某些票發現解法不單純的話，有可能需要追某個功能的所有相關 code、翻那段 code 的 git 修改歷史紀錄、找出對應的票並搞清楚當初設計的原因、繞過或處理歷史包袱等等。

有些功能則是沒有前例可查，但可以用關鍵字找網路上的範例或構想、查官方文件想辦法兜出解決方案、研究別人的 open source project 是如何實做的等等。

讀別人的 code、上網找資源兜解法，常常可以學到很多技巧、探索一些之前不知道的 API、library 或工具。

>當然也不是派了票就放你自生自滅 ~~生命會自己找到出路~~ ，有遇到問題都可以提出來討論，工程師前輩或熟悉業務邏輯的 PM 會很樂意提供意見。
