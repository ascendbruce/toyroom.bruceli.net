---
layout: post
title: Rails 打基礎 - Rails Guides 3.2.13 閱讀筆記 Part 2
published: true
date: 2013-12-08 11:55
tags:
- rails
categories: [tw]
comments: true

---
接續 [Rails 打基礎 - Rails Guides 3.2.13 閱讀筆記 Part 1]({% post_url 2013-09-23-rails-guides-reading-notes-first-4-chapters %})

## [Active Record Query Interface](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html)
### find_each 與 find_in_batches
*來自 [1.3 Retrieving Multiple Objects in Batches](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#retrieving-multiple-objects-in-batches)*

find_each 用起來跟 each 差不多，但預設一次只會從 DB 撈 1,000 筆，尤其當資料多起來以後，直接下 `User.all` 會很吃記憶體。

``` ruby
User.find_each do |user|
  NewsLetter.weekly_deliver(user)
end
```

`find_in_batches` 也是預設一次 1,000 筆，但讀出來的變數是 array。（追 source code 可以發現，`find_each` 實際上是去呼叫 `find_in_batches`）

``` ruby
Invoice.find_in_batches(:include => :invoice_lines) do |invoices|
  export.add_invoices(invoices)
end
```
兩者都有 `:batch_size` 跟 `:start` 參數可以設定。

但他有些限制，例如不能指定排序。根據 [API 文件](http://api.rubyonrails.org/v3.2.16/classes/ActiveRecord/Batches.html)：

> It's not possible to set the order. That is automatically set to ascending on the primary key (“id ASC”) to make the batch ordering work. This also mean that this method only works with integer-based primary keys. ...

### Range Conditions 的精美語法
*來自 [2.2.2 Range Conditions](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#array-range_conditions)*

下範圍條件，我原本的寫法

``` ruby
Client.where("created_at BETWEEN ? AND ?", params[:start_date].to_date, params[:end_date].to_date)
```

可以改成精美的語法

``` ruby
Client.where(:created_at => (params[:start_date].to_date)..(params[:end_date].to_date))
```

### reorder
*來自 [8.3 reorder](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#reorder)*

如其名，可以把預設的 order override 掉。

``` ruby
class Post < ActiveRecord::Base
  has_many :comments, :order => 'posted_at DESC'
end

Post.first.comments.reorder('posted_at ASC')
```

### joins + where 的精美語法
*來自 [11.3 Specifying Conditions on the Joined Tables](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#specifying-conditions-on-the-joined-tables)*

``` ruby
Client.joins(:orders).where('orders.created_at' => time_range)
```

改成精美的語法

``` ruby
Client.joins(:orders).where(:orders => {:created_at => time_range})
```


### Scopes
*來自 [13 Scopes](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#scopes)*

簡單來說就是

``` ruby
class Post < ActiveRecord::Base
  scope :published, where(:published => true)
end
```

就可以用類似這樣的語法。

``` ruby
Post.published
@board.posts.published # 假設 board has_many posts
```

scope 會回傳 `ActiveRecord::Relation` object，所以你還可以串接，例如

``` ruby
Post.published.highlight.where(:pinned => true)
```

由於我讀的是 Rails 3.2 的版本，所以還是舊語法，Rails 4 已經強制改成


``` ruby
class Post < ActiveRecord::Base
  scope :published, -> { where(:published => true) }
end
```

### 可以傳入參數的 scope
*來自 13 Scopes > [13.2 Passing in arguments](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#passing-in-arguments)*

可以到來源查看 scope + lambda 允許傳入參數的手法，但即使是 Rails 4 的 Guides 仍不推薦該手法，而是推薦：

``` ruby
class Post < ActiveRecord::Base
  def self.before(time)
    where("created_at < ?", time)
  end
end

Post.before(Time.zone.now)
```

這種寫法一樣可以支援串接

``` ruby
Category.first.posts.before(Time.zone.now)
```

### default_scope
*來自 13 Scopes > [13.4 Applying a default scope](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#applying-a-default-scope)*

有時候想預設就套用 scope，可以用 `default_scope`。

### 取消 default_scope
*來自 13 Scopes > [13.5 Removing all scoping](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#removing-all-scoping)*

用 default_scope 之後就會有個問題：某個管理功能需要取得 **全部** 的資料，甚至有時候是用別人的外掛、別人的code 繼承下來的等狀況，只想直接跳過 default scope 的話。可以用：

``` ruby
Client.unscoped.all
```

### find_by_xxx 加驚嘆號後的行為
*來自 > [14 Dynamic Finders](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#dynamic-finders)*

``` ruby
id = 123
find(id)        # 找不到 123 會炸 Exception
find_by_id(id)  # 找不到 123 會回傳 nil
find_by_id!(id) # 找不到 123 會炸 Exception
```

### 找不到符合條件的就 new/create
*來自 > [15.1 first_or_create](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#first_or_create)*

``` ruby
Client.where(:first_name => 'Andy').first_or_create(:locked => false)
```

除了 create 外，還有其他的選擇

* `first_or_initialize` 相當於 new
* `first_or_create!` invalid 的時候會炸 exception

### 直接下 SQL, 回傳 hashes
*來自 > [17 select_all](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#select_all)*

`find_by_sql` 可能蠻多人知道的，但是他會轉成 model instance。如果想要各欄位的 hash，可以用 `select_all`

``` ruby
Client.connection.select_all("SELECT * FROM clients WHERE kind = '1'")
```

他會回傳類似

``` ruby
[{"id"=>57, "kind"=>"1", "created_at"=>2013-11-16 14:09:44 +0800, "updated_at"=>2013-11-16 14:09:44 +0800}, {"id"=>57, ... }, ...]
```

### pluck 取出某欄位的值成為一個陣列
*來自 > [18 pluck](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#pluck)*

若只想取出某一欄位的值成為陣列，直覺的想法可能是：

``` ruby
User.select(:id).where(:actived => true).map { |c| c.id }
```

但如果你之後沒有要使用物件的話，這麼做其實白耗了 instantiate 的時間。

``` ruby
User.where(:actived => true).pluck(:id)
```

因為 `pluck` 不會 initialize，速度會差非常多。根據這篇 [Getting to Know Pluck and Select](http://gavinmiller.io/2013/getting-to-know-pluck-and-select/) ，一萬筆資料可以差到 10 幾倍 (1.11秒 vs 0.08秒)。


### .any? 跟 .many?
*來自 > [19 Existence of Objects](http://guides.rubyonrails.org/v3.2.13/active_record_querying.html#existence-of-objects)*

``` ruby
["a"].any?            # => true
["a"].many?           # => false
["a", "b", "c"].any?  # => true
["a", "b", "c"].many? # => true
```

關連物件跟 scope 也可以這樣用

``` ruby
Post.recent.any?
Post.recent.many?
```

但如果只是要檢查是否存在，沒有更多的動作的話，`.exists?` 會比 `.any?` 理想，請參考 [閱讀筆記 part 1]({% post_url 2013-09-23-rails-guides-reading-notes-first-4-chapters %})
