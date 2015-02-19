---
title: Variables and email headers always get nothing in Rails3 ActionMailer
published: true
date: 2011-10-31 05:00
tags: []
categories: [en]
comments: true

---

  
Recently, I am working on sending email in my rails project. I use AWS SES (Amazon Web Services - Simple Email Service). But except some specific settings, others usage should be the same.  
  
And I follow the [official user guide][2]:  

		...  
		UserMailer.welcome_email(@user).deliver  
		...  
		  
I don't know what's going on. But it just doesn't work.  
  
The work one:  
		UserMailer.welcome_email(@user.name, @user.email)  
		Passing all parameters you're going to use, in Primitive type. (eg. String, Integer, Boolean)  
  
If you use Objects (including Models). It cannot get your attributes. And Email headers (From, to, Subject) may stay blank. Than encounter this error:  
  
		Completed 500 Internal Server Error in 1392ms  
		AWS::SES::ResponseError (InvalidParameterValue - Missing required header 'To'.):  
		  
The reason is that ActionMailer is Observer. It creates a new process to run on. But objects can't be accessed in difference process. So you should only pass Strings, Integers.   
  
So you may found that in rails console, the line UserMailer.welcome_email(@user).deliver works. but not in web.  
  
Here's a workaround: Encapsulate Mailer in to a Model:  
  
		MailModel.welcome_email(@user)  
		  
		class MailModel  
		 def self.welcome_email(user)  
		 UserMailer.welcome_email(user.name, user.email)  
		 end  
		end  
		  
		class UserMailer < ActionMailer::Base  
		 def welcome_email(name, email)  
		 @name = name  
		 mail(:to => email, :from => "system@yourdomain.com", :subject => "Welcome!")  
		 end  
		end  
		

[2]: http://guides.rubyonrails.org/action_mailer_basics.html#walkthrough-to-generating-a-mailer
