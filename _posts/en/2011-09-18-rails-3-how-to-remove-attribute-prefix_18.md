---
title: Rails 3 HOW TO  remove attribute prefix from validation error messages
published: true
date: 2011-09-18 08:52
tags: []
categories: [en]
comments: true

---

  
  
First, in most cases, you should translate displayed attribute name by i18n. Here are some solutions, including i18n way:  
[in Ruby Forum][2]  
[in stackoverflow][3]  
  
But in my case, I just want to remove it from displaying. And if you want it too. This is my solution (thought a little bit ugly):  
  
put it in initializers/override_human_attribute_name.rb  

		class ActiveRecord::Base  
		 def self.human_attribute_name(*attribute)  
		 super(*attribute)  
		 return ""  
		 end  
		end  
		  
And restart the rails server.  
  
By the way, in [in Ruby Forum][2]. There is a solution that override human_attribute_name too with a custom mapping HUMANIZED_COLUMNS hash. But the solution doesn't work straightly. It's because in ActiveModel::Errors have it's own count method. Which need some calculate in human_attribute_name. And if you don't provide it in your override. It will fail on calling model_instance.errors.count  
  
That's why i call super before returning empty string. Maybe you got better solution. Welcome provide in follow. I will appreciate your sharing!

[2]: http://www.ruby-forum.com/topic/196109
[3]: http://stackoverflow.com/questions/898754/translated-attributes-in-rails-error-messages-rails-2-3-2-i18n
