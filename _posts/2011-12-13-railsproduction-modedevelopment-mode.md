---
layout: post
title: 如何讓rails在production mode下直接在網頁顯示錯誤訊息?（像development mode那樣）
published: true
date: 2011-12-13 14:54
tags: []
category: [tw]
comments: true
redirect_from:
  - /2011/12/railsproduction-modedevelopment-mode.html
---


# 修改 config/environments/production.rb
# 找到config.consider_all_requests_local

		config.consider_all_requests_local = true # 預設是false

重開web server，就完成啦！


- - - - - - - -

How to showing error message on web just time in production mode, like in development mode?

## in config/environments/production.rb
# find "config.consider_all_requests_local"
		config.consider_all_requests_local = true # default is false

restart web server, and you're done



