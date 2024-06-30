---
layout: post
title: ubuntu救回sudoer權限 筆記
date: '2011-10-31T17:57:00.000+08:00'
tags:
- dev
modified_time: '2011-10-31T18:02:13.152+08:00'
blogger_id: tag:blogger.com,1999:blog-2109693232346004651.post-5209477718297616768
blogger_orig_url: https://blog.bruceli.net/2011/10/ubuntusudoer.html
category:
- tw
redirect_from:
  - /2011/10/ubuntusudoer.html
  - /tw/2011/10/30/ubuntusudoer_31.html
---

這是朋友idarfan遇到的問題，然後他又自己搞定掉，所以分享踩雷筆記給我

系統更新後，不知道哪個更新有問題，所有sudoer都會被踢出admin group
所以要把自己加回來

但是自己已經不是sudoer了，怎麼辦？

朋友的解法

開機的時候按著Shift進入recovery mode
進去以後先不要按Enter，先按e
編修載入核心那段，大概長這樣：

linux /boot/vmlinuz-3.0.0-12-generic root=UUID=11B7FAE1-5F0A-4088-BE\AD-1302BE2FC37D **ro** recovery nomodeset

把那個ro改成rw，游標移到行尾，Enter執行

Ctrl+X 就會回到recovery mode

就可以下
usermod -G admin -a 你的帳號
把你加回admin group

#我朋友還有下 usermod -G root -a 你的帳號 。不知道有沒有影響?

reboot # 重開機



