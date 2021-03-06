---
layout: post
title: RailsConf 2014 行 - 學習的部份
published: true
date: 2014-05-01 04:00
tags: []
categories: [tw]
comments: true

---
今年被朋友推去參加 RailsConf (今年在 Chicago)

出國相關須知可以參考 [playbook](https://github.com/rocodev/playbook) 這個 repo，這次新得到的經驗很快就會發 Pull Request。

我的程度並不高，加上英文也不到 profressional 程度 (TOEIC 700 左右)，總結來說，很多課程我都是跟不上的，以下的筆記大多也是很模糊或初步的 memo，請不要太多期待 ~_~

## 講題學到的東西

### Simplifying Code: Monster to Elegant in N\<5 steps (workshop)

repo: https://github.com/tute/refactoring-workshop

#### 1 Intention revealing method

把註解重構成方法

(diff 的配色不太明顯，請把藍綠色當紅色看)

``` diff
-# when member is old
-if user.is_member && user.age > 85
+if member_is_old(user)
  # do something
elsif ...
  ...
end

+def member_is_old(user)
+  user.is_member && user.age > 85
+end
```

#### 2 Special case objects

假設我們要顯示 `member.status`，但有時候 status 有可能為 null，我們要顯示別的東西，或回傳一個預設的值好讓 method chain 能繼續串下去。

於是可能就會有這樣的 code

    <%= member.status || "N/A" %>

解法就是新增一個特殊 class

``` ruby
class NullMember
  def status
    "N/A"
  end

  ...
end
```

取用時

``` ruby
member = Member.where(...).first || NullMember.new
```

使用時就可以簡化成

    <%= member.status %>

第三題我還沒做完，第四題當天時間不夠，但 repo 裡都有附 solution branch，可以對照看。

### Make an Event of It!

使用 [ActiveSupport/Notifications](http://api.rubyonrails.org/classes/ActiveSupport/Notifications.html) 或類似替代品，可以簡化 code 、斷開過度相依的 code (也就比較好測試) 等好處。

但要注意如果你觸發多個 Subscribers、但他們之間有順序性的話，你必須自己處理這個問題。

從 Event-driven programming 時代走過來的人應該已經熟悉這樣的觀念。

### Too Big to Fail

這講題有點太深了我聽不懂，只知道他們是做金流相關的產品，流量也很大，所以倒站、爆炸是非常嚴重的事。

可以定時用 [broken_record](https://github.com/nickgervasi/broken_record) 檢測現有資料是否 break validation。

### Advanced aRel: When ActiveRecord Just Isn't Enough

Arel 火力展示，有很多很強大的用法。

值得一提的是 [scuttle.io](http://www.scuttle.io/) 可以幫你把純 SQL 轉成 Arel 語法！

### Deploying Rails is easier than it looks

講者 Ben Dixon 就是 [Reliably Deploying Rails Applications](https://leanpub.com/deploying_rails_applications) 的作者，演講內容是該書的精華版，書我已經看過了所以沒有新東西。

這本書的內容是 chef-solo 跟 capistrano 3，值得買。

### Reading Code Good

主講人本身學 Rails 一年左右而已，但在當地舉辦 "Code Club"，活動內容是「讀 sourcecode」

講者提示一些舉辦 Code Club 的 tips

* 一開始
 * 先找 熱門、文件好、維護好的 project
 * 100 行左右的 code base (project 或 module)
* 除了字面意義上的「讀 code」
  * 想想「如果是我會怎麼改，為什麼他要這麼寫」
 * 用 debugger 做一些實驗
 * 去了解不熟的概念、機制
 * 互相提問
* 結束後要求成員分享 how was the experience? what did we learn? how can we improve?
* 讀 code 需要團隊，因為一個人很容易卡關、理解錯誤、或觀點單一
* 堅持下去才能成為 Expert

投影片在 http://www.slideshare.net/saronyitbarek/reading-code-good ，以下這兩張是特別精華

* p.68 CODE CLUB GUIDELINES
* p.74 CODE BASES WE'VE READ

### Web applications with Ruby (not Rails)

這個講題是示範用 Rack 寫一個非常基本的 Web application

其基本原理就是

* 在 `config.ru` 裡總是回傳 `[http_status_code, hash_of_http_header, emulatable_body]`，就可以在瀏覽器看到靜態的結果
* 在 `config.ru` 內判斷路徑，並回傳不一樣的 body
* 把判斷路徑的邏輯抽到一個 `Controller` class
* 在 `Controller` 裡面追加一些產生動態內容的方法，並利用 Haml 或 ERB render view
* 把 View 相同的部份抽成 layout，並修改 render 的方式
* 寫一個 `params` method，並取用 `env["QUERY_STRING"]`

結論： **DON'T EVER DO THIS FOR PRODUCTION APP**

### how to be a better junior developer

投影片 https://speakerdeck.com/kwugirl/how-to-be-a-better-junior-developer
文章 http://blog.newrelic.com/2014/04/23/better-junior-developer/

這個講題主要是一些工作態度、心態、問對問題等，跟技術比較無關。

讓別人願意幫助你

* 提問之前要做功課
* 如果對方在忙，不要死纏爛打，問他「有沒有誰可以問呢？」或「我可以在哪裡找到答案？」
* 提問的範本 "I'm trying to \_\_\_\_\_, so that I can \_\_\_\_\_. I'm running into \_\_\_\_\_. I've looked at \_\_\_\_\_ & tried \_\_\_\_\_."
* 不要隨意打斷別人工作，如果沒有那麼急，可以利用 IM 或 email
* 不要問過大的問題，會讓人很難回答或幫你

成為好的 team

* mentor 不應該是單向倒知識，而是要負責準備安全的環境讓新手犯錯
* 一個工程師的生涯裡搞爆 production 是很難避免的，但重點是「何時」，以及以後要怎麼避免
* 用心準備 demo，讓團隊得到 credit

> you deserve to have confidence in your ability to learn

### What is REST? Why is it part of the Rails Way?

基本上就是在講 REST 由來跟 Rails 採用的 RESTful 慣例

一個提醒是：當你 routes 用到 member 或 collection 時，考慮一下這件事情拆到另一個 controller 裡做是否比較合理。

### Applications First, Frameworks Second: Better Systems through Design (workshop)

repo: https://github.com/ahawkins/applications-first-frameworks-second

非常的跟不上，請自己看 repo 吧。

### Taming Chaotic Specs: RSpec Design Patterns (workshop)

repo: https://github.com/CodingZeal/skinny

#### Start from a minimal valid object

使用 FactoryGirl, Fabricate 時，假資料的 attriburtes 應該填到什麼程度呢？

應該只給最低限度有效的 object，否則有可能會因為一些多餘的設定反而讓測試非預期的 pass 或 fail，改 code 後 all pass 也難保不是因為其他非相關的 attributes 導致的。

#### assert a truth thing

"assert A should not be not equal to B" 之類邏輯的是很奇怪的

#### subject 用來決定要測的項目，let 用來控制值

範例

``` ruby
describe User do
  describe "authentication" do
    subject(:user) { User.new(username: username, password: password) }

    let(:username) { "jimmy" }
    let(:password) { "123456" }

    expect(user).to be_valid

    context "when username too long" do
      let(:username) { "tooooooooooooooooooooooooooo loooooooooooooooooooong" }
      expect(user).to be_invalid
    end
  end
```

這麼做還有一個額外的好處是 fail 時能帶出較多的訊息（比起區域變數)

#### 假資料變數的取名

`user_with_company` vs. `user1`：顯然前者比較好，應該不用多做解釋

### Improve Performance Quick and Cheap: Optimize Memory and Upgrade to Ruby 2.1

* 沒有記憶體最佳化的 ruby 2.1，速度跟以前版本沒有差多少
* 記憶體最佳化後才能速度才會大幅提昇
* 就算是舊版，注意記憶體問題也能得到好處

這個講題主要是在講如何 tune ruby 2.1 的 GC

另外也有提到一些比較基本的注意事項，例如

* 能透過下 DB query 達成的就盡量利用，而非跑一個大迴圈
* 適合操作同一 object 的情境也盡量使用 eg. `gsub!` vs `gsub`
* rails 內建的 serialize json 有問題，記憶體會 2x 浪費，應自己實作

該講者正在寫一本 ruby 效能相關的書，可以訂閱 early access: [Ruby Performance Book](http://ruby-performance-book.com/)

## 觀察到大會貼心之處

### 名牌上面的 QR code

![QR code on badge](https://lh4.googleusercontent.com/-RNBDglTkdpQ/U2EXIhJMQKI/AAAAAAAABxA/dl7s3kjEE9Q/w601-h804-no/badge_qr_code.jpg)

掃出來內容如下

    Li,Bruce,ascendbruce@gmail.com,Web Engineer,Techbang

先前參加國內幾個研討會，大部分 QR code 掃出來都只是官網或行程表而已，還蠻沒意義的。例如 OSDC 2012 掃出來是官網行程表、PHPConf 2011 掃出來是官網首頁（兩者都有印上與會者的名字）。

但名牌上印聯絡資料 QR code 就還蠻實用的，很快速的交換聯絡資料，不需要用到名片，而且很多 QR code scanner 有歷史紀錄。廠商蒐集也不用擺個名片箱了，找個人站門口刷 QR code 即可蒐集大家的 email XD。至於官網首頁 QR code 這種東西貼牆上或印在手冊裡就可以了。

如果 QR code 附近有簡短說明的話更好，畢竟大部分人都被雞肋的 QR code 搞到麻痺了，很多人根本懶得試刷看看是什麼。

### Schedule 顯示與 Guidebook

大會的 web 版 schedule 會依照日期自動選擇當天的議程，雖然只是個小功能，但可以確實省下一個 click 以及焦躁的等待時間。

但現在智慧型手機這麼普及，行程表當然也要有手機版，大會櫃檯旁有一個看板，上面有 "guidebook" 的 QR code

![QR code for guidebook](https://lh5.googleusercontent.com/-3KZqPQgU7-Y/U2EXImtV1CI/AAAAAAAABxE/WELhRdcInNU/w601-h804-no/guidbook_qr_code.jpg)

Guidebook 是一個已經被很多學校、活動反覆驗證過的 app (現在 3.2.3 版)，除了看多天/多軌行程表外，還可以編排自己要聽的議程 (而且有倒數 N 分鐘提醒功能)、查看場地地圖等、發 tweet、打卡、跟其他會員交換電子名片等等功能。

基本上大會只要照規格製作資料，根本不用自己開發 app，現成的反而更實用、完善、穩定，而且以後參加別的活動時也不用重新載 app 了。

### 食物飲料

飲料區提供桶裝的星巴克咖啡，第一天甚至有看到去咖啡因咖啡，旁邊也有牛奶跟脫脂牛奶，砂糖及零卡砂糖等可調配。也有提供幾種茶包與熱開水。這麼全方面的考量（參加者在飲食上的特殊需求）在台灣的 conf 是很難看到的。

不只飲料零食高水準，就連大會提供的午餐水準也不錯

![steak](https://lh3.googleusercontent.com/--PSqQ_mMPYQ/U2EfpLZ25cI/AAAAAAAABxY/YGbCvMDZvkM/w1076-h804-no/steak.jpg)

例如這是 day-4 的餐點之一，熟度跟調味其實已經打趴一堆餐廳了，而且還一直補，我吃了兩盤！（髒髒的盤子就別在意了）

這當然要考慮到 RailsConf 2014 賣了 1,500 張的 750 USD 門票，還加上 15,000 USD 起跳的企業贊助方案，才能如此下重本。但不可否認這次真的辦得很好，並非錢多、人多活動就一定會成功。

## 反思

### 辦 workshop 的注意事項

這次參加了幾個 workshop，會帶跟不會帶的講者差距很明顯，幽默、經驗是一部分，但我覺得有幾個要點是未來若我有機會主持 workshop 時，應注意的地方：

* 會場 wifi 通常都很悲劇，就算沒有從頭掛到尾，也很有可能掉封包或龜速，因此
  * 應盡早請聽眾開始 git clone 與安裝 gems，最好放在投影片第一頁，這樣聽眾陸續就座後就可以開始抓了
  * 並且準備幾支 usb 碟供人離線使用
* 有提供解答或階段的話，應該把 branches 梳理好，可利用 tag 去標出每個階段，而非 merge --no-ff，會很難追 git log
* 不要包山包海，因為時間有限，也要考慮聽眾的程度，與其塞一堆做不完的題目，不如好好設計幾題讓人建立信心、又有學到東西的題目。例如 Simplifying Code: Monster to Elegant in N\<5 steps 這場就只有 4 題

### 為什麼要去這種超噴錢的 conf

最主要是跳出舒適圈，觀摩別人能做到什麼程度，順便教交朋友，與不同文化的人交流想法。

我很確定去這場 conf 不可能讓我在 1 年內加薪加到賺回來，但這些經驗很可能帶給我長遠的影響。

-----------

* 2014-05-02 補上 [觀光篇]({% link _posts/2014-05-02-railsconf-2014-chicago-tourism-part.md %})
