---
layout: post
title: 如何修改git檔名大小寫
published: true
date: 2012-11-29 18:15
tags: []
categories: [tw]
comments: true

---
![](/images/world.png) English version: [Git: How to Rename a File Into Differ Case]({% post_url en/2012-12-01-git-how-to-rename-a-file-into-difference-case %})

今天手殘把某個資料夾大小寫打錯，導致rails沒辦法找到正確的檔案，但想改名的時候發現，如果直接改大小寫，git並不會抓到修改！  
  
雖然可以下  
		git config core.ignorecase false  
		讓git改成case-sensitive，但是不知道對其他專案會造成什麼副作用。  
  
翻幾篇網路教學後（[How do I rename a file in git that differs by case only?][2]、  
[git mv and only change case of directory][3]）  
  
最後我的解決方式如下：  
	mv Typo typo_temp  
	git add . # 加入 staging area  
	mv typo_temp typo  
	git add .  
	git commit -m "Fix case typo"看到的教學裡，有些會在temp步驟就commit一次，我只有放到staging area而已，但還是可行的。  
  
  
====  
  
  
附帶一提，我那該死的錯誤是：  
  
我想讓/users能routes去/app/controller/api/users_controller (類似scope :module的用途)，目的是保持API位置，但把code移到子目錄：  
		# routes.rb  
		get "users" => "api/users_controller#index"  
		但是，沒錯，就是那個api/ 子資料夾的大小寫打錯了！  
  
很機車的是他在我的開發機上很正常，一上production機器就炸 ActionController::RoutingError (uninitialized constant Api)  
  
但理論上這樣子連開發機都該炸啊！？真是奇妙@_@

[2]: http://apple.stackexchange.com/questions/51346/how-do-i-rename-a-file-in-git-that-differs-by-case-only
[3]: http://stackoverflow.com/questions/3011625/git-mv-and-only-change-case-of-directory
