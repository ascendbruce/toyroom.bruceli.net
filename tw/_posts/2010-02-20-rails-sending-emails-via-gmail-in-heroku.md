---
layout: post
title: Rails 透過 Gmail 寄信在 localhost ok 但 heroku 上不正常
published: true
date: 2010-02-20 11:09
tags: []
categories: [tw]
comments: true

---

![](/images/world.png) English version: [Rails sending emails via gmail not working in heroku server but ok in localhost]({% link en/_posts/2010-02-20-rails-sending-emails-via-gmail-in-heroku-en.md %})


我剛才遇到一個問題，我用gmail寄信，在localhost也測試OK，但是丟上heroku後卻壞掉(得到「Must issue a STARTTLS command first」錯誤)

後來找到了一篇[文章][1]，依照指示：


1. 下載 [tls_smtp.rb][2]. (在[這篇][3]找到的)

2. 放到app的lib資料夾

3. 引入到 config/environment.rb

		require 'tls_smtp'

然後上傳到heroku，完成了！



我沒有依照[這篇][1]所說要再增加mailer設定到config/environments/production.rb，不過他還是成功。



這是我的mailer設定 (我放在 config/initializers/mail.rb):

		ActionMailer::Base.smtp_settings = {
		 :enable_starttls_auto => true,
		 :address => 'smtp.gmail.com',
		 :port => 587,
		 :domain => 'gmail.com',
		 :authentication => :plain,
		 :user_name => 'xxxxxx@gmail.com',
		 :password => '******'
		}




希望這篇有幫助





[1]: http://groups.google.com/group/communityengine/browse_thread/thread/ff7ae0daeae8cbaf
[2]: http://sites.google.com/site/knkalbum/tls_smtp.rb?attredirects=0
[3]: http://www.errorhelp.com/search/details/78026/redmine-rails-must-issue-a-starttls-command-first
