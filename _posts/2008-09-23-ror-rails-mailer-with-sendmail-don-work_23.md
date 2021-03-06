---
layout: post
title: ror rails mailer with sendmail don't work? 不會寄信 寄不出去？ mailer setup設定 RESTful
  Authentication mailer
published: true
date: 2008-09-23 06:15
tags: []
categories: [tw]
comments: true
redirect_from:
  - /2008/09/ror-rails-mailer-with-sendmail-don-work.html
---

### English

the main point is the augment of sendmail setting. if you did not set the augment -i -t, the sendmail server will wait rather then send immediately. it's because the usage of sendmail server. you can search the sendmail server manual if you want.

by the way, if you want to use RESTful Authentication with activation. you may run into a big question about 'why did the mailer not work?'. this is one of the reason. but if it still can't work. check if you already active the observer which you can set in [config/environment.rb]. (try find those keywords: config.active_record.observers)

### Chinese

主要的點是你必須設定sendmail的參數，如果沒有設-i -t的話，sendmail server會等待不發送，這跟sendmail server的用法有關，有興趣的話可以去vbird鳥哥網站找sendmail教學。
另外，如果你是想用RESTful Authentication的activation功能，發現mail沒辦法寄，除了以上說的，還有一個新手可能沒注意到的地方是，observer要在[config/environment.rb]設定檔裏面打開，搜尋一行config.active_record.observers 那邊把相應的observers 的名稱打上去

code:

```rb
config.action_mailer.raise_delivery_errors = true

ActionMailer::Base.delivery_method = :sendmail

ActionMailer::Base.sendmail_settings = {
  :location => '/usr/sbin/sendmail',
  :arguments => '-i -t'
}
```

reference:
[http://www.red91.com/2007/11/05/sending-mail-with-rails][1]

[1]: http://www.red91.com/2007/11/05/sending-mail-with-rails
