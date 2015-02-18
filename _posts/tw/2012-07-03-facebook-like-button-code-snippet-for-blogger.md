---
layout: post
title: 幫Google Blogger加入Facebook讚按鈕(like button)
published: true
date: 2012-07-03 08:41
tags: []
categories: [tw]
comments: true

---

English Version: [Facebook like button code snippet for Google Blogger (iframe, 3 different style)]({% post_url en/2012-07-04-facebook-like-button-code-snippet-for-blogger %})

注意：以下的程式碼片段是Google Blogger專用的，如果你想幫一般網頁加上讚按鈕，請使用[官方的程式碼產生器][1]。  
  
大部分人都把讚按鈕放在文章頁腳，如果你也要這麼做，把程式碼貼在這行的下一行：  

		<div class='post-footer'>  
		  
  
嗯，以下是三個最流行的讚按鈕：  
  
標準外觀+顯示臉:  

		<iframe allowTransparency='true' expr:src='&quot;http://www.facebook.com/plugins/like.php?href=&quot; 
		+ data:post.url + &quot;&amp;layout=standard&amp;show_faces=true&amp;width=450&amp;action=like&amp;font=verdana&amp;colorscheme=light&quot;' 
		frameborder='0' scrolling='no' style='border:none; overflow:hidden; width:450px; 
		height: 65px;'/>

[![][2]][3]

  
  
標準外觀**不**顯示臉:  

		<iframe allowTransparency='true' expr:src='&quot;http://www.facebook.com/plugins/like.php?href=&quot; 
		+ data:post.url + &quot;&amp;layout=standard&amp;show_faces=false&amp;width=450&amp;height=35&amp;action=like&amp;font=verdana&amp;colorscheme=light&quot;' 
		frameborder='0' scrolling='no' style='border:none; overflow:hidden; width:450px; 
		height:35px;'/>

[![][4]][4]

  
  
按鈕+計數:  

		<iframe allowTransparency='true' expr:src='&quot;http://www.facebook.com/plugins/like.php?href=&quot; 
		+ data:post.url + &quot;&amp;layout=button_count&amp;show_faces=true&amp;width=100&amp;action=like&amp;font=verdana&amp;colorscheme=light&quot;' 
		frameborder='0' scrolling='no' style='border:none; overflow:hidden; width:100px; 
		height: 21px;'/>

[![][5]][5]

  
  

----



[1]: https://developers.facebook.com/docs/reference/plugins/like/
[2]: http://3.bp.blogspot.com/-b9DumAT8kZI/T_N82tFhilI/AAAAAAAAAzE/0NrsXhAKgQI/s320/standar_face.png
[3]: http://3.bp.blogspot.com/-b9DumAT8kZI/T_N82tFhilI/AAAAAAAAAzE/0NrsXhAKgQI/s1600/standar_face.png
[4]: http://2.bp.blogspot.com/-2UZjEw2x3BI/T_N83HSewOI/AAAAAAAAAzM/Mb-riTy83Z0/s1600/standar_no_face.png
[5]: http://4.bp.blogspot.com/-UzLSA5QSPBE/T_N814CtiMI/AAAAAAAAAzA/yMetgPJ_jaI/s1600/button_count.png
