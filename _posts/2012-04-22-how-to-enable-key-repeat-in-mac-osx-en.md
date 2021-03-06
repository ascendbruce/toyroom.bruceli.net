---
title: How to enable key repeat in Mac OSX 10.7 Lion
published: true
date: 2012-04-22 10:00
tags: []
category: [en]
comments: true

---

<a href="{% link _posts/2012-04-22-how-to-enable-key-repeat-in-mac-osx-en.md %}" class="lang-btn lang-current">EN</a>
<a href="{% link _posts/2012-04-22-how-to-enable-key-repeat-in-mac-osx.md %}" class="lang-btn">TW</a>

After upgrading to Lion, the behavior of holding a key was became characters chooser (eg.  [àáâ...] for holding "a"). And this is bothering me.

To re-enable:

1. Open a Terminal, paste and run:
defaults write -g ApplePressAndHoldEnabled -bool false

2. reboot your mac
