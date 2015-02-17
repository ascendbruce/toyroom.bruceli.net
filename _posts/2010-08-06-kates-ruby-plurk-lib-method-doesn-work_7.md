---
layout: post
title: kates's ruby plurk lib 'add_all_as_friends' method doesn't work?
published: true
date: 2010-08-06 16:09
tags: []
categories: []
comments: true

---


正體中文版[在此][1] (Traditional Chinese version is [here][1])

[kates's ruby plurk lib][2] is a nice plurk lib for ruby. But I notice that the 'add_all_as_friends' method doesn't work and always throws an exception (API call return an error message page and JSON parse failed)


Add following code before you new a Plurk::Client

		module Plurk
		 class Client
		 ENDPOINTS[:add_all_as_friends] = {:path=>"/API/Alerts/addAllAsFriends", :login_required=>true}
		 end
		end

This is because that the API path is /API/Alerts/addAllAsFriend**s** not /API/Alerts/addAllAsFriend. The [code][3] shows that they amiss lost the ending 's'. And I will contact them to fix this.

[1]: http://railsfun.tw/viewthread.php?tid=454
[2]: http://github.com/kates/plurk
[3]: http://github.com/kates/plurk/blob/master/lib/plurk.rb
