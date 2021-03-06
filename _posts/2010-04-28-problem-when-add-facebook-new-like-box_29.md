---
layout: post
title: Problem when add the facebook new Like Box to google Blogger?
published: true
date: 2010-04-28 20:37
tags: []
categories: [tw]
comments: true
redirect_from:
  - /2010/04/problem-when-add-facebook-new-like-box.html
---


For English reader please read [this post][1] instead


我想要新增Facebook新版的Like Box (原本的Fan Box)到google blogger，但是他的iframe一直跟我說找不到頁面。後來找到了[這個][1](英文)，解法如下：

先在Facebook給你的code裏面，找到這段(YOUR_FACEBOOK_PAGE_ID是一串數字)：


```
...profile_id=YOUR_FACEBOOK_PAGE_ID...
```

把他改成：

```
...profile=1&id=YOUR_FACEBOOK_PAGE_ID...
```

就搞定了。收攤！

[1]: http://www.arlooblog.com/2010/04/facebook-like-box-html-gadget-for.html
