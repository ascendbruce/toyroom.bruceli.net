---
layout: post
title: 如何簡化「常常在 rails console 裡反覆輸入某些指令」的狀況
published: true
date: 2014-06-14 04:15
tags:
- rails
categories: [tw]
comments: true

---
開發的時候常需要在 rails console 下尋找一個 user 來做某些實驗，通常是用自己的帳號，因此就會每天都在敲 `user = User.find_by_email(自己的 email)`，很浪費時間，用這個技巧就可以改善此類問題。

## 解決方法

在家目錄底下建立 `.irbrc` (如果用 pry-rails，則是 `~/.pryrc`)

``` ruby
# ~/.irbrc
def find_me
  User.find_by_email("your_mail@example.com")
end
```

之後就可以在 rails console 下

```
[1] pry(main)> user = find_me
  User Load (0.3ms)  SELECT `users`.* FROM `users` WHERE `users`.`email` = 'your_mail@example.com' LIMIT 1
  ...
```

常在 rails console 下打的指令都可以考慮如何利用這個手法，但必須注意 method 命名不能跟現有專案的衝突。

> ps. 以前我會寫一支開發專用的 `app/models/dev.rb`，裡面有各種方便的 methods，但由於現在手上專案很多，每個都加一次很麻煩，其他人可能也不想共用這種手法，所以現在改採不會動到專案 code 的解決方案。
