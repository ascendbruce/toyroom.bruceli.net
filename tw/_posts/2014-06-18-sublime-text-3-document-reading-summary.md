---
layout: post
title: 讀 Sublime Text 3 文件學到的新招
published: true
date: 2014-06-18 02:15
tags:
- Sublime
categories: [tw]
comments: true

---
摸熟你的開發工具是很重要的，每天都用沒效率的方法做事，長期下來很浪費時間。最近我在看《[程式設計師提升生產力秘笈](http://www.books.com.tw/exep/assp.php/bruceli/products/0010429241)》一書，裡面當然也提到這個老生常談，剛好就卯起來把 [Sublime Text 3 官方文件](http://www.sublimetext.com/docs/3/) 看完了 (除了開發 API 章節)，這邊整理出一些我以前還不知道的好用技巧。

不過這份文件其實很短，每一節大概都只有一個螢幕長度而已，應該比較適合新手一開始就看。也就是說，設定部分還是要親自讀一遍 `Settings - Default`，快速鍵則建議讀[非官方文件](http://sublime-text-unofficial-documentation.readthedocs.org/en/latest/reference/keyboard_shortcuts_osx.html)，好用外掛或特殊設定則要搜尋看看，例如 [讓 Sublime Text 也擁有 "Navigate to Definition" 功能]({% post_url 2014-02-23-sublime-text-integration-with-ctags %}) 跟 [安裝 Sublime Text 3 互動式 Ruby Debug 外掛]({% post_url 2014-03-04-sublime-text-3-with-rails-debugger-tutorial %}) 其實從網路上找到提示才試出來的。

> 警語：《[程式設計師提升生產力秘笈](http://www.books.com.tw/exep/assp.php/bruceli/products/0010429241)》翻譯不太通順，如果弄得到英文版的話可考慮直接讀英文版。

## 多行選擇相關

一次選擇多行以後按 `Command+Shift+L` 即可把輸入點切成每行一個

用 `Command+D` 選擇 occurrences 時

* 不小心選多了可以用 `Command+U` 倒車
* 用 `Command+K,Command+D` 跳過某個 (剛選到的) occurrence
* 做完多行操作後，按 `Esc` 回到單輸入點模式

## 自動完成相關

* 由於 `ctrl+space` 在 mac 上會跟 spotlight 快捷鍵衝突，應改掉 ~~個人習慣改成 Command+/~~ 發現會跟 toggle comment 衝突，不過我發現我也很少手動 toggle 自動完成
* 出現自動完成選單時，按 `tab` 會自動完成，但若真的想輸入 tab 字元的話，可以用 `Shift+tab`

## Project

Sublime 有個 Project 選單，但好像不多人用，我也只亂玩過一下而已。但這次看到一個功能我覺得值得嘗試：

Settings 可以寫在 project 設定檔裡，這樣就可以讓所有人都使用相同的設定，例如 tab 轉 2 個 spaces、trim trailing space、newline at eof 等 coding style 問題。


## 過去不常使用快速鍵者

如果你有心想記起快速鍵，打開選單看到快速鍵提示後，關掉選單，用快速鍵做。浪費幾次時間以後就會記住了，接下來節省的時間絕對可以賺回來。(《程式設計師提升生產力秘笈》建議的方法)

也可以把常用又想記住的快速鍵印出來貼在座位旁邊，快速查找。（我之前用白板筆寫在玻璃 OA 隔板上）
