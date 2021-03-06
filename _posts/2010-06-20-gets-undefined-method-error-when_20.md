---
layout: post
title: Gets undefined method error when calling parse method?
published: true
date: 2010-06-20 04:18
tags: []
category: [tw]
comments: true
redirect_from:
  - /2010/06/gets-undefined-method-error-when.html
---

		irb(main):001:0> Time.parse("16:30")
		NoMethodError: undefined method `parse' for Time:Class

Also rfc2822(), httpdate() and xmlschema(date) raises this error.


Solution: require the time.rb:
		require 'time'

This is not a bug. It's because they are not core (But Time class is). Some implementation may auto require for you. But if you get this error, just try to require it.

[Reference 1][1], [2][2]



==Traditional Chinese version==

呼叫Time.parse時得到undefined method錯誤？

		irb(main):001:0> Time.parse("16:30")
		NoMethodError: undefined method `parse' for Time:Class

rfc2822(), httpdate() and xmlschema(date) 也會爆這個錯誤


解決方法： require time.rb:
		require 'time'

這不是bug，這是因為這些methods不是core(但Time class本身是)，有些implementation可能會自動幫你require，但如果你遇到這個error，就試試看require 'time'

[參考來源 1][1], [2][2]

[1]: https://bugs.archlinux.org/task/9809
[2]: http://www.ruby-forum.com/topic/172936
