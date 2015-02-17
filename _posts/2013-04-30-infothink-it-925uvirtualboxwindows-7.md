---
layout: post
title: 安裝InfoThink IT-925U讀卡機到VirtualBox內的Windows 7 (Host是Mac)
published: true
date: 2013-04-30 20:28
tags: []
categories: []
comments: true

---


我不確定VirtualBox Guest Additions是不是必要的，但是我有裝。  
  

## 安裝 VirtualBox Extension Pack 來支援 USB 2.0

1. [下載 VirtualBox Extension Pack][1]
2. 由以下路徑安裝： Preferences > Extensions > Add package

[![][2]][3]

  

## 啟用 USB 2.0 (EHCI) Controller

  
路徑在 Settings > Ports > USB  
  

> 你可能會想新增一個 USB Device Filter. 在我的機器上讀卡機顯示為 `Generic USB2.0-CRW` (做這件事情之前要插上讀卡機讓他可以抓到) 
> 

  

[![][4]][5]  
  

## 啟動VM裡面的系統，並安裝讀卡機驅動程式

  

1. [下載並安裝InfoThink的官方驅動程式][6]
2. 插入讀卡機
3. 順利偵測到硬體後，應該就會自動設定好了



[1]: https://www.virtualbox.org/wiki/Downloads
[2]: http://1.bp.blogspot.com/-VORbL0ki678/UYD7KzesLwI/AAAAAAAABL8/uqu_xnLansM/s640/install_extensions.png
[3]: http://1.bp.blogspot.com/-VORbL0ki678/UYD7KzesLwI/AAAAAAAABL8/uqu_xnLansM/s1600/install_extensions.png
[4]: http://1.bp.blogspot.com/-UAn2Zl0ue8s/UYD7Gua60QI/AAAAAAAABL0/UYBA-m0NkCs/s640/enable_usb_2.png
[5]: http://1.bp.blogspot.com/-UAn2Zl0ue8s/UYD7Gua60QI/AAAAAAAABL0/UYBA-m0NkCs/s1600/enable_usb_2.png
[6]: http://www.ittec.com.tw/download.htm