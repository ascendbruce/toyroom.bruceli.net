---
title: "追查「關於 delete_all 的 Bug」"
date: 2016-03-12 23:50
category: [tw]
tags: []
image: /images/posts/009-code-bug.jpg
excerpt: "has_many 沒有指定 dependent 的時候，使用 object.associations.delete_all，其行為可能會讓你有點意外"
---

has_many 沒有指定 dependent 的時候，使用 object.associations.delete_all，其行為可能會讓你有點意外

![cover]({{ "/images/posts/009-code-bug.jpg" | absolute_url }})

> Pic CC-BY by Guilherme Tavares <https://flic.kr/p/3AvBtV>

不經意看到這篇文章 [關於delete_all的Bug](http://kuro-sean-blog.logdown.com/posts/611685)，把他的 git repo 抓下來試試看，行為還真的如他所述，更加引起我的好奇，因此挖進去看一下。這篇是追查的結果，也順便把我追查的過程記錄下來。

### 注意到其輸出的 SQL 看起來像是在進行 Nullify

``` ruby
DEVELOPMENT [11] rails101(main)> @group.group_users.delete_all
  SQL (0.1ms)  UPDATE "group_users" SET "group_id" = NULL WHERE "group_users"."group_id" = ?  [["group_id", 1]]
nil
```

找了一下 [文件](http://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-delete_all) 卻是說 **"This is a single SQL DELETE statement that goes straight to the database"**，其 source code 看起來也符合其宣稱。根據文件裡提供的寫法試打看看，發現行為符合預期

``` ruby
DEVELOPMENT [12] rails101(main)> GroupUser.delete_all(group: @group)
  SQL (0.4ms)  DELETE FROM "group_users" WHERE "group_users"."group_id" = 1
0
```

看一下他們的 source code 來自何處

``` ruby
DEVELOPMENT [13] rails101(main)> GroupUser.method(:delete_all).source_location
[
    [0] "/usr/local/opt/rbenv/versions/2.2.2/lib/ruby/gems/2.2.0/gems/activerecord-4.2.5/lib/active_record/querying.rb",
    [1] 8
]
```

``` ruby
DEVELOPMENT [14] rails101(main)> @group.group_users.method(:delete_all).source_location
[
    [0] "/usr/local/opt/rbenv/versions/2.2.2/lib/ruby/gems/2.2.0/gems/activerecord-4.2.5/lib/active_record/associations/collection_proxy.rb",
    [1] 442
]
```

發現他們是來自不同檔案不同 methods:

* [rails/activerecord/lib/active_record/relation.rb](https://github.com/rails/rails/blob/a419a4d9ade48e777166ff956dd7bb24e37b2181/activerecord/lib/active_record/relation.rb#L453)
* [rails/activerecord/lib/active_record/associations/collection_proxy.rb](https://github.com/rails/rails/blob/a419a4d9ade48e777166ff956dd7bb24e37b2181/activerecord%2Flib%2Factive_record%2Fassociations%2Fcollection_proxy.rb#L442)

追進 `rails/activerecord/lib/active_record/associations/collection_proxy.rb` 的 source code，在 method 前面的註解裡發現以下說明：

>      # Deletes all the records from the collection according to the strategy
>      # specified by the +:dependent+ option. If no +:dependent+ option is given,
>      # then it will follow the default strategy.
>      #
>      # For +has_many :through+ associations, the default deletion strategy is
>      # +:delete_all+.
>      #
>      # For +has_many+ associations, the default deletion strategy is +:nullify+.
>      # This sets the foreign keys to +NULL+.

重點：

* 如果沒給 `dependent` option 的話，會使用 default strategy
* `has_many` 的 default strategy 是 nullify

也就是這個案例的狀況，因為原文提到 "要達成這個bug首先要把 has_many 的 dependent 參數拿掉"，且其 source code 的該 association 並未指定為 `has_many :through` (雖然照這幾個 tables 的開法應該是想要做 `has_many_and_belongs_to` 或 `has_many :through`？)

點進去 [Blame 介面](https://github.com/rails/rails/blame/a419a4d9ade48e777166ff956dd7bb24e37b2181/activerecord/lib/active_record/associations/collection_proxy.rb#L442)，找到以下幾個相關 commits：

1. [add CollectionProxy#delete_all documentation](https://github.com/rails/rails/commit/f9a718eb5e3fe969c3a01cf084c6686cc2ce7aff)
2. [Do not invoke callbacks when delete_all is called](https://github.com/rails/rails/pull/10604)
3. [Clarify deletion strategies for collection proxies](https://github.com/rails/rails/pull/17179)

其中第 2 個 PR 裡提到這樣的用法：

``` ruby
DEVELOPMENT [15] rails101(main)> @group.group_users.delete_all(:delete_all)
  SQL (0.1ms)  DELETE FROM "group_users" WHERE "group_users"."group_id" = ?  [["group_id", 1]]
nil
```

## 結論

這是個 feature...
