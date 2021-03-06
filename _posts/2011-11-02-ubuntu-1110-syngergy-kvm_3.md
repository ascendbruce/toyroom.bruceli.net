---
layout: post
title: ubuntu 11.10 設定Syngergy (軟體KVM) 一擊必殺秘技
published: true
date: 2011-11-02 17:39
tags: []
categories: [tw]
comments: true
author: idarfan
redirect_from:
  - /2011/11/ubuntu-1110-syngergy-kvm.html
---


Syngergy How to 軟體KVM

步驟1：
QuickSynergy 要先安裝。 伺服器及Client 端都要安裝.透過software center 安裝就可以了
本篇文章是參考自 https://help.ubuntu.com/community/SynergyHowto
步驟2： 編修 /etc/synergy.conf 檔案。 依hostname 及螢幕相對的左右位置
sudo gedit /etc/synergy.conf
section: screens
yourserver:
compaq:
end
section: links
yourserver:
left = compaq
compaq:
right = yourserver
end

步驟3 ：手動分別啟動 synergy and synergyc
手動伺服器端的啟用
synergy
手動client 端的啟用
synergyc 192.168.0.11：24800
需在synergyc 後面加上伺服器的host name

一開機就要自動啟動它的方式。我是改用了gdm,參考底下的做法。唯一要注意的是使用QuickSynergy 在server端那邊要加上port號
像是 192.168.0.11:24800
https://help.ubuntu.com/community/SynergyHowto

底下的手動修改將分為伺服器端及客戶端。
Manual Configuration

The following steps assume you are setting up synergy on a host computer named myserver and a client computer namedmyclient.



On the Server

Synergy configuration can go in your home folder called .synergy.conf or in /etc/synergy.conf. It is up to you whether you would like the changes to be per-user or system-wide.

Here is a sample configuration that will be the needs of 95% of users:

section: screens
myserver:
myclient:
end
section: links
myserver:
right = myclient
myclient:
left = myserver

end
myserver is the hostname of the computer running synergys (providing the keyboard and mouse) myclient is the hostname of the computer running synergyc (using the keyboard and mouse provided by myserver) section: screens is where you set the host names of the computers going to be used. section: links is what side the mouse will leave the screen of one computer to reach the desktop of the other. myserver is set to the left of myclient, so when I drag the mouse off the right hand side ofmyserver's screen it appears on the left hand side myclient's screen. Use up/down instead of left/right to establish and over/under sort of relationship.



Running Synergy

From the server, run the command:

synergys
From the client, run the command:

synergyc
Replacing  with either the hostname (myclient) or IP address of myclient.

You should now be able to move your mouse pointer off the right edge of your server's screen and see it show up at the left side of your client's screen. See the steps in the next section to make synergy start automatically on the host and client computers.

If you have any problems at this point it is helpful to run synergys and synergyc in the foreground with the -f option. This allows you to see error/status information that synergy prints to the terminal.

搭配gdm 使用時。在未登入前就要能夠使用Synergy 。依不同的GDM 有不同的設法
以我的範例是使用GDM
Autostart Synergy before logging in (GDM), ubuntu 預設沒有安裝GDM 得下 sudo apt-get install gdm 才行
安裝好重新開機。再做底下的修改
Note: Autostarting Synergy before logging in requires that your network connection be available at all times and not just after you log in. This is accomplished by enabling the network connection for all users. To do this, choose System->Preference->Network Connections. Choose the network name and select Edit. Select "Available to all users", and then click "Apply". This connection will now be available at all times, including at the GDM login screen.

To make sure synergy is running at all times, the following has to happen: First, synergy is started when the GDM login screen starts. Then, synergy is killed and restarted when a user logs in. When the user logs out, synergy is killed and GDM starts it again. To edit system configuration files in the following sections open a text editor as the root user:

底下的檔案都要用 sudo gedit 來編修。有些檔案沒有新建就可以了



sudo gedit


On the Server

At the end of the file /etc/gdm/Init/Default, just before the line that says exit 0 add the following:

/usr/bin/killall synergys
while [ $(pgrep -x synergys) ]; do sleep 0.1; done
/usr/bin/synergys
Add the following to the end of /etc/gdm/PostLogin/Default (create this file file if it does not already exist):

/usr/bin/killall synergys
while [ $(pgrep -x synergys) ]; do sleep 0.1; done
If you created the file, make sure it is executable with this command:

sudo chmod +x /etc/gdm/PostLogin/Default
Now, create a session file /etc/X11/Xsession.d/85synergys with the following contents

/usr/bin/killall synergys
while [ $(pgrep -x synergys) ]; do sleep 0.1; done
/usr/bin/synergys
Lastly, we must make the file executable with this command:

sudo chmod +x /etc/X11/Xsession.d/85synergys


On the Client

At the end of /etc/gdm/Init/Default, just before the line that says exit 0 add the following:

/usr/bin/killall synergyc
while [ $(pgrep -x synergyc) ]; do sleep 0.1; done
/usr/bin/synergyc
重點在這行,請改成 /usr/bin/synergyc 192.168.0.11:24800
原因是這軟體有時無法正確透過hostname 來建立連接,port 號是用預設的。
請注意你的防火牆是否有放行
Be sure to replace  with the host name or IP address of the computer running synergys.

記得關閉自動登入帳號.因為這會造成問題. 不然請你把 /etc/gdm/Init/Default 裏相關Syngergy的設定給移除掉
若你己經遭到不幸了。畫面被卡住無法登入到xwindows 請你爽快的按下CTRL-ALT-F1 登入再把底下綠色部份的標示給
移除掉

NOTE: If your system has been configured to login automatically, this step may cause ubuntu to hang right before going to the desktop. If this is the case, remove these lines from /etc/gdm/Init/Default and everything should work properly. If your system is hanging at this stage, you can hit CTRL-ALT-F1 to login through command line and edit this file.(Tested on 10.04LTS Lucid Lynx)

Add the following to the end of /etc/gdm/PostLogin/Default (create this file file if it does not already exist):

/usr/bin/killall synergyc
while [ $(pgrep -x synergyc) ]; do sleep 0.1; done
If you created the file, make sure it is executable with this command:

sudo chmod +x /etc/gdm/PostLogin/Default
Now, create a session file /etc/X11/Xsession.d/85synergyc with the following contents

/usr/bin/killall synergyc
while [ $(pgrep -x synergyc) ]; do sleep 0.1; done
/usr/bin/synergyc
重點在這行,請改成 /usr/bin/synergyc 192.168.0.11:24800
原因是這軟體有時無法正確透過hostname 來建立連接
This will run synergyc when any user logs in. Be sure to replace  with the host name or IP address of the computer running synergys. Lastly, we must make the file executable with this command:

sudo chmod +x /etc/X11/Xsession.d/85synergyc



