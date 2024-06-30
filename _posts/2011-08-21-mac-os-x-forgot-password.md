---
layout: post
title: Mac OS X 10.7 Lion 忘記密碼/密碼明明正確卻無法登入怎麼辦
published: true
date: 2011-08-21 12:13
tags: []
category:
- tw
comments: true
redirect_from:
  - /2011/08/mac-os-x-107-lion.html
---


筆者今天喚醒mac後密碼一直跟我報錯誤，打算把密碼給滅了，上網找了一下，以下是看到的三種方法。

方法一：如果你的電腦上還有其他系統管理者
方法二：透過安裝光碟/USB
方法三：single-user mode 硬幹法

不過在介紹之前我必須說，最後我並沒有真正使用以上任何一種方法，正打算使用開機USB碟而重開機時，忘記按option鍵而一路load到登入畫面，想說再try一次好了，結果一發登入|||

好吧，那來介紹一下這三種方法了。

[方法一][1]：
登入其他的管理者帳號
系統偏好設定>使用者>選要解鎖的帳號>設定密碼

[方法二][2]：
放入開機光碟(或開機USB碟)>重開機>要開始開機程序之前，按住option鍵（也就是PC鍵盤的alt鍵）
工具程式>設定密碼
如果登入後一直跳出鑰匙圈視窗，可以到鑰匙圈存取更新密碼一下

[方法三][3]：除非你知道自己在做什麼，否則不要用這個方法
開機時按住cmd+S進入single-user mode

fsck -y
mount -uaw /
rm /var/db/.AppleSetupDone
reboot

重開完成以後會出現新電腦的歡迎畫面，創建一個新帳號（不要跟原本的帳號名稱衝突）
然後就看你要怎麼處置原本的帳號了


以上三種方法沒有一個親自試過，祝好運XD



[1]: http://support.apple.com/kb/ht1274?viewlocale=zh_TW&locale=zh_TW
[2]: http://docs.info.apple.com/article.html?path=Mac/10.5/yh/11627.html
[3]: http://news.ipadown.com/1590
