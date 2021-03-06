---
layout: post
title: 避免 pow 動不動就很長等待時間、以及 pow 如何跟 spring/zeus 合作
published: true
date: 2014-06-24 07:25
tags:
- rails
- pow
category: [tw]
comments: true
excerpt: 因為我手上有幾個肥大的 projects，啟動時間可以到達 60 秒以上，而 pow 預設每 15 分鐘就會 kill 掉 idle 的 app，於是動不動就要等 60 秒啟動，很浪費時間。如果你只是苦於每一段時間就要等啟動很久，這個方案是最簡單的方法：延長 timeout。
---
## 避免 pow 動不動就很長等待時間

### TL; DR;

在 Terminal

    echo "export POW_TIMEOUT=36000" >> ~/.powconfig
    # 或你想自己 vim ~/.powconfig 開來編輯也可
    touch ~/.pow/restart.txt

參考 [Pow 文件 - 3. Configuring Pow](http://pow.cx/manual.html#section_3)

### 為什麼要做這件事

因為我手上有幾個肥大的 projects，啟動時間可以到達 60 秒以上，而 pow 預設每 15 分鐘就會 kill 掉 idle 的 app，於是動不動就要等 60 秒啟動，很浪費時間。

如果你只是苦於每一段時間就要等啟動很久，這個方案是最簡單的方法：延長 timeout。

最開始的設定範例中

>     export POW_TIMEOUT=36000

的時間單位是秒。我的想法是上班時間是 8+1 小時，所以再長一點基本上就沒問題了， ~~每天早上來只要把所有頁面打開（我集中在一個 bookmark folder），一整天都可以快樂的使用不必等~~ 這樣會很佔記憶體，所以還是只開有用到的吧。

必要的時候還是可以用原本的方法重新啟動 app (`touch tmp/restart.txt`, `powder restart` 或用直接用 [Anvil](http://anvilformac.com/))。

## pow 如何跟 spring/zeus 合作

> 之所以有這個段落是因為我一開始以為解決等待時間必須用 rails preloader，後來才發現可以延長 timeout。

很不幸的，目前 pow 跟 spring/zeus 合作並不方便。不過某些情境仍是有好處的，以下說明：

### 讓 pow 的網址改連到 rails s 打開的 server

如此一來就可以披著 xxx.dev 的網址，實際上連到 `rails s -p 3000` (或其他 port) 開好的 server。

參考 [pow manual - 2.1.4 Port Proxying](http://pow.cx/manual#section_2.1.4)：

1. `cd ~/.pow/`
2. `rm project_name` 把你原本的 link 移掉
3. `echo 13001 > project_name` 把想用的 port 寫到原名的檔案裡
4. cd 到你的 project 目錄
5. `rails s -p 13001`

需注意如果你有多個 projects，必須自己管理網址跟 port 的對應。

port 我選用 13001~13050，原因是依照 [Wikipedia 的 List of TCP and UDP port numbers](http://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers) 來看，這段比較有名的應用是 Second Life，然而現在很少人在玩 (我玩過一陣子)。

#### 優點

* 可以直接 `binding.pry`

#### 缺點

* 必須自己管理 port 對應
* 必須自己啟動 rails s
* 如果 zeus 或 terminal app crash，你需要手動刪除 `.zeus.sock` 跟 `tmp/pids/server.pid` 才能順利再啟動
* 如果你手上有 5 個站、而且還會互打 API，上面三點就會非常麻煩了（每次重開或 crash 就要處理 5~10 個 tabs）

### spring 的問題

spring 的問題是它根本沒有 preload `spring rails s` ([issue 72](https://github.com/rails/spring/pull/72))，所以跟 `rails s` 意思是一樣的。

附帶一提，關於到底該用 `spring rails` 還是 `bin/rails`，[spring/README](https://github.com/rails/spring/blob/master/README.md#use-without-adding-to-bundle) 裡其實有提到：

> If you don't want spring-related code checked into your source repository, it's possible to use spring without adding to your Gemfile. However, using spring binstubs without adding spring to the Gemfile is not supported.
>
> To use spring like this, do a gem install spring and then prefix commands with spring. For example, rather than running bin/rake -T, you'd run spring rake -T.

簡單來說就是你如果不寫進 Gemfile，就必須用 `spring rails`。

### zeus 的問題

zeus 需要兩個 terminal app tabs，一個開 `zeus start` 另一個跑 `zeus s -p 13001`，所以你如果有 5 個主要 projects，就要為了這件事開 10 個 tabs...

另外雖然動到 config 時 zeus 本身會自動重開，卻不會重開 `zeus s`，所以你還是要手動 `ctrl+c` 關掉重開。據說以前會自動處理，不曉得這是 bug 還是 feature...

唯一的好處可能是動到 config 的時候，重開 `zeus s` 還是比 `rails s` 或 pow 重開快一點。

如果你手上的專案不多，想採取這個方案的話，我嘗試過這樣的技巧：

    echo "13001" > .pow_port    # 把要用的 port 寫到專案根目錄
    zeus s -p $(more .pow_port) # 以後只要下同樣的指令就可以打開

但還不夠完美，有需要的話可以再想想怎麼改善。也歡迎留言回報你的解法囉！

## 結論

* 如果你手上有很多肥大 projects，可以用延長 timeout 來節省時間
* 如果你很常用 pry 來 debug，但覺得 `binding.remote_pry` 不好用的話，用 Port Proxying 解法可以維持 xxx.dev 的網址且可用 `binding.pry`

UPDATE:

* https://www.facebook.com/chitsaou/posts/10152295146078580 裡面有 foreman (Procfile) 與 tmuxinator 解法的討論
* 發現 timeout 解法的副作用：記憶體佔用很多
