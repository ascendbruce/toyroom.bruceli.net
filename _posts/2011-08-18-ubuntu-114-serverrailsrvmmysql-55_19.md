---
layout: post
title: ubuntu 11.4 server純文字下安裝rails環境範例（含rvm,編譯mysql 5.5）
published: true
date: 2011-08-18 17:45
tags: []
category:
- tw
comments: true
redirect_from:
  - /2011/08/ubuntu-114-serverrailsrvmmysql.html
---


* 經virtual box測試，Ubuntu 10.4 LTS也適用。

這其實是我架設公司的server的筆記
本篇目標是裝到一個可以用WEBrick跑rails app的環境，所以不含apache或mod_rails之類的，可能之後再做整理分享。


### SECTION 1 安裝ubuntu

先下載並燒好ubuntu-11.04-server-i386.iso
安裝ubuntu就不詳細說明了，主要要注意的是

* 語言要選擇English，否則有些目錄可能會變成中文的之類的，總之是個麻煩
* 分割(partition)：依照你的需求
* 新增第一個使用者，將會是sudoer(具有系統管理權限)
* 設定使用者時會問你要不要加密家目錄，我是為了保留以後舊資料的機會，所以都選不加密
* 安裝過程會問你要不要裝某些server，把OpenSSH Server打＊（按空白鍵）。或者系統裝好之後補安裝：


		sudo apt-get update #如果找不到套件的話，可能需要先update
		sudo apt-get install openssh-server

＊vim基本操作
接下來很多都要透過vim修改，被圖型介面寵壞的人...w...最少要知道以下的東西：

* vim開檔案以後，還不能輸入，要按i鍵進入編輯模式
* 離開編輯模式按Esc
* 儲存並離開：wq (按Enter) (w是儲存，q是離開。這必須是在Esc退出編輯模式時打才有用，下同)
* 不儲存並離開：q! (按Enter) (!是強制離開的意思，因為如果有未儲存修改的時候，單純q是退不出去的)
* 修改一些系統用的檔案時，可能會因為權限不足無法儲存，請先強制離開後再用sudo vim 該檔案



### SECTION 2 設定網路，改成固定ip

		sudo vim /etc/network/interfaces

原本的內容：
		# The loopback network interface
		auto lo
		iface lo inet loopback

		# The primary network interface
		auto **eth0**
		iface eth0 inet **dhcp**

如果有多張網卡，那要確認是用哪一張(eth0, eth1, ...?)
原本是dhcp，要改成固定ip(手動設定)

修改成類似這樣：
		# The loopback network interface
		auto lo
		iface lo inet loopback

		# The primary network interface
		auto eth0
		iface eth0 inet **static**
		address:192.168.12.86
		netmask:255.255.255.0
		gateway:192.168.12.1

[參考][1]



### SECTION 3 安裝MySQL 5.5

前置動作，安裝一些需要的套件
		sudo apt-get update
		sudo apt-get upgrade
		sudo apt-get install build-essential zlib1g-dev libssl-dev libreadline5-dev `git-core `	curl # git-core跟curl是安裝rvm時會用到的


> * 目前mysql官方是5.5了，但是ubuntu套件庫裡面還是5.1，如果你不指定要mysql 5.5的話，可以直接用apt-get安裝：
> 		sudo apt-get install mysql-server
> 		安裝過程會要你輸入(以設定)mysql root的密碼


但是我們要手動編譯mysql 5.5，以下：

		sudo apt-get install cmake bison libncurses5-dev

		sudo groupadd mysql
		sudo useradd -r -g mysql mysql

		wget "http://www.mysql.com/get/Downloads/MySQL-5.5/mysql-5.5.15.tar.gz/from/http://mysql.he.net/"
		mv index.html mysql-5.5.15.tar.gz
		tar -xvzf mysql-5.5.15.tar.gz
		cd mysql-5.5.15
		cmake -LAH > options
		cmake .
		sudo make
		sudo make install

		cd /usr/local/mysql
		sudo chown mysql.mysql -R .
		sudo ./scripts/mysql_install_db --user=mysql

		sudo ./bin/mysqld_safe --user=mysql &
		sudo ./bin/mysql_secure_installation
		#他會引導你設定mysql root密碼，以及一些選項，我是全部都打Y (yes)

		sudo cp support-files/my-huge.cnf /etc/my.cnf
		sudo cp support-files/mysql.server /etc/init.d/mysql

		ps -Al | grep mysqld_safe #這行與下一行都只是為了砍掉mysqld_safe，其實重開機後應該也就沒了
		sudo kill -SIGKILL <<pid>> #<<pid>>是找出剛才的mysql_safe的pid

		sudo update-rc.d -f mysql defaults ＃開機自動執行

		sudo vim /etc/profile
		# 加在最尾端；
		PATH=$PATH:/usr/local/mysql/bin


[參考1][2], [參考2][3]


### SECTION 4 設定網站用的系統帳號

我希望把網站的開發環境放在某一個user之下，但又想讓多個開發者access，聽前輩的建議是開一個專用的user account但是不給登入，需要access的人 先登入私人帳號，再用su切換身分。這麼做的目的是su切換身分時會留記錄在/var/log/auth.log。
		sudo adduser --disabled-login projectx #projectx是專用的帳號的名稱
		sudo su - projectx # 有加-號才會載入環境變數, 如果不用sudo切換他會要求你輸入projectx的密碼，但其實projectx並沒有設定密碼(剛才下--disabled-login參數以後，他就會跳過設定密碼，因為沒有密碼，所以就停用登入)

日後要增加其他的使用者時，以下
		sudo adduser 使用者名稱
		sudo adduser 使用者名稱 admin #加入admin群組，成為sudoer，如此才可以用sudo su - projectx


### SECTION 5 安裝rvm, ruby

rvm要裝在一個user底下，也就是剛才建出來的user，所以以下操作要在su切換到該使用者之後做。

安裝rvm
		bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)

安裝後他會有訊息顯示要你把以下指令放在shell loading file的最尾端，在ubuntu的話是~/.bashrc，不過他應該已經幫你加好了。附帶一提，在mac上是~/.profile
		[[ -s "/home/bruce/.rvm/scripts/rvm" ]] && source "/home/bruce/.rvm/scripts/rvm" # This loads RVM into a shell session.

他建議你開啟一個新shell，不過主要是為了剛才加在shell loading file的東西，所以給他load一下就可以了，順便試試看rvm可否執行：
		source ~/.bashrc
		rvm list

我目前要用的是1.9.2而已，安裝：
		rvm install 1.9.2
		rvm list #應該就會看到剛才裝的ruby 1.9.2了
		rvm 1.9.2 --default #設定成default的ruby


### SECTION 6 設定gemset, 安裝Rails

		rvm gemset create r309
		rvm gemset use r309
		gem install rails mysql2



### SECTION 7 跑一個rails app測試一下

		rails new blog -d mysql
		cd blog
		vim config/database.yml #修改成正確的mysql帳號密碼
		bundle install
		rake db:create
		rails generate scaffold post title:string body:text
		rake db:migrate
		rails server



### 其他需要用到的套件

這就看各專案需求了
		sudo aptitude install libxslt1-dev libxml2-dev

		#安裝 ghostscript
		brew install ghostscript

		#加入中文字型
		copy 中文字型 到指定目錄下（路徑在程式裡面指定）


[1]: http://blog.jsdan.com/2508
[2]: http://greensysadmin.com/2011/01/24/mysql-5-5-installing-from-source-ubuntu-debian/
[3]: http://www.linuxidc.net/thread-2338-1-1.html
