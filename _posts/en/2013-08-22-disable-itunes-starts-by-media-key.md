---
layout: post
title: Disable iTunes launching by 'Play' media key
published: true
date: 2013-08-22 05:07
tags: []
categories: [en]
comments: true

---
正體中文版: [Mac多媒體快速鍵老是開啟iTunes，如何幹掉這個惱人的功能]({% post_url tw/2013-09-20-get-rid-of-itunes-and-media-keys-binding %})

By default, Mac always starts iTunes when you press Play media key on the keyboard even when VLC, Spotify, KKBox or Songbird player opened.

This can be annoying. [This patch](https://github.com/thebitguru/play-button-itunes-patch), authored by Farhan Ahmad, can remove the default behavior. And allows you to control the only opened player correctly.

    cd ~/Documents/
    git clone https://github.com/thebitguru/play-button-itunes-patch.git
    cd play-button-itunes-patch
    chmod u+x *
    ./Patch.command

And restart iTunes

Now, the media keys should not work for iTunes.

Run `Patch.command` again to re-enable.
