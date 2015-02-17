---
layout: post
title: 寫給新手的 升級 Rails 3.0.x 到 Rails 3.2.x 教學與基本觀念
published: true
date: 2013-11-09 13:56
tags: []
categories: []
comments: true

---
今天去幫一個朋友升級他們公司的專案 (從 Rails 3.0 到 3.2，別懷疑，現在還有公司在用更舊的)，之前我自己更新時沒有寫成部落格文，所以就順便寫起來囉。

這篇的目標對象是「有 Rails 基礎，但未曾成功升級舊有 Rails Project 者」，如果你已經有升級經驗、或對 Rails 了解很夠，也許你用不著這篇教學。

升級一個 Rails Project 分成三大部分：

1. 升級 Rails 框架本身
2. App 必要的改寫 (修正已經不支援的語法)
3. 外掛也要能支援新版 Rails

在開始之前，請先把目前專案的狀態進行到一個段落，不要有那種寫到一半的 feature，確認整個專案是可正常運行後才升級。用不到的東西想砍掉可以先砍掉，或者升級過去後再刪除，但不要一邊升級一邊把用不到的東西丟掉，否則發生錯誤時你很難鎖定是什麼原因造成的。

接下來講解升級方式。

## 1. 升級 Rails 框架本身

### 修改 Gemfile 宣告要用的 rails 版號

``` ruby Gemfile
gem "rails", "3.2.15"
```

並跑

    bundle update rails

當然沒有這麼簡單就結束了

### 抽換 config 們

想像一下一個乾淨剛產生的 Rails 3.0.0 專案，跟一個乾淨的 Rails 3.2.15 的專案，Rails 本身的 code 是透過 Gem 管理的，那麼兩個專案的差別就在於 config 檔裡的可設定的參數、預設值等，以及一些目錄位置不同。

官方的 [A Guide for Upgrading Ruby on Rails](http://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html) 有依序告訴你新增、刪除以及要修改的檔案，但我照這個 guide 卻做不成功，可能是我漏掉了什麼就過不去。

所以我當時是產生兩個乾淨的專案，並用軟體做 diff (例如 [Kaleidoscope](http://www.kaleidoscopeapp.com/))，找出不同的地方，依序修改就可以了。後來發現有人做了 [RailsDiff](http://railsdiff.org/) 專案，可以任選兩個 Rails 版本進行 diff，就更方便啦！

但需注意幾件事情，新手可能會犯的錯：

* 有刪除掉的東西也一定要刪掉，否則可能過不去
* 方向不要搞錯，如果恍神把舊版的設定檔複製到新版去，當然會跑不動
* 如果自己生兩個 projects 來 diff 的話，需注意 App 名稱要一致，否則會有好幾個設定檔裡的名字不一樣。(用 RailsDiff 的不用擔心這件事)

想建立信心的話，可以先開兩個新舊版本的乾淨 projects，用 `scaffold` 做一個陽春的留言板，然後練習升級。因為環境相對的單純，會比較容易成功，別忘記一邊做筆記起來。

## 2. App 必要的改寫 (修正已經不支援的語法)

這部份就比較需要看版本遇到的問題，見招拆招，沒有 SOP。不過動手之前可以先搜尋一下其他人的升級筆記。

Rails 3.0 到 3.2 大概比較會遇到以下問題：

### 找不到來自 `lib` 資料夾裡面的內容

解法：

* 使用之前先 `require "xxx"` (只要主檔名 不包含 `lib/` 跟結尾 `.rb`)。
* 或把 `lib` 加到 `autoload_paths`，或寫一個 initializer 在裡面 require (不推薦)

### [新增、更新時出現 Mass Assignment 錯誤](http://net.tutsplus.com/tutorials/ruby/mass-assignment-rails-and-you/)

之所以有這項修改，主要原因是 [Github 被駭](http://blog.xdite.net/posts/2012/03/05/github-hacked-rails-security/)。

解法：

* 要開放的欄位全部放到 `attr_accessible`
* 或者直接關掉保護機制 (不推薦)

``` ruby config/application.rb
# ...
config.active_record.whitelist_attributes = false
# ...
```

### [Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html)

解法：

* 改用 Asset Pipeline，請看 Rails Guides [The Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html) 章節
* 或者直接關掉 Asset Pipeline (不推薦，但要改的東西很多，所以比較可以暫時妥協)

``` ruby config/application.rb
# ...
config.assets.enabled = false
# ...
```

## 3. 外掛也要能支援新版 Rails

Rails 重大更新後，很多 Gems 可能都還沒更新，會遇到外掛 Gems 爆炸的狀況。

如果你並非經驗豐富的 Rails Developer，要自己去寫改寫甚至 hack 外掛，會比較困難，而且也不在本篇的討論範圍內，解決辦法就是 **重大更新** 剛出時還不要馬上更新囉。 ~~逃避現實~~
