---
layout: post
title: 如何簡化「常常在 rails console 裡反覆輸入某些指令」的狀況
published: true
date: 2014-06-14 04:15
tags:
- rails
categories: [tw]
comments: true
image: /images/posts/007-use-irbrc-to-save-time-with-rails-console.png?v=1
excerpt: 開發的時候常需要在 rails console 下尋找一個 user 來做某些實驗，通常是用自己的帳號，因此就會每天都在敲 user = User.find_by_email(自己的 email)，很浪費時間，用這個技巧就可以改善此類問題。

---

![](/images/world.png) English version: [Save your time in rails console by using irbrc to provide shortcuts for frequent commands]({% link _posts/2015-08-13-using-irbrc-to-serve-frequent-used-commands-in-rails-console.md %})


開發的時候常需要在 rails console 下尋找一個 user 來做某些實驗，通常是用自己的帳號，因此就會每天都在敲 `user = User.find_by_email(自己的 email)`，很浪費時間，用這個技巧就可以改善此類問題。

## 解決方法

在家目錄底下建立 `.irbrc` (如果用 pry 的話則是 `~/.pryrc`)

``` ruby
class Dev
  def self.me
    User.find_by_email("your_mail@example.com")
  end
end
```

之後就可以在 rails console 下

```
[1] pry(main)> user = Dev.me
  User Load (0.3ms)  SELECT `users`.* FROM `users` WHERE `users`.`email` = 'your_mail@example.com' LIMIT 1
  ...
```

常在 rails console 下打的指令都可以考慮如何利用這個手法，但必須注意命名不要跟現有專案的衝突。

> p.s. 以前我會寫一支開發專用的 `app/models/dev.rb`，裡面有各種方便的 methods。但後來手上專案很多，每個都加一次很麻煩，且同事可能不想共用這種手法（加上 email 不同），所以放在自己的 `~/.pryrc`。
