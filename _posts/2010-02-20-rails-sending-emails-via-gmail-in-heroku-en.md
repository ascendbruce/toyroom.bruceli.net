---
title: Rails sending emails via gmail not working in heroku server but ok in localhost
published: true
date: 2010-02-20 11:09
tags: []
categories: [en]
comments: true

---

![](/images/world.png) 正體中文版: [Rails sending emails via gmail not working in heroku server but ok in localhost]({% link _posts/2010-02-20-rails-sending-emails-via-gmail-in-heroku.md %})


I've encountered a problem that my rails app can send email via gmail properly in my computer but not working in heroku server (get an error: "Must issue a STARTTLS command first").

Following by [this post][1]:

1. download [tls_smtp.rb][2]. (found from [this post][3])
2. put it into your app lib directory
3. import it in config/environment.rb

		require 'tls_smtp'

Then upload to heroku, it's done!

I didn't add additional config in config/environments/production.rb as [this post][1] said. But it still work.

This is my mailer config (I put it in config/initializers/mail.rb):
		ActionMailer::Base.smtp_settings = {
		 :enable_starttls_auto => true,
		 :address => 'smtp.gmail.com',
		 :port => 587,
		 :domain => 'gmail.com',
		 :authentication => :plain,
		 :user_name => 'xxxxxx@gmail.com',
		 :password => '******'
		}

Hope this helps


[1]: http://groups.google.com/group/communityengine/browse_thread/thread/ff7ae0daeae8cbaf
[2]: http://sites.google.com/site/knkalbum/tls_smtp.rb?attredirects=0
[3]: http://www.errorhelp.com/search/details/78026/redmine-rails-must-issue-a-starttls-command-first
