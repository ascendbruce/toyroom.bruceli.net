---
layout: post
title: 安裝 Sublime Text 3 互動式 Ruby Debug 外掛
published: true
date: 2014-03-04 05:30
tags:
- rails
- Sublime
categories: []
comments: true

---
最近發現 [sublime_debugger](https://github.com/shuky19/sublime_debugger) (在 Package Control 裡叫 "Ruby Debugger") 這個外掛，是我一直非常期待的功能之一：

**類似 Visual Studio 的強大互動式 Debug 介面**

## 背景

不知道有多少人玩過類似這樣的東西：

![debugger in command line](https://lh4.googleusercontent.com/-kcdc_iOvp_8/UxMesUhLqbI/AAAAAAAABrA/pxzil8igKA0/w1089-h711-no/debug_01_command_line.png)

在 [Rails Guides - Debugging Rails Applications](http://guides.rubyonrails.org/v3.2.14/debugging_rails_applications.html) 裡就有收錄類似工具的教學，但可能是因為文字介面，功能又很多，感覺好像很複雜，導致很多人都不願去用它。

現在有整合到 Sublime Text 3 的外掛，當然要開始孜孜不倦的推坑了（？）

這篇是入門教學，如果你用起來覺得不錯，可以看 [sublime_debugger 的 README](https://github.com/shuky19/sublime_debugger)、[Rails Guides 的 Debugging Rails Applications 篇](http://guides.rubyonrails.org/v3.2.14/debugging_rails_applications.html) 來了解更多。

（寫這篇的時候，sublime_debugger 才三個月大，但目前已經有堪用的版本，而且作者也持續開發中。我自己測過 Ruby 1.9.3 + Rails 3.2 與 Ruby 2.0.0 + Rails 4.0 都沒問題）

## 安裝

### 安裝指定的 debugger gem

* Ruby 1.9.3 => `gem install debugger`
* Ruby 2.0.0 => `gem install byebug --version '>=2.5.0'`

也可以加到 `Gemfile` 並跑 `bundle install`

### 透過 Package Control 安裝 `Ruby Debugger` 外掛

* 目前 `Ruby Debugger` 外掛只支援 Sublime Text 3（在 Mac 上可跟 Sublime Text 2 並存）
* 如果你的 Sublime Text 3 還沒有安裝 [Package Control](https://sublime.wbond.net/installation)，請先安裝
* 透過 Package Control 安裝 `Ruby Debugger` 外掛

## 使用

開始 debugging rails（Start debugging 則是對純 ruby 檔案 debug）

![start debugging](https://lh5.googleusercontent.com/-ou6IHcrsh9E/UxMesS-7lcI/AAAAAAAABq8/0887YBecBoQ/w1090-h714-no/debug_02_debug_rails.png)

等幾秒後，會看到 Output 視窗出現開啟 web server 的熟悉訊息。需注意如果你的 project 很大的話，這邊的啟動會非常久，第一次試用可以先找小 project 來玩。

另外，按 `F9` 可以設定 break point (中斷點)，不想記快速鍵的話，右鍵選單裡也有。

![start up server and break point](https://lh6.googleusercontent.com/-NnAGLHCrfu4/UxMesU-mouI/AAAAAAAABrE/yucRa4hFbIg/w1090-h714-no/debug_03_breakpoint.png)

一些常見問題:

* 有些版本會在這步停在 rails 啟動的 code，此時就 `F10` 一路執行過去，直到讓他順利開啟 web server。
* 如果你已經在 port 3000 自己開了 server 就會衝到，請把自己開的 web server 關掉。
* sublime_debugger 目前仍有不穩的狀況，有時候 web server 會卡在那邊關不掉。遇到這種狀況可以把佔用 port 3000 的 process 找出來並砍掉。或直接 `killall ruby` 並一一重開。
* 如果有遇到其他問題，除了試試看重開，也可以搜尋一下有沒有相關 issue 討論。

接下來，切到瀏覽器，瀏覽會觸發 break point 的頁面：

![stopped at break point](https://lh4.googleusercontent.com/-bAemF_GNml4/UxMes1eMoDI/AAAAAAAABrY/Q0fKRFyixAI/w1090-h714-no/debug_04_stop_at_breakpoint.png)

> (在這個例子裡，`/home` 是指到 `videos#index`)

接下來你就可以用 `F10` (Step Over)、`F11` (Step Into) 來逐行執行。
由於 `F11` 是 Show Desktop 的快速鍵，如果你的 Mac OS X 版本有預設開啟的話，記得去把它關掉。

![don't forget to disable F11 mission control hotkey](https://lh3.googleusercontent.com/-Y4pKcL8rmFU/UxMeu-hZyWI/AAAAAAAABr4/xxA6QKcPhIw/w668-h598-no/debug_14_disable_f11.png)

除了逐行執行，還有一些常用的功能，例如持續監看某指令的執行結果：

![watch](https://lh5.googleusercontent.com/-vqH_mf6AmRs/UxMetGbwqFI/AAAAAAAABrc/Gbk6xG4_VU0/w1090-h714-no/debug_05.gif)

現在 `category` 的執行結果是錯誤（因為執行到這行的時候，的確還沒有定義 `category`）。那麼現在我們跳進迴圈：

![run until cursor](https://lh4.googleusercontent.com/-ovo7EJzGI64/UxMetXN5s0I/AAAAAAAABrU/CqsXvCdlEe8/w1090-h713-no/debug_06_run_until_cursor.png)

此時就抓到 `category` 了

![stopped and watched value has changed](https://lh5.googleusercontent.com/-kN-9QeyZWiE/UxMet3n5zdI/AAAAAAAABro/cjiTlQuhI8Q/w1090-h714-no/debug_07_watch_value_changed.png)

> tips: 底下的視窗預設不會自動換行，要開啟可以用 `cmd`+`shift`+`p` 並執行 `Word Wrap: Toggle`

Immediate (即時執行) 也是很常用的功能

![immidiate](https://lh4.googleusercontent.com/-0hST2aCajeQ/UxMevaaM86I/AAAAAAAABsE/w9MkgS-vlqg/w1090-h714-no/debug_10.gif)

其他還有 Locals (區域變數列表)、Stack 等功能，這邊就不介紹了。

再來是「善後」：

![stop debugging](https://lh5.googleusercontent.com/-O0wW07VnSSs/UxMevHFCqKI/AAAAAAAABsA/WhfuBoF8F78/w1090-h714-no/debug_15.gif)

還有一點值得一提，debugger 不僅可以拿來 debug，還有一個很棒的價值：

## 追別人的 code

有時候維護別人的 code、用別人的 gem，甚至是剛學程式的人，無法理解為什麼會跑出某種不符預期的結果時，就可以用 debugger 跑一遍，很直覺、好理解、也可以很詳細的查看變數狀態。

實際上我高職初學程式時，就很常玩 VB 6.0 IDE 的這個功能，幫助我瞭解控制流程的基本觀念很多。在前一篇 [應徵 Rails 工作的心得](http://ascendbruce.logdown.com/posts/178895-my-experience-on-applying-rails-jobs) 也提到，即使高職讀資處科，也不見得每個人都會認真學程式，光是課堂上、模擬考出現的，都遠遠不及親自動手玩來得有幫助。

![you can trace into gems](https://lh3.googleusercontent.com/-OZyb7SJe7E8/UxMeuDlgVGI/AAAAAAAABrw/RuJeOUE7eQw/w1090-h714-no/debug_13_look_into_rails.png)

在 [Rails Guides](http://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debugger-gem) 也有提到類似的點

> The debugger can also help you if you want to learn about the Rails source code but don't know where to start.

現在就把 sublime_debugger 裝起來玩玩吧 \\(☉▽☉)/
