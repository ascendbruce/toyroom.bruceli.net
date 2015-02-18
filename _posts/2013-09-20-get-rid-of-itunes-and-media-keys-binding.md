---
layout: post
title: Mac多媒體快速鍵老是開啟iTunes，如何幹掉這個惱人的功能
published: true
date: 2013-09-20 03:18
tags: []
categories: []
comments: true

---
English version: [Disable iTunes launching by 'Play' media key]({% post_url 2013-08-22-disable-itunes-starts-by-media-key %})

在 Mac 上，多媒體快速鍵的播放鍵總是會打開 iTunes、或優先控制 iTunes，即使你已經打開了其他播放軟體如 VLC, Songbird, KKBox, Spotify 等。

這種行為超煩的，因此 Farhan Ahmad 寫了一個[補丁](https://github.com/thebitguru/play-button-itunes-patch)，可以把這個預設的行為斷開，之後快速鍵就會對播放器一視同仁，你開哪個、就控制哪個（前提是播放器本身有支援）。所以如果一次開啟兩個播放器，可能會兩個同時播放、或一個暫停另一個卻開始播放喔。

以下是所需指令，打開 Terminal.app 後貼上：

    cd ~/Documents/
    git clone https://github.com/thebitguru/play-button-itunes-patch.git
    cd play-button-itunes-patch
    chmod u+x *
    ./Patch.command

然後關閉 iTunes

現在，按多媒體快速鍵應該不會再打開 iTunes 了。

再執行一次 `Patch.command` 可以恢復原狀。
