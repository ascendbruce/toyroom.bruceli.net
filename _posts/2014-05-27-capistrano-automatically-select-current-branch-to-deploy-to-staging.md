---
layout: post
title: Capistrano 自動選擇當前 branch deploy 到 staging
published: true
date: 2014-05-27 16:55
tags:
- rails
categories: []
comments: true

---
一般 config/deploy/staging.rb 的 branch 內容可能會設定成如下：

``` ruby
# config/deploy/staging.rb
# ...
set :branch, "staging"
set :rails_env, "staging"
# ...
```

我們團隊使用 [GitHub Flow](http://scottchacon.com/2011/08/31/github-flow.html)，常常會 deploy 非 master 的 branch 到 staging 上。照上面的 config 設定，要麻把 `staging` branch reset 到目前的 commit (很麻煩)，不然就是把 `set :branch` 改成當前的 branch 名稱、但不 commit。

但即使如此，還是很麻煩，而且有時候會忘記改。

搜尋 & 嘗試了一下，最後我改成：

``` ruby
# config/deploy/staging.rb
# ...
set :branch, ENV["BRANCH"] || `git rev-parse --abbrev-ref HEAD`.chop
set :rails_env, "staging"
# ...
```

其中

    `git rev-parse --abbrev-ref HEAD`.chop

可以丟到 rails console 執行看看，就是取得當前的 git branch name

這樣設定以後，只要在 terminal 下：

    cap staging deploy

就會自動選擇當前的 branch 來 deploy 了（production 則當然保持 `"master"` 不改）。

另外，若有一些情況想要「在這個 branch 但 deploy 那個 branch」的話，可以：

    BRANCH=other_branch cap staging deploy

這個技巧在 capistrano 2 跟 3 都適用。

2014-09-29 更新：Capistrano 不知道從何開始範例檔有以下的 code，與上面取得 branch 名稱的解法意思差不多，但使用 `chomp` 的確是比較好的習慣。

    proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
