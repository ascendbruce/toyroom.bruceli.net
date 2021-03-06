---
layout: post
title: Tutorial - 如何安裝lslplus或lslforge
published: true
date: 2011-12-02 18:05
tags: []
category: [tw]
comments: true
redirect_from:
  - /2011/12/tutorial-how-to-install-lslplus-plugin.html
---

<a href="{% link _posts/2011-12-02-tutorial-how-to-install-lslplus-en.md %}" class="lang-btn">EN</a>
<a href="{% link _posts/2011-12-02-tutorial-how-to-install-lslplus.md %}" class="lang-btn lang-current">TW</a>

LSL stands for Lindin Script Language. [There are some alternative editors][1].

= = = = = =

這份教學講的是lslplus，不過這個專案已經停擺了，有個folk project叫[lslforge][2]，建議用這個。

1. 安裝Eclipse IDE，如果你只會拿來寫LSL，那就下載C/C++版

2. 複製[這個][2]的網址（是lslforge），或到[這裡][3]選一個更新站複製URL（lslplus）。

3. 在Eclipse，開選單 Help > Install New Software...


[![][4]][5]


4. 把剛才的URL貼到Work with那個文字框，按Enter

5. 讀取一段時間後，他應該會告訴你：There are no categorized items.

***** Important *****

6. 這裡是重點：把Group items by category選項取消

[![][6]][7]


7. 然後就會出現plugins列表了

[![][8]][9]


8. 選擇適當的OS版本，像我用mac就選Lslplus_part_macosx_x86

9. 安裝當中，他會要求你同意license，以及要選「信任」這個unsigned plugin.

10. 完成了！

[1]: http://wiki.secondlife.com/wiki/LSL_Alternate_Editors
[2]: http://code.google.com/p/lslforge/
[3]: http://lslplus.sourceforge.net/update-site-list.html
[4]: http://4.bp.blogspot.com/-_s-JZk7nW2o/Ttn09B03IQI/AAAAAAAAAk0/SXojj7kveFU/s400/step1.png
[5]: http://4.bp.blogspot.com/-_s-JZk7nW2o/Ttn09B03IQI/AAAAAAAAAk0/SXojj7kveFU/s1600/step1.png
[6]: http://2.bp.blogspot.com/-tx-nchxFKr4/Ttn0990XUWI/AAAAAAAAAk8/vD6Sk2xNRQg/s400/step2.png
[7]: http://2.bp.blogspot.com/-tx-nchxFKr4/Ttn0990XUWI/AAAAAAAAAk8/vD6Sk2xNRQg/s1600/step2.png
[8]: http://2.bp.blogspot.com/-o7RQT3ibBb8/Ttn0-7JHWuI/AAAAAAAAAlE/a-srkQ8AmWc/s400/step3.png
[9]: http://2.bp.blogspot.com/-o7RQT3ibBb8/Ttn0-7JHWuI/AAAAAAAAAlE/a-srkQ8AmWc/s1600/step3.png
