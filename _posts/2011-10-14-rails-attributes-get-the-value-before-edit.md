---
layout: post
title: '[已解決] Rails如何取得修改前attribute原本的值？'
published: true
date: 2011-10-14 08:00
tags: []
category:
- tw
comments: true
redirect_from:
  - /2011/10/railsattribute.html
---


我修改了某個attribute，但還沒儲存，要如何取得修改前的值？

硬幹的作法就是在改值之前先用個local variable存起來，但是否有更優美的解法呢？

有！就用 attribute_name_was


請看以下範例：

		ruby-1.9.2-p290 :003 > u.email
		 => "basdfasdf@asdawdfas.com"
		ruby-1.9.2-p290 :004 > u.email="xxxxx@xxxxxx.xx"
		 => "xxxxx@xxxxxx.xx"
		ruby-1.9.2-p290 :005 > u.email
		 => "xxxxx@xxxxxx.xx"
		ruby-1.9.2-p290 :006 > u.email_was
		 => "basdfasdf@asdawdfas.com"

但是save以後就會被洗掉：
		ruby-1.9.2-p290 :007 > u.save
		 => true
		ruby-1.9.2-p290 :008 > u.email_was
		 => "xxxxx@xxxxxx.xx"


以下是追蹤attributes變化的methods（來自[RailsCasts][1]）
p.changed?
p.changed
p.changes
p.name_changed?
p.name_was
p.name_change
p.name_will_change!

[1]: http://railscasts.com/episodes/109-tracking-attribute-changes
