---
layout: post
title: Todoist 'add task' not working in chrome, mac (solved)
published: true
date: 2012-11-20 02:23
tags: []
categories: []
comments: true

---
[todoist.com][1] behaves strange in my chrome (mac). I can't add any new tasks either edit tasks nor sorting.

I am not sure which is the actual key to solve this problem. I did two things and after restart Chrome, it back to works correctly.

First, I found that when I use Todoist in incognito mode (browse in private), it works all right. So I try to disable extensions one-by-one. But still not found any question extension. So I did:


### 1. Clear all browser cache

I cleaned cache (but not restart chrome yet) and tried. But still not working. **Maybe you should restart chrome now and see if it was fixed**.


### 2. Use [NoScript][2] extension to block suspicious sites

I opened up inspector and found out that every time I click on 'add task above' or 'add task below', it throws a javascript error. And the script file which contains the problem line is from a site called '8-apps.net'. I don't know this site, I think is included by an extension. So I'm gonna block it.

NoScript extension do need some configuration. If you don't set it up, It will block nearly ALL sites by default.


### 3. Restart chrome

It works again :-)


Now I open up inspector again. It doesn't even try to load the suspicious javascript file anymore. This was how I feel (well... in some ways):


[![][3]][4]




[1]: http://todoist.com/
[2]: https://chrome.google.com/webstore/detail/notscripts/odjhifogjcknibkahlpidmdajjpkkcfn
[3]: http://4.bp.blogspot.com/-VbW0Vjhp9jU/UKvJcLZF9-I/AAAAAAAAA8c/P1WxbdwwqjY/s400/3r1wn0.jpeg
[4]: http://4.bp.blogspot.com/-VbW0Vjhp9jU/UKvJcLZF9-I/AAAAAAAAA8c/P1WxbdwwqjY/s1600/3r1wn0.jpeg
