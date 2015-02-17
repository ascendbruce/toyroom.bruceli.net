---
layout: post
title: Ruby on Rails x Mac OSX 10.9 Mavericks 環境安裝步驟
published: true
date: 2013-12-22 12:45
tags:
- rails
categories: []
comments: true

---
之前「[很久沒維護](http://ascendbruce.logdown.com/posts/159954-mac-rvm-install-ruby-problem-solving-log)」的那台，後來終於生氣重灌成 Mavericks 了。這邊記錄一下 Rails 環境設定過程。

這篇的原則是：有 GUI 就用 GUI，有官方安裝指令就用官方的。

Rails 環境以外的設定還可以參考我的 [個人環境設定 Memo](https://github.com/ascendbruce/personal-settings)，持續更新中。

# 要裝的東西與順序

有些的順序非常重要，所以沒事就照順序裝吧！

1. 工具、套件管理 (GCC, Homebrew)
2. ImageMagic
3. MySQL
4. RVM and Rubies
5. Rails
6. Pow

# 1. 工具、套件管理

## XCode Command Line tool

也可以安裝完整版的 XCode，但我用不到那麼多東西。

很直覺的裝法是直接在 Terminal 打

    gcc

他會問你要不要安裝，按 Install 就會安裝了 [參考](http://railsapps.github.io/installrubyonrails-mac.html)

## Homebrew

到 [Homebrew 官網](http://brew.sh/) 找最新的安裝指令，目前的指令如下。（使用 Mavericks 內建的 Ruby 2.0）

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

安裝好以後

    brew update
    brew tap homebrew/dupes

2013/12/26 補充：可以用 homebrew 自我檢測，看有缺啥盡量滿足它

    brew doctor

## 有的沒的套件

一些可能會用到的套件

    brew install autoconf automake libtool libyaml readline libksba openssl

傳統 GCC 這邊我不是很確定怎麼回事，因為手邊也沒有機器可以重新實驗。我整理目前的猜測如下：

1. 如果只裝 ruby 2.0 以上 => 不用管這步
2. 如果要裝 ruby 1.9.3 => 要裝 `gcc46`

>     brew install gcc46
>
> 如果沒有裝，到時候安裝 ruby 1.9.3 時，rvm 會嘗試幫你裝 `gcc46`

另外，其實我一開始是參考 [這篇](http://www.computersnyou.com/2673/2013/10/install-ruby-rails-macos-x-mavericks-10-9-mysql-step-step/)，所以我還有裝 `gcc49`，但應該是沒用到。

# 2. ImageMagick

先安裝 [XQuartz](http://xquartz.macosforge.org/landing) (X Window 支援)

然後

    brew install imagemagick

# 3. MySQL

    brew install mysql

新版會自動幫你做 `mysql_install_db`，剩下的就是依照指示，執行這兩行（用途也寫在指示上）

    ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

以及設定所需帳號密碼，這部份可利用 [Sequel Pro.app](http://www.sequelpro.com/download) 設定

# 4. RVM and Rubies

> 後來才發現 Anvil 能幫忙裝 Pow，說不定 JewelryBox 也可以幫裝 RVM，有勇者的空機幫忙試試看嗎 XD

到 [RVM 官網](https://rvm.io/) 找最新的安裝指令，目前是

    \curl -sSL https://get.rvm.io | bash -s stable

驗證
    
    source ~/.profile
    rvm -v

之後利用 [JewelryBox](https://jewelrybox.unfiniti.com/) 安裝 Rubies。

# 5. Rails

找一個現成的 Rails 小 Project

    bundle install

就會把 Gemfile 裡面指定的 Rails 版本裝起來。

並跑起來看看

    rails s

(沒有現成 Project 的話就先安裝個 rails 版本，然後用 scaffold 快速刻一個來確認執行狀況囉)

# 6. Pow

安裝 [Anvil](http://anvilformac.com/)，第一次使用時就會自動幫你裝（但是要輸入密碼），並設定剛才試跑過的網站。

如果要手動裝也可以，到 [Pow 官網](http://pow.cx/) 找最新的安裝指令。

由於我拿來試跑的 project 以前不是用 pow 管理，所以要依照 [官方 Troubleshooting](https://github.com/37signals/pow/wiki/Troubleshooting#rvm-and-gemfile) 補上 .powrc。

結論：我的環境貌似 OK 了，可喜可賀！

# 參考

* http://railsapps.github.io/installrubyonrails-mac.html
* http://dean.io/setting-up-a-ruby-on-rails-development-environment-on-mavericks/
* https://github.com/xdite/blog/blob/master/source/mac-lion-xcode-ruby-rails-192/index.markdown
* http://www.computersnyou.com/2673/2013/10/install-ruby-rails-macos-x-mavericks-10-9-mysql-step-step/
