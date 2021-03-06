---
layout: post
title: Sublime Text ERB end[tab] 自動完成的關鍵字衝突問題
published: true
date: 2014-12-10 02:44
tags: []
category: [tw]
comments: true

---
本來想寫一篇部落格文講這個問題的，但寫到一半跑去開 PR 給 [ERB-Sublime-Snippets](https://github.com/matthewrobertson/ERB-Sublime-Snippets) 增加說明，就這樣被接受了。

因此請看 ERB-Sublime-Snippets > README > [Resolve conflicting tab trigger](https://github.com/matthewrobertson/ERB-Sublime-Snippets/blob/master/README.md#resolve-conflicting-tab-trigger) 小節。

主要的問題點是，我同時裝了 [ERB-Sublime-Snippets](https://github.com/matthewrobertson/ERB-Sublime-Snippets) 跟 [Rails Developer Snippets](https://github.com/j10io/railsdev-sublime-snippets) 這兩個 packages，再加上內建的 Rails package，他們有幾個 tab 自動完成關鍵字是相同的，其中最常遇到的就是 `<% end %>` 了。

解決方法就如連結裡所寫。

另外，我仍然 fork 了自己的 ERB-Sublime-Snippets 版本 (<https://github.com/ascendbruce/ERB-Sublime-Snippets>)，原因是作者不接受 `erp` 跟 `erc` 這兩個關鍵字 (預設的是 `er`, `pe` 跟 `pc`)。我個人是覺得 `erp`比 `pe` 較直覺啦，所以... 歡迎使用，不過我還沒更新 README 的安裝教學，可以先參考 [這個](https://github.com/ascendbruce/sublime-tomorrow-theme#install)。
