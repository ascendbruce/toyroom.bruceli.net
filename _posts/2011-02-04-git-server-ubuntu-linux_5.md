---
layout: post
title: 簡易git server架設教學 (用Ubuntu linux)
published: true
date: 2011-02-04 17:51
tags: []
categories: []
comments: true

---
**1. 安裝git：**  
		sudo apt-get install git-core  
		  
  
**2. 在server端建立放置所有projects的目錄：**  
我的習慣是放在/var/git  
		cd /var  
		sudo mkdir git  
		  
  
**3. 在server端建立project：**  
步驟3,5,6是**每開一個新project就要做一遍**的，假設現在我開了一個專案叫new_project  
		cd /var/git  
		sudo mkdir new_project.git  
		# 如果是第二次新增project，記得也要改該資料夾的群組跟權限，相關步驟在step 4有寫  
		cd new_project.git  
		sudo git --bare init  
		  
  
**4. 建立git的群組：**  
因為我放在/var之下，這邊要root權限，當你用你的帳號pull東西上去時，會爆權限不足。但是把他改成權限全開的話(chmod 777 ...)又很危險。所以我開一個git的群組，讓會傳東西的人加到這個群組。  
		sudo groupadd git  
		sudo usermod -a -G git your_login # your_login改成你自己的帳號。  
		# 下面這兩行，在每次新增新project時要對新的資料夾補做  
		sudo chgrp -R git /var/git  
		sudo chmod g+rwx -R /var/git  
		  
  
**在local端**，假設我的project資料夾是/path/to/your/projects/new_project  
  
**5. 初始化git：**  
		cd /path/to/your/projects/new_project  
		git init  
**6. 把我們遠端的repository加到git remote：**  
	`git remote add origin ssh://your_login@your.host/var/git/new_project.git/` 
	這邊的路徑要注意，別打成ssh://your_login@your.host:/var/git/new_project.git   
會爆以下錯誤：  
		ssh: Could not resolve hostname : Name or service not known  
		fatal: The remote end hung up unexpectedly  
		  
  
**7. 把我們local的程式碼丟上去：(每次commit的例行步驟)**  
		git add .  
		git commit -m '註解'  
		git push origin master  
		  
常用git指令小筆記：  
git add 檔案名稱 #加到本次commit  
git add -i #加檔案的互動介面  
git status # 看準備要commit的檔案  
git grep 關鍵字 # 在專案中搜尋關鍵字  
git diff # 看本次變動  
git log # 看log  
git rm 檔案名稱 # 從準備要commit的檔案清單中去除，加-f參數強制刪除  
git remote # 會列出來remote列表。總之就是git remote add new_remote ssh://... 。新增以後，打這個指令就會出現new_remote。名稱可以自己取，但如果需求單純的話，一般都習慣取作origin。  
  
  
  
如果你懶得每次要一直打密碼，可以參考[SSH免密碼登入][1]  
  
參考文章：  
[Debian Linux 架設使用 SSH 存取 的 Git Server][2]  
[簡易git server 架設][3]

[1]: http://josephjiang.com/article/understand-ssh-key/
[2]: http://plog.longwin.com.tw/my_note-unix/2009/05/08/build-git-env-over-ssh-2009
[3]: http://rj-king.blogspot.com/2010/03/git-server.html