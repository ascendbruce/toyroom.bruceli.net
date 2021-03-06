---
layout: post
title: Ubuntu下如何把MySQL 5.5裝到其他的目錄（例如家目錄）教學
published: true
date: 2011-10-15 12:55
tags: []
categories: [tw]
comments: true
redirect_from:
  - /2011/10/ubuntumysql-55.html
---


之前就寫過一篇[mysql編譯裝到預設位置的教學][1]，如果要裝到指定的位置呢？


我把安裝那段修改了一下，其他部分是一樣的，最重要的是cmake給的參數，以下這幾個尤其重要：
-DCMAKE_INSTALL_PREFIX：mysql的basedir
-DMYSQL_DATADIR：放DB資料的資料夾，這個資料夾的權限設定非常重要
-DMYSQL_USER：跑mysql的系統帳號，通常習慣是建立一個「mysql」的帳號
-DSYSCONFDIR：mysql設定檔所在的資料夾，一般是放在/etc/

( 情境是我要把mysql裝到/home/bruce/mysql/ )

MySQL 5.5開始改用cmake，所以以前是下./configure，現在要下cmake
裝好跑不起來的話，十之八九跟目錄權限有關！


		sudo apt-get install cmake bison libncurses5-dev

		sudo groupadd mysql
		sudo useradd -r -g mysql mysql

		wget "http://www.mysql.com/get/Downloads/MySQL-5.5/mysql-5.5.15.tar.gz/from/http://mysql.he.net/"
		mv index.html mysql-5.5.15.tar.gz # 在某些版本下wget後會直接是檔名，就不需要執行這行
		tar -xvzf mysql-5.5.15.tar.gz
		cd mysql-5.5.15
		cmake -DCMAKE_INSTALL_PREFIX=/home/bruce/mysql -DMYSQL_DATADIR=/home/bruce/mysql/data -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DENABLED_LOCAL_INFILE=1 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSETS=all -DMYSQL_TCP_PORT=3306 -DMYSQL_USER=mysql -DSYSCONFDIR=/home/bruce .
		make
		make install

		cd /home/bruce/mysql
		sudo chown mysql.mysql -R .
		./scripts/mysql_install_db --user=mysql

		./bin/mysqld_safe --user=mysql &
		./bin/mysql_secure_installation
		#他會引導你設定mysql root密碼，以及一些選項，我是全部都打Y (yes)

		cp support-files/my-huge.cnf /home/bruce/my.cnf # cmake時的DSYSCONFDIR參數
		sudo cp support-files/mysql.server /etc/init.d/mysql

		ps -Al | grep mysqld_safe #這行與下一行都只是為了砍掉mysqld_safe，其實重開機後應該也就沒了
		sudo kill -SIGKILL <<pid>> #<<pid>>是找出剛才的mysql_safe的pid

		sudo update-rc.d -f mysql defaults ＃開機自動執行

		sudo vim /etc/profile
		# 加在最尾端；
		PATH=$PATH:/usr/local/mysql/bin


如果mysql/data底下出現其他不是owned by mysql或group不是mysql的檔案可能會造成error
我有遇到這樣的問題，但不知道在什麼情況下會重現，所以要注意一下

[1]: http://littlebmix.blogspot.com/2011/08/ubuntu-114-serverrailsrvmmysql.html
