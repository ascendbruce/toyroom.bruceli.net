---
title: "產生短但保證不重複的亂數 token in Rails x ActiveRecord x PostgreSQL"
date: 2015-09-07 9:00
categories: [tw]
tags: []
og_image: /images/posts/008-binary-binary-codes.jpg
---

{% render_post_image 008-binary-binary-codes.jpg %}

> Pic CC-BY-SA by Christiaan Colen https://flic.kr/p/x9G5bQ

為每個 Records 產生不重複亂數 token 是很常見的需求，一個常見的解法是使用 UUID，原則上就可確保不重複。但有時候會有「既要短、又要保證不重複」的需求，例如訂單編號（不希望外人可以透過自動遞增的 id 得知訂單量、但又要能透過電話唸給客服）。

有寫過一點 Rails 的人可能馬上就會想到在 Model 加個 `validates :short_token, uniqueness: true` 並在碰撞的時候用迴圈嘗試重新幾次，但這其實是不保險的：兩個 requests 同時發生的話會 [race condition](https://en.wikipedia.org/wiki/Race_condition#Critical_and_non-critical_race_conditions)。

> 這不保險的程度依照你的流量而定，網站流量很小的話可能前幾個月都不會遇到這種問題，但最好一開始就考慮進來，畢竟這種 token 欄位通常都很重要，一旦發生重複會有很麻煩的問題（業務會出包之類的）。

## 解決辦法

* 利用 DBMS 的 unique constraint
* 嘗試儲存被 DBMS 拒絕的話，產生新的亂數 token 重新嘗試
* 因為要利用 DBMS 的 unique constraint，放在 `after_create` hook 比較合理

## 實做

實做的部分基本上是參考 [Handling Token Generation Collisions In ActiveRecord](http://daniel.fone.net.nz/blog/2014/12/10/handling-token-generation-collisions-in-activerecord/) 再加上 race condition 的考量。

幫 token 欄位加上 DBMS level 的 unique constraint：

``` ruby
class AddIndexToShortToken < ActiveRecord::Migration
  def change
    add_index :users, :short_token, unique: true
  end
end
```

after_create hook:

``` ruby
class User < ActiveRecord::Base
  validates :short_token, uniqueness: { allow_nil: true }

  after_create :set_short_token

  private

  def set_short_token
    return if short_token

    ActiveRecord::Base.transaction(requires_new: true) do
      update_column :short_token, SecureRandom.hex(3)
    end
  rescue ActiveRecord::RecordNotUnique => e
    @token_attempts = @token_attempts.to_i + 1
    retry if @token_attempts < 3
    raise e, "Retries exhausted"
  end
end
```

### 為什麼要 `requires_new: true`

如果你使用 PostgreSQL，這個就是必要的。如果你拆掉 `ActiveRecord::Base.transaction(requires_new: true) do` 這一層 transaction，你會看到 rails 噴出 `ActiveRecord::StatementInvalid` 之類的 exceptions。其原因是：

> On some database systems, such as PostgreSQL, database errors inside a transaction cause the entire transaction to become unusable until it's restarted from the beginning. 

解決辦法：

> In order to get a ROLLBACK for the nested transaction you may ask for a real sub-transaction by passing requires_new: true. If anything goes wrong, the database rolls back to the beginning of the sub-transaction without rolling back the parent transaction.

兩者都在 [ActiveRecord::Transactions::ClassMethods](http://api.rubyonrails.org/classes/ActiveRecord/Transactions/ClassMethods.html) 文件裡。

用了 `ActiveRecord::Base.transaction(requires_new: true) do` 以後，Rails log 會變成類似這樣（請注意 `SAVEPOINT` 指令）：


``` sql
-- Create transaction 的開始 (由 Rails 自動)
(0.6ms)  BEGIN

-- User.create(...)
SQL (0.7ms)  INSERT INTO "users" ("created_at", "updated_at") VALUES ($1, $2) RETURNING "id"  [["created_at", "2015-09-05 12:42:10.606633"], ["updated_at", "2015-09-05 12:42:10.606633"]]

-- ActiveRecord::Base.transaction(requires_new: true)
(0.1ms)  SAVEPOINT active_record_1

-- update_column :short_token, 'OOOXXX'
SQL (0.7ms)  UPDATE "users" SET "short_token" = 'OOOXXX' WHERE "users"."id" = $1  [["id", 57]]
PG::UniqueViolation: ERROR:  duplicate key value violates unique constraint "index_users_on_short_token"
DETAIL:  Key (short_token)=(SecureRandom.hex(3)) already exists.
: UPDATE "users" SET "short_token" = 'SecureRandom.hex(3)' WHERE "users"."id" = $1

-- end (ActiveRecord::Base.transaction(requires_new: true) 的)
(0.1ms)  ROLLBACK TO SAVEPOINT active_record_1

...

-- create 順利完成（如果失敗，這邊就會是 ROLLBACK）
(5.9ms)  COMMIT
```

### 為什麼要 `uniqueness: { allow_nil: true }`

如果你的 model 上線第一天就會有這個亂數 token 機制的話，你可能不需要這個，改成 `uniqueness: true` 應該就可以了。

但如果你有現有 records，那 uniqueness validator  加下去以後，short_token == `nil` 的 records 都會違反此檢查，意味著及使你沒有弄壞其他欄位，嘗試 `.save` 時仍然會炸在這裡。我為了 deploy 與跑 data migrate 的空窗期的考量，一開始先在這邊加上 `allow_nil`，之後其實可以拿掉。

之前還在想是否會因為 `after_create` 發生兩個 records 同時是 `nil` 的狀況？但思考 & 嘗試過後結論應該是沒有問題，因為整個 create 是自動被 rails 包在 transaction 裡的，commit 的時候也意味著已經拿到 token 了。如果有錯請糾正我。

> 附帶一提，關於如何 migrate data (而非 db 欄位) 之後也會發佈一篇文章說明我目前採用的方法。

### 為什麼要 `return if short_token`

這個是防止有人手賤對已經有 short_token 的 record 再次執行 `set_short_token` 導致被覆寫。

## Bonus 1: 短 token 的設計

如果這個短 token 需要被人讀或透過電話告知，你可能會想考慮以下幾點：

* 避免摻雜太多符號（因為符號可能有蠻多別名）
* 避免同時使用 `O, 0, I, l, 1, 8, B`，因為他們長得很接近，容易搞混。
* 如果要用口頭唸出來，則不能分大小寫
* 綜合以上幾點，其實 [Base32](https://en.wikipedia.org/wiki/Base32) 很符合需求，主流的定義 (RFC 4648) 基本上就是 `[a-z][2-7]`，有 gem 可以直接用。成果類似 `Base32.encode(SecureRandom.random_bytes).first(7)`
* 7±2 原則應該大家都聽過，這邊不講解心理學上的細節，總之長度在 5 ~ 9 個字之間會比較方便好記，而且也容易一口氣唸完。
* 決定長度時要考慮可容納的 token 數。我的想法是 (32^(字串長度))/2 = 可安全容納的 token 數（每次 generate token 的碰撞機率 < 1/2）。

## Bonus 2: 如何比較其效果

1. 開一個 rails 專案，在 localhost 準備好 produciton 環境
2. 寫一個簡單的 API，且總是嘗試塞同樣的 token
3. `RACK_ENV=production puma` (當然要先裝好)
4. 用以下 script 生 multi threads 去打那個 API

``` ruby
require 'net/http'

uri = URI('http://localhost:9292/users/generate')

5.times.map {
  Thread.new { Net::HTTP.get_response(uri) }
}.each(&:join)
```

## 其他解法

其實這不是唯一的解法，例如 JokerCatz 就用 [Integer Obfuscator](http://jokercatz.blogspot.tw/2015/03/ruby-integer-obfuscator.html) 來解這樣的問題（簡單來說就是 hash function），在一定範圍內不會碰撞，因此有寫入速度快的優點（不用依靠 DBMS 的 unique constraint）。但小弟服務的公司有一些考量，最後還是採用真亂數的解法，這篇是採用此解法的筆記。
