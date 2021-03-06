---
title: Facebook like button code snippet for Google Blogger (iframe, 3 different style)
published: true
date: 2012-07-04 10:00
tags: []
categories: [en]
comments: true

---

![](/images/world.png) 正體中文版: [幫Google Blogger加入Facebook讚按鈕]({% link _posts/2012-07-03-facebook-like-button-code-snippet-for-blogger.md %})

Notice: Those code snippets are only for Google Blogger. If you want to add a like button to your web page, try [official code generator][2].

Most people place like button in post footer. To do that, paste code snippet right below this line:
		<div class='post-footer'>


So, here are 3 most popular style of like button:

Standar layout **with** face:

		<iframe allowTransparency='true' expr:src='&quot;http://www.facebook.com/plugins/like.php?href=&quot;
		+ data:post.url + &quot;&amp;layout=standard&amp;show_faces=true&amp;width=450&amp;action=like&amp;font=verdana&amp;colorscheme=light&quot;'
		frameborder='0' scrolling='no' style='border:none; overflow:hidden; width:450px;
		height: 65px;'/>

[![][3]][4]



Standar layout **without** face:

		<iframe allowTransparency='true' expr:src='&quot;http://www.facebook.com/plugins/like.php?href=&quot;
		+ data:post.url + &quot;&amp;layout=standard&amp;show_faces=false&amp;width=450&amp;height=35&amp;action=like&amp;font=verdana&amp;colorscheme=light&quot;'
		frameborder='0' scrolling='no' style='border:none; overflow:hidden; width:450px;
		height:35px;'/>

[![][5]][5]



Button count:

		<iframe allowTransparency='true' expr:src='&quot;http://www.facebook.com/plugins/like.php?href=&quot;
		+ data:post.url + &quot;&amp;layout=button_count&amp;show_faces=true&amp;width=100&amp;action=like&amp;font=verdana&amp;colorscheme=light&quot;'
		frameborder='0' scrolling='no' style='border:none; overflow:hidden; width:100px;
		height: 21px;'/>

[![][6]][6]




----


[2]: https://developers.facebook.com/docs/reference/plugins/like/
[3]: http://3.bp.blogspot.com/-b9DumAT8kZI/T_N82tFhilI/AAAAAAAAAzE/0NrsXhAKgQI/s320/standar_face.png
[4]: http://3.bp.blogspot.com/-b9DumAT8kZI/T_N82tFhilI/AAAAAAAAAzE/0NrsXhAKgQI/s1600/standar_face.png
[5]: http://2.bp.blogspot.com/-2UZjEw2x3BI/T_N83HSewOI/AAAAAAAAAzM/Mb-riTy83Z0/s1600/standar_no_face.png
[6]: http://4.bp.blogspot.com/-UzLSA5QSPBE/T_N814CtiMI/AAAAAAAAAzA/yMetgPJ_jaI/s1600/button_count.png
