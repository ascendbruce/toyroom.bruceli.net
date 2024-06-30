---
layout: post
title: 備份 Ubuntu Linux 系統並自動上傳備份檔到另一台 server
published: true
date: 2013-07-14 23:28
tags: []
category:
- tw
comments: true
redirect_from:
  - /2013/07/backup-linux-system.html
---


備份的基本觀念參考自 Ubuntu 社群文件 [BackupYourSystem/TAR][1]。

我對 linux 管理以及 shell script 都不是很熟，所以有什麼錯誤觀念請多指教。


## TL; DR


		#!/bin/bash

		export timestamp=$(date +"%Y%m%d%H%M%S")
		tar -cvpzf /tmp/backups/backup_$timestamp.tar.gz --exclude='/tmp/*' --exclude='/more_to_ignore/*' --one-file-system /
		su - username /bin/bash -c "scp /tmp/backups/backup_$timestamp.tar.gz username@another.server.com:/home/username/backups/backup_$timestamp.tar.gz"


## 基本想法



1. 用 tar 指令把大部分東西都打包起來
2. 用 scp 指令上傳到另一台 server
3. 以上步驟寫成 shell script 並用 crontab 自動執行




## 動手



### 用 tar 指令把大部分東西都打包起來


參考上述文件，打包的指令如下

		tar -cvpzf /tmp/backup.tar.gz --exclude='/tmp/backup.tar.gz' --exclude='/more/path/to/exclude/*' --one-file-system /

有幾個注意事項：


1. 打包的目的檔案一定要被exclude掉，不然會有問題
2. 雖然大部分 options 都可以變換順序，但f不行。不過你也可以明確的寫成 `tar -cvpz -f ...`。
3. 好像這樣解釋的蠻不清不楚的，想知道 `-cvpzf` 跟 `--one-file-system` 參數在幹嘛、哪些目錄適合 exclude 掉等資訊可以到上述文件看。




#### 問題：權限不足 Permission denied


出現大量的以下訊息

		tar: /some/files: Cannot open: Permission denied

我的解法是 `sudo su -` 成 root 帳號，用 root 身分來打包。


#### 打包過程中出現 `file changed as we read it` 的訊息


		tar: /var/lib/mysql/ibdata1: file changed as we read it

以這個為關鍵字去找，沒找到什麼資料，我猜這可能只是 warning，而非 error，所以打包結果還是ok的。


### 用 scp 指令上傳到另一台 server


沒用過 scp 的話先想辦法成功傳送一個檔案，可參考[這篇教學][2]。

這個步驟我是用一般身分做的，假設帳號是 `username`，目標server是 `another.server.com`，把剛才的 `/tmp/backup.tar.gz` 傳到遠端 server：

		scp /tmp/backup.tar.gz username@another.server.com:/home/username/backups/backup.tar.gz

此時他應該會問你在 `another.server.com` 的密碼，但我們接下來要用 crontab 自動執行啊！被詢問密碼檔下來就不能自動化了，所以請參考 [兩行指令搞定 Linux SSH登入免密碼][3]，想再深入了解一點的話可以看 [josephj：SSH 免密碼登入][4]。


### 以上步驟寫成 shell script 並用 crontab 自動執行


接下來要合體了


#### 1. 開一個 `system_backup.sh` 檔案，然後把把上兩步驟的丟進去


第一行記得寫這個：

		#!/bin/bash


#### 2. 用 username 身分執行 scp


因為剛才是用 username 帳號設定免密碼登入的，所以欲享免密碼、還是得用 username 帳號。我不確定用 root 設定登入到遠端免密碼會不會有什麼後遺症，但我已經做到這步了，就沒想那麼多了。

換身分的方法是 `su - username 指令`，所以我把那行變成：

		su - username /bin/bash -c 'scp 指令...'


#### 3. 避免檔名重複問題，加上 timestamp


取得現在時間，並 format 成 `20130715235959` 這樣的格式：

		export timestamp=$(date +"%Y%m%d%H%M%S")

把取得的時間字串變成檔名的一部分

		backup_$timestamp.tar.gz

最後修改名稱、路徑等，得到完成的 shell script 檔：

		#!/bin/bash

		export timestamp=$(date +"%Y%m%d%H%M%S")
		tar -cvpzf /tmp/backups/backup_$timestamp.tar.gz --exclude='/tmp/*' --exclude='/more_to_ignore/*' --one-file-system /
		su - username /bin/bash -c "scp /tmp/backups/backup_$timestamp.tar.gz username@another.server.com:/home/username/backups/backup_$timestamp.tar.gz"

用單引號 `'` 會讓變數出不來，所以要用雙引號 `"` 號喔！


#### 4. 設定 crontab


		sudo crontab -e

第一次設定 crontab 的時候會問你要用哪個編輯器，它應該會顯示數字選項，就打數字告訴他你要用哪個。

		10 16 * * * /bin/bash -c '/root/system_backup.sh'

關於 crontab 的設定請參考 [鳥哥-crontab][5]。

需注意的是我的 server 的時區是UTC，而我希望他在 12:10AM UTC+8 的時後備份，所以要 24-8 = 16點。


## 追加



### 自動刪除老舊備份檔


檔名符合 `backup_*.tar.gz` 者，刪到只剩 2 個：(我採用的方法)

		find /tmp/backups/ -name "backup_*.tar.gz" | sort | head -n -2 | xargs -I % rm -f %

刪除建立時間久於 7 天者：

		find /tmp/backups/ -mtime 7 -exec rm -f {} \;

以上挑一種寫成 bash script，然後放到 crontab，我是一個星期清一次。


### 匯出進度輸出到 log 檔


改寫crontab：

		10 20 * * * /bin/bash -c '/root/system_backup.sh >> /root/backup_process.log 2>&1'

結尾的 2>&1 很重要，不寫的話，可能訊息會沒印到檔案裡。原理可參考 [Unix 重新導向跟 2>&1][6]。

另外也要修改 tar 的參數，拿掉 `-v` ，例如：

		tar -cpzf /tmp/backups/backup_$timestamp.tar.gz …

因為 `-v` 會吐出詳細的壓縮過程，但是要寫到 log 裡面的訊息只要 warning 跟 error 就好了。


### 其他安全考量


前輩要求定期刪除的 script 跟 cron 要放在一般權限的帳戶裡，以免被攻破後只要改一小行就可以 `rm -rf /`，那就升天了。

為了達到這件事情，要把 owner 指定給接受的使用者 `username`，並放在該 user 可以存取刪除的資料夾。



[1]: https://help.ubuntu.com/community/BackupYourSystem/TAR
[2]: http://blog.riaproject.com/server-setting/1644.html
[3]: http://gwokae.mewggle.com/wordpress/index.php/archives/669
[4]: http://josephjiang.com/article/understand-ssh-key/
[5]: http://linux.vbird.org/linux_basic/0430cron.php#cron
[6]: http://ibookmen.blogspot.tw/2010/11/unix-2.html
