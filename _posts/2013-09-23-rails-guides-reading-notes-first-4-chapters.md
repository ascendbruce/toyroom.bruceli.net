---
layout: post
title: Rails 打基礎 - Rails Guides 3.2.13 閱讀筆記 Part 1
published: true
date: 2013-09-23 01:10
tags:
- rails
categories: []
comments: true

---
[Rails Guides](http://guides.rubyonrails.org/v3.2.13/) 是 Rails 官方提供的線上教學文件，還蠻基礎的。

1到9章包含了 Migration, Model, View, Controller, Routes 等寫一個 Rails app 最基本的部份，摸索過 Rails 一段時間的人應該多少都能做出一個簡單的 Blog 或論壇，畢竟還有 scaffold 可以參考。那麼為什麼還要讀 Rails Guides 呢？

就像是節奏型鼓手，反正學會這3個節奏就可以打很多POP歌了。但很快就會遇到瓶頸，倒頭來還是得用打點練習重新打基礎，反而還得克服之前養成的壞習慣。

    hh |x-x-x-x-x-x-x-x-|x-x-x-x-x-x-x-x-|x-x-x-x-x-x-x-x-|
    S  |----o-------o---|----o-------o---|----o-------o---|
    B  |o-------o-------|o-------o-o-----|o-----o-o-------|

小弟拖了很久才終於狠下心開始讀 Rails Guides，這邊整理我讀到的、值得注意的部分，以及我之前不知道的手法。這系列適合的對象是 Rails 學一小段時間、已經能做出簡單的 Blog、論壇的人，或者雖然使用 Rails 很久了、但一直都隨便亂寫的人 (例如我XD)。

另外，想開始讀 Rails Guides 的人，如果有 Kindle、或有在用 Kindle 手機版的話，官方有提供 .mobi 檔可抓。每天通勤、等人的時候就可以讀。

Part 1 包含 2~4 章的筆記：

## [Getting Started with Rails](http://guides.rubyonrails.org/v3.2.13/getting_started.html)
(無筆記)

## [Rails Database Migrations](http://guides.rubyonrails.org/v3.2.13/migrations.html)
### 無法回溯的 Migration
*來自 [3.5 Using the up/down Methods](http://guides.rubyonrails.org/v3.2.13/migrations.html#using-the-up-down-methods)*

有時候有些 Migration 就是無法回溯，加上還有其他考量、打死都不准許回溯的話，此時可以在 `down` method 裡寫：

```ruby
raise ActiveRecord::IrreversibleMigration
```

~~要回溯還是要命？~~

### 在 migration 內使用 model 時，跳過 validation 的方法
*來自 [5 Using Models in Your Migrations](http://guides.rubyonrails.org/v3.2.13/migrations.html#using-models-in-your-migrations)*

在 migration 內有使用 model 存取 attributes 的時候，在別台機器上可能會遇到因為 validator 已經宣告了、但 table 欄位實際上還不存在，所以炸掉了。此時可以在 migration 內宣告一個空的 model 來 override 掉真正的。

需注意的是，在開始之前最好還是呼叫 `Model.reset_column_information` 清掉 cache，否則可能會有問題。詳細使用方式請參考來源。

## [Active Record Validations and Callbacks](http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html)
### valid? and invalid?
*來自 2.4 [valid? and invalid?](http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html#valid-and-invalid)*

這兩個 methods 的回傳值剛好相反（如名稱所示）。

``` ruby app/models/person.rb
class Person < ActiveRecord::Base
    validates :name, :presence => true
end
```

```ruby
p = Person.new
p.errors.messages # => {}
```

即使 model 裡有寫 validations，此時因為還沒有執行檢查，所以不會有錯誤（`p.errors.messages` 裡也不會有東西）。 `.valid?` 或 `.invalid?` 可以觸發 validations。

```ruby
p.valid? # => false
p.errors.messages # => {:name=>["can't be blank"]}
```

### 自定 validates 的子檢查
*來自 [6.1 Custom Validators](http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html#custom-validators)*

如果想實作這樣的自定 validation （在此例是 `:email => true`）

``` ruby app/models/person.rb
class Person < ActiveRecord::Base
  validates :email, :presence => true, :email => true
end
```

可繼承 `ActiveModel::EachValidator` 來實作，詳情請見來源。

### 取得 errors 的完整句子的訊息
*來自 [7.3 errors.add](http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html#errors-add)*

直接印出 errors.messages 會得到類似這樣的結果

    1.9.3-p392 :001 > p.errors.messages
     => {:name=>["can't be blank"]}

用 errors.full_messages 或 errors.to_a 可以取得完整句子的訊息

    1.9.3-p392 :002 > p.errors.to_a
     => ["Name can't be blank"]
    1.9.3-p392 :003 > p.errors.full_messages
     => ["Name can't be blank"]

### transaction 內停止執行並 rollback
*來自 [13 Halting Execution](http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html#halting-execution)*

下列狀況會停止 transaction 並 rollback

* before callback 回傳 `false` 或丟 Exception
* after callback 丟 Exception

需注意的是，Rails Guides 提到直接丟一般的 Exception 會中斷執行，可能導致其他預料外的問題，Guides 是推薦丟 `ActiveRecord::Rollback` exception，不會 re-raise，所以不用再包一層 begin ... rescue。

(這邊我不是很確定會發生什麼樣的問題，還請大大指點)

## [Active Record Associations](http://guides.rubyonrails.org/v3.2.13/association_basics.html)
### inverse_of
*來自 [3.5 Bi-directional Associations](http://guides.rubyonrails.org/v3.2.13/association_basics.html#bi-directional-associations)*

使用 `inverse_of` 在某些情境下可以避免 inconsistencies，以及增進效率（因為是同一個 object）

``` ruby
class Customer < ActiveRecord::Base
  has_many :orders, :inverse_of => :customer
end
class Order < ActiveRecord::Base
  belongs_to :customer, :inverse_of => :orders
end
```

```
c = Customer.first
o = c.orders.first
oc = o.customer
c.__id__  # => 70099731440980
oc.__id__ # => 70099731440980 # 相同
```

如果沒有 inverse_of

``` ruby
class Customer < ActiveRecord::Base
  has_many :orders
end
class Order < ActiveRecord::Base
  belongs_to :customer
end
```
```
c = Customer.first
o = c.orders.first
oc = o.customer     
c.__id__  # => 70297963786100
oc.__id__ # => 70297971379700 # 不同
```

但是有些限制：不能搭配 `:through`、`:polymorphic`、`:as` 使用 and For `belongs_to` associations, `has_many` inverse associations are ignored.

### build_association 與 create_association
*來自 [4.1.1 Methods Added by belongs_to](http://guides.rubyonrails.org/v3.2.13/association_basics.html#methods-added-by-belongs_to)*

association 請取代成關連的名稱，使用範例如下：

```
@customer = @order.build_customer(:customer_number => 123, :customer_name => "John Doe")
@customer = @order.create_customer(:customer_number => 123, :customer_name => "John Doe")
```

總之就是關連物件的 `new` 跟 `create` 用法，還會自動幫填 foreign key。

另外 `has_many` 那方也有類似的功能，也是會自動幫填 foreign key。

```
@order = @customer.orders.build(...)
@order = @customer.orders.create(...)
```

### counter_cache
*來自 [4.1.2 Options for belongs_to](http://guides.rubyonrails.org/v3.2.13/association_basics.html#options-for-belongs_to)*

功能如其名，就是關連項目的 count cache，設定好後會用在這裡：

```ruby
@customer.orders.size
```

但 `count` 仍然會下 `select count(*) ...`

```ruby
@customer.orders.count
```

設定方式請參考來源，不過 Rails Guides 沒有提到一件事：如果是先有資料才補 counter_cache 欄位的話，在 migration 內你應該要給予現有資料正確的 count，但用一般的寫法會炸 Exception，要用 `reset_counters` 才對。

### dependent
*來自 [4.1.2.5 :dependent](http://guides.rubyonrails.org/v3.2.13/association_basics.html#belongs_to-dependent)*

簡單來說就是類似 on delete cascade 的效果。

``` ruby
class Customer < ActiveRecord::Base
  has_many :orders, :dependent => :destroy
end
```

當 customer instance 被 destroy 的時候，關連的 orders 也都會被 destroy。

除了 `:delete`，也可以設 `:nullify` (foreign key 填 null)。

另外請勿用在 (belongs_to && 對面是 has_many) 的狀況，會導致孤兒 records。


### 加上 :include 增進效率、以及不必加的狀況
*來自 [4.1.2.7 :include](http://guides.rubyonrails.org/v3.2.13/association_basics.html#belongs_to-includes)*

1. 官方的範例寫得蠻好的，所以就直接過去看吧。
2. 兩層才需要手動加 :include，只有一層關連的話會自動做。

### 關連物件何時儲存
*整理自 [4 Detailed Association Reference](http://guides.rubyonrails.org/v3.2.13/association_basics.html#detailed-association-reference) 下四個 When are Objects Saved? 子項目*

| Relation                | When are Objects Saved? |
|:------------------------|:------------------------|
| belongs_to              | Assigning an object to a belongs_to association does not automatically save the object. It does not save the associated object either.|
| has_one                 | When you assign an object to a has_one association, that object is automatically saved (in order to update its foreign key).|
| has_many                | When you assign an object to a has_many association, that object is automatically saved (in order to update its foreign key). If you assign multiple objects in one statement, then they are all saved.|
| has_and_belongs_to_many | When you assign an object to a has_and_belongs_to_many association, that object is automatically saved (in order to update the join table). If you assign multiple objects in one statement, then they are all saved.|

<br/>

### xxxxx_ids 與 xxxxx_ids=
*來自 [4.3.1 Methods Added by has_many](http://guides.rubyonrails.org/v3.2.13/association_basics.html#methods-added-by-has_many)*

除了熟悉的：

``` ruby
@customer.orders
@customer.orders = @orders
```

有時候你只有 ids，要撈出 objects 反而多一道手續，可以用：

``` ruby
@customer.order_ids  # => [1, 2, 3, ...]
@customer.order_ids = [1, 2, 3]
```

### exists?
*來自 [4.3.1 Methods Added by has_many](http://guides.rubyonrails.org/v3.2.13/association_basics.html#methods-added-by-has_many)*

有時候你只是想知道是否有存在符合條件的 object，我之前是這樣寫

```ruby
@customer.where(:name => "John").present?
```

但其實可以這樣寫

```ruby
@customer.exists?(:name => "John")
```

當資料量稍大以後，後者效能也明顯較好：

用 156,046 筆資料實驗，結果用 where(...).present? 要 121.2ms，用 exists? 只要 0.3ms。

### 關連物件加 :conditions
*來自 4.3.2 Options for has_many > [4.3.2.4 :conditions](http://guides.rubyonrails.org/v3.2.13/association_basics.html#has_many-conditions)*

``` ruby
# 如果 model 長這樣..
class Customer < ActiveRecord::Base
  has_many :confirmed_orders, :class_name => "Order", :conditions => { :confirmed => true }
end

# 那麼下面這行只會撈出符合 :confirmed => true 的關聯物件
@customer.confirmed_orders

# 下面這行則會自動塞 :confirmed => true
@customer.confirmed_orders.create
```

另外也接受字串或 Proc 的條件限制，但不支援自動塞值。

### 改寫預設會下的 SQL
*來自 4.3.2 Options for has_many > [4.3.2.5 :counter_sql](http://guides.rubyonrails.org/v3.2.13/association_basics.html#has_many-counter_sql) 與 [4.3.2.8 :finder_sql](http://guides.rubyonrails.org/v3.2.13/association_basics.html#has_many-finder_sql)*

可以改寫預設會下的 SQL 嗎？可以，請參考來源。除了這兩個外其實還有很多其他的自定選項。

*來自 4.3.2 Options for has_many > 來源 [4.3.2.15 :order](http://guides.rubyonrails.org/v3.2.13/association_basics.html#has_many-order)*

### 關連物件預設的排序方式
```ruby
class Customer < ActiveRecord::Base
  has_many :orders, :order => "date_confirmed DESC"
end
```

這樣子從關連取得的結果就會預設以 `date_confirmed DESC` 排序。

### before_add 與 after_add 等 callback
*來自 [4.5 Association Callbacks](http://guides.rubyonrails.org/v3.2.13/association_basics.html#association-callbacks)*

有這些 callback 可以用（功能如名字所示）：

* before_add
* after_add
* before_remove
* after_remove

使用範例

```ruby
class Customer < ActiveRecord::Base
  has_many :orders, :before_add => :check_credit_limit
 
  def check_credit_limit(order)
    ...
  end
end
```

### 寫自定的 find_by_xxx
*來自 [4.6 Association Extensions](http://guides.rubyonrails.org/v3.2.13/association_basics.html#association-extensions)*

來源的範例寫得很好，也很難再簡潔了，所以這邊就不重貼一次，請直接參考來源。


目前我閱讀到第9章，之後的筆記請稍待我整理完後貼出。