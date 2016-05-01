---
layout: post
title: rails 2.0 如何把controller跟view放到子資料夾使用
published: true
date: 2008-02-24 18:25
tags: []
categories: [tw]
comments: true

---


(最下面有補充正解)  
  
看過「ruby on rails專業網站案例實作」這本書的話  
應該知道他們把幾個controllers放到admin資料夾底下  
/app/controllers/books_controller.rb  
移到/app/controllers/admin/　底下  
  
網址也從localhost/books  
變成了localhost/admin/books  
  
在升級到rails 2.0後卻讓我搞老半天  
經過一些人的指導  
我得到一個暫時的答案  
  
答案是：  
1.不需要用子資料夾就可以換網址  

> 如果有需要從localhost/books  
> 變成了localhost/admin/books  
> 只要改routing即可達到目的  
> 但是routing的設定在此不提

  
2.不應該把程式檔案放在子資料夾  

> 不應該有撞名的問題，所以不需要到把controllers分到資料夾做分類  
> 如果放到子資料夾了，routing路徑也改了，就會有template is missing的問題（我猜是因為rails假設不會用到子資料夾，所以樣板當然也不會去子資料夾找）

  
  
2010-2-23補充：正解是[使用namespace][1]  
(正解其實早就知道了，只是我很久沒寫rails就懶得記筆記...XD)

[1]: http://guides.rubyonrails.org/routing.html
