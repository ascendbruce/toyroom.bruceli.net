---
layout: post
title: 讓 Sublime Text 也擁有 "Navigate to Definition" 功能 (設定 CTags)
published: true
date: 2014-02-23 08:09
tags:
- dev
- Sublime
category: [tw]
comments: true
image: http://user-image.logdown.io/user/82/blog/82/post/179064/WK22LRuEQWau88zDMUD7_ctags_jump.gif
---

## 欲達到的功能

![ctags_jump.gif](http://user-image.logdown.io/user/82/blog/82/post/179064/WK22LRuEQWau88zDMUD7_ctags_jump.gif)

註：本篇適用於 Mac，若用 Linux 請依照 Distribution 尋找適用的安裝指令 (apt, yum, ...)，Windows 很久沒用了不瞭解安裝方式。

## 安裝

### 用 Homebrew 安裝 ctags

Mac 內建的 ctags 不支援 recursive 資料夾搜尋 (-R 選項)，因此根本不符合需求。

> 如果遇到類似 "illegal option -- R" 的錯誤訊息，很有可能是因為吃到內建的 ctags。

先跑 Homebrew 自我檢測工具，盡量排除警告訊息

``` bash
brew doctor
```

安裝 ctags

``` bash
brew install ctags
which ctags # 應該出現 /usr/local/bin/ctags
```

如果裝好後 ctags 還是吃到內建的 `/usr/bin/ctags` ，需注意你的 `$PATH` 的順序是否正確。

### Sublime Text 安裝 CTags 外掛

如果你的 Sublime Text 還沒有安裝 [Package Control](https://sublime.wbond.net/installation)，請先安裝。

1. `cmd`+`shift`+`p` 叫出指令框
2. 搜尋 "Package Control: Install Package" 並按 `Enter` 執行
3. 搜尋 "CTags" 並按 `Enter` 安裝

### 設定

如果 Sublime 還是吃不到 homebrew 的 ctags，可以強制指定

選單 Sublime Text > Preferences > Package Settings > Ctags > Settings - User

``` ruby
{
  "command": "/usr/local/bin/ctags", # 可以在這行指定 ctags 路徑
  "autocomplete": true               # 順便利用 ctags 來做 autocomplete
}
```

### 建立/更新 索引檔

如圖所示

![ctags_rebuild2.png](https://lh6.googleusercontent.com/-Nr27Hm4LWyU/UwjQu8icQ8I/AAAAAAAABqc/il-aXEUBGAs/w1073-h804-no/ctags_rebuild2.png)

如果你習慣，也可以透過 `cmd`+`shift`+`p` 下 Rebuild 指令。

到這裡已經可以使用 "Navigate to Definition" 的功能了，但再加上一些設定會更好。

## 進階設定

### 設定 git ignore

首先要說一件事，如果你從 command line 自己下 `ctags` 指令時，預設檔名是 `tags`。但由於 `tags` 也是很常見的名稱，常常造成衝突，因此現在大多習慣用 `.tags` 取代之，Sublime CTags 外掛也遵循這個慣例。

各 project 一一放到 `.gitignore` 也可以，但通常大家手上都很多 projects，而且基本上很少有與 `.tags` 名稱衝突的檔案，因此我直接設到 gitignore_global。

如果你還沒有 `.gitignore_global` 檔案，請先設定，詳細可參考 [Ignoring files](https://help.github.com/articles/ignoring-files)

    git config --global core.excludesfile ~/.gitignore_global

`~/.gitignore_global` 的寫法基本上就跟各 project 下的 `.gitignore` 寫法一樣，但這個會跨 projects。

在裡面加入：

    /.tags
    /.gemtags
    /.tags_sorted_by_file

### 讓 sublime 搜尋關鍵字時不要找 .tags 的內容

由於 .tags 也是純文字檔，全 project 搜尋時也會找到其內容，而且因為是 `.` 開頭，通常都蠻前面的，有點惱人。因此用 User Preference 將這幾個檔案排除，除了搜尋不到，也會從左側檔案列表內消失。

選單 Sublime Text > Prefences > Settings - User

``` ruby
{
  # ...,
  "file_exclude_patterns": [".tags", ".tags_sorted_by_file", ".gemtags"],
  # ...
}
```

### 讓 ActiveRecord 的 scope 也可以被定位

> 註：這是針對 Rails 的功能。
> 參考自 [Add ActiveRecord scopes to Ctags](https://coderwall.com/p/ycql_q)

因為 ctags 預設只會抓真正的 methods，預設不會抓 scope，因此要自行追加設定，在 terminal 內：

``` bash
echo '--regex-ruby=/^[ \t]*scope[ \t]*:([a-zA-Z0-9_]+)/\1/' >> ~/.ctags
```

之後 rebuid 各專案的 ctags 就抓得到了

### 追到 gems 的 source code 裡去

註：這是針對 Ruby/Rails 的功能。

在 project 根目錄執行

``` bash
ctags -R -f .gemtags $(bundle list --paths)
```

這招參考自 [ctags in Rails project](https://coderwall.com/p/du_sgq)，裡面提到可以做成 alias，但我這麼做並執行完，老是會跳到最後一個 gem 的目錄，還不知道怎麼解。

雖然有人把這個作法直接包一層取代 ctags 指令，但相關方法我設定失敗，加上考慮到這麼做會讓每次 rebuild 都會花很多時間在沒有變動 (gems) 的 code 上，因此我沒有採用。

有興趣的話，可以看看

* [官方提供的作法](https://github.com/SublimeText/CTags#usage)
* [官方作法加強版](http://thunderboltlabs.com/blog/2013/11/19/efficiency-with-sublime-text-and-ruby/) (這個方法我設定不成功)

我最後的方案是：

* Sublime Text 用 `/usr/local/bin/ctags`
* 若想更新來自 gems 的內容，在 Project 目錄下執行 `ctags_ruby_enhance`

檔案: ctags_ruby_enhance (放在 PATH 可吃到的目錄下)

``` bash
#!/bin/bash

/usr/local/bin/ctags -R -f .tags .

if [ -f ./Gemfile ]
  then
    /usr/local/bin/ctags -R -f .gemtags $(bundle list --paths)
fi
```

每小時自動 rebuild，在 crontab 裡加入類似

    @hourly cd $HOME/Projects/xxx; /usr/local/bin/ctags_ruby_enhance >> $HOME/Projects/xxx/log/ctags.log 2>&1

(這個段落有重寫過)

## 其他

### 鍵盤快速鍵

請參考 [官方文件 Commands Listing](https://github.com/SublimeText/CTags#commands-listing) 段落

或照老方法設定 key binding

### 你用的 Theme 是什麼？

* Theme 是 `Theme - Nexus`，可以透過 Package Control 找到。
* Color Scheme 是 `Theme - Nil / Tubnil`，不過我最近的新歡是 `Tomorrow Color Scheme / Night Bright`，都可以透過 Package Control 找到。

### 你的側欄的右鍵選單好像多出很多功能？

安裝 `SideBarEnhancements`

以上

最近還玩了一下 sublime_debugger：sublime 跟 ruby-debugger/byebug 整合，做到類似 Visual Studio 的強大 debug 功能（擁有 break point、逐行執行、區域變數列表、immediate evaluate 等等功能），如果有空的話希望也能寫成一篇啊啊啊啊啊啊

> * 2014-03-04 UPDATE: 已寫 => [安裝 Sublime Text 3 互動式 Ruby Debug 外掛]({% link _posts/2014-03-04-sublime-text-3-with-rails-debugger-tutorial.md %})
