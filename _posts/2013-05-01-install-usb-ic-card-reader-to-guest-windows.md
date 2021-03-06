---
title: Install USB IC Card Reader to Guest Windows 7 (Host is Mac)
published: true
date: 2013-05-01 21:10
tags: []
category: [en]
comments: true
image: http://1.bp.blogspot.com/-VORbL0ki678/UYD7KzesLwI/AAAAAAAABL8/uqu_xnLansM/s1600/install_extensions.png
---

<a href="{% link _posts/2013-05-01-install-usb-ic-card-reader-to-guest-windows.md %}" class="lang-btn lang-current">EN</a>
<a href="{% link _posts/2013-04-30-install-usb-ic-card-reader-to-guest-windows.md %}" class="lang-btn">TW</a>

I'm not sure if it requires VirtualBox Guest Additions. But I did install it.

## Install VirtualBox Extension Pack to support USB 2.0
1. [Download VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads)
2. install at Preferences > Extensions > Add package

<img src="http://1.bp.blogspot.com/-VORbL0ki678/UYD7KzesLwI/AAAAAAAABL8/uqu_xnLansM/s1600/install_extensions.png"></img>

## Enable USB 2.0 (EHCI) Controller
Settings > Ports > USB

> You may want to add an USB Device Filter. In my machine, the card reader shown as `Generic USB2.0-CRW` (you need to plug in first to let system detect it)

<img src="http://1.bp.blogspot.com/-UAn2Zl0ue8s/UYD7Gua60QI/AAAAAAAABL0/UYBA-m0NkCs/s1600/enable_usb_2.png"></img>

## Boot-up guest OS and install card reader driver

1. Download and install card reader driver as you usually do
2. Plug in the card reader
3. Once guest windows system detected it, it should setup automatically
