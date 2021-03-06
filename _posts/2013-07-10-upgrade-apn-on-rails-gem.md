---
layout: post
title: 更新 natescherer:apn_on_rails 換到新版 PRX:apn_on_rails 筆記
published: true
date: 2013-07-10 19:17
tags: []
category: [tw]
comments: true
redirect_from:
  - /2013/07/upgrade-apn-on-rails-gem.html
---


<a href="{% link _posts/2013-07-11-upgrade-apn-on-rails-gem.md %}" class="lang-btn">EN</a>
<a href="{% link _posts/2013-07-10-upgrade-apn-on-rails-gem.md %}" class="lang-btn lang-current">TW</a>


## 更換的原因


其實PRX本來就是元祖，不過當初要用APN功能的時候，PRX的版本還不支援rails 3，自己也沒有把握能修好，所以就改用了已支援rails 3的fork。

沒想到過了一年多，PRX版已支援rails 3、而且新增了一些我需要的功能；當初選用的folk反而一直沒有更新…，只好再換回來。


### 重大變更與新功能



* PRX版的 send_notifications 方法不接受 array，只能一次寄出所有 unsent
* 新增 APN::App，將cert內容放在資料庫內，可達到一個rails app對應多個ios apps
* 新增 APN::Group（以及 GroupNotification、DeviceGrouping）可以群組發訊息，**但對Apple的那段還是一封一封傳**，只是我們的rails app不必生一堆notifications而已。




### 更新步驟



#### 修改 `Gemfile` 改回


		gem 'apn_on_rails'

然後

		bundle install


#### 補新版的 migrateions


		rails generate apn_on_rails:install


* 如果遇到名稱衝突，可能要先將舊的改名，跑完再改回來、並把重複的刪掉。
* README裡有提到migration 002 `create_apn_notifications` 被手動修改過，可能會造成問題。於果有遇到請參考 [Upgrade Notes小節][2]。但他的migrations其實也有寫防呆，應該不會有問題才對（我自己沒遇到問題）。



然後

		rake db:migrate


#### 把cert移到資料庫，設定第一個APN::App


把 `/config/apple_push_notification_development.pem` 跟 `apple_push_notification_production` 的cert內容移到資料庫內，不知道怎麼搞的可以先參考[這篇][3]，但他提供的demo code在rails 3.2不能直接跑，要先解決massive-assignment的問題，不然就自己改寫。

其實cert file的方法也有相容，只是不能用group notifications功能，但我覺得一次衝到底比較乾脆，省得以後維護麻煩。


#### 改寫application，在新增apn_devices時要指定app


這就是要自己清查自己寫的 code 了。


### 問題解決



#### NameError: uninitialized constant APN::App::RAILS_ENV


在 `config/environment.rb` 新增

		APN::App::RAILS_ENV = Rails.env


#### Errno::ENOENT: No such file or directory - /config/apple_push_notification_development.pem


因為我是我直接捨棄cert file的方法，所以我想讓他閉嘴。如果你想沿用cert file，可能可以試試看把那段改寫成 `Rails.root.join('config', 'apple_push_notification_development.pem')`

依照教學執行

		script/rails generate configatron:install

生出configatron檔案，並在 `config/configatron/defaults.rb` 新增

		configatron.apn.cert = ''


#### 改寫成讓 APN::Notification.send_notifications 接受 array


在 `config/initializers/apn_notification_reopen.rb`

		class APN::Notification

		 # ...

		 def self.send_notifications(notifications = APN::Notification.where("sent_at is null"))
		 app_ids = notifications.map {|n| n.device.app_id }.uniq
		 app_ids.each do |app_id|
		 begin
		 if (app = APN::App.where(:id => app_id).first)
		 the_cert = Rails.env.production? ? app.apn_prod_cert : app.apn_dev_cert
		 APN::Connection.open_for_delivery({:cert => the_cert}) do |conn, sock|
		 unsent_notifications = notifications.select {|n| n.device.app_id == app_id }
		 unsent_notifications.each do |noty|
		 conn.write(noty.message_for_sending)
		 noty.sent_at = Time.now
		 noty.save
		 end
		 end
		 end
		 rescue Exception => e
		 STDERR.puts e.message
		 raise e
		 end
		 end

		 end
		end


[2]: https://github.com/PRX/apn_on_rails/blob/master/README.textile#upgrade-notes
[3]: http://stackoverflow.com/questions/11533529/uninitialized-constant-apnapprails-env
