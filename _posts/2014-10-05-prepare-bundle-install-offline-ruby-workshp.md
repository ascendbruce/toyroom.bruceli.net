---
layout: post
title: workshp 的斷線備案 - 離線 bundle install
published: true
date: 2014-10-05 02:50
tags:
- ruby
- rails
categories: []
comments: true

---
之前準備在 [Rails Pacific](http://railspacific.com/) 上帶的 [Refactoring workshop]({% post_url 2014-10-01-refactoring-workshop-supplement-rails-pacific-2014 %}) 時，想到以前參加 conference 時 wifi 通常都很不穩，因此有先想一下斷網備案。

> 但 Rails Pacific 2014 的現場網路很穩（感謝中午吃飯時間還在架設網路的小蟹），這招不但沒用到，而且還有幾位遇到 nokogiri 裝不起來的問題。

## 如何離線 bundle install

簡單來說就是用

    bundle package

把 gems 放到 `vendor/cache` 裡。之後透過 usb 碟等離線方式 copy 給別人後，請他跑

    bundle install --local

詳細的設定與原理可參考官方文件 [bundle package](http://bundler.io/bundle_package.html)

但不同作業系統可能會不相容，有些 gem 像 nokogiri 可能也無法只靠這樣安裝，應該避免使用。這次 workshop 是因為最後一題的測試使用到了 capybara，又因為生病沒有注意到而沒排除掉。

以上，提供給要帶 ruby 相關 workshop 但擔心網路問題的人參考，這只是很陽春的記錄，也許您有更完整的備案準備方式，歡迎留言指教 m(_ _)m
