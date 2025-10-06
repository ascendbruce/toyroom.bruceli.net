---
title: "近況報告 2018 December"
excerpt: 接續上次的近況報告 2018 August，分享公司旅行、Agile 新體悟、awesome_rails_console 修正、Dokku 部署經驗，以及各種科技產品開箱（iPad Pro、Mac mini、Grado 耳機等）。
category:
- tw
tags:
- life
- 敗家好物
- lifeupdates
date: 2018-12-31 00:00:00 +0800
image: /images/posts/2018-12-31-diary-2018-december/1_M7jSvF-No_X6EH-v5ZVK7g@2x.jpg
---

接續[上次的近況報告 2018 August]({% link _posts/2018-08-31-diary-2018-august.md %})

## 我又去了公司的旅行

絕對不是故意的，但這次又剛從公司旅行回來了。

![公司旅行]({% link /images/posts/2018-12-31-diary-2018-december/1_M7jSvF-No_X6EH-v5ZVK7g@2x.jpg %})

公司幾乎把整個公司的人召集起來參加 staff retreat。雖然三天半基本上都是公司的正式活動（除了晚上是酒會），但不得不說公司願意停下大部分部門的日常運作，花錢辦活動、包船票、包吃、包住，實在是非常有心。

## 一些 Agile 新體悟

因為職務轉變，現在需要多管一些任務排程，加上公司也正在熱烈討論開發方法論。就因此做了不少功課，官方的 Agile Manifesto 跟 The Scrum Guide 不用說，Scrum 的正反面文章也看了不少，其中這兩篇給我特別多共鳴：

- [Why SCRUM Backlogs lead to bad Product Decisions](https://medium.com/@jobvo/why-scrum-backlogs-lead-to-bad-product-decisions-574f4b0e8b7e)
- [When SCRUM Stand-Up Meetings feel like an Interrogation …](https://medium.com/@jobvo/when-scrum-stand-up-meetings-feel-like-an-interrogation-f1c5a8ed5d0c)

不完全同意，但確實很多部分有共鳴。簡短的心得如下（不限於上述兩篇）：

- 實做 Scrum 不代表你 Agile。
- Agile 不是萬靈丹，有時候就是應該用 Waterfall。例如當「遲交」比「做錯產品」後果還嚴重的時候應該用 Waterfall。
- 人類不擅長估計時間，兩個解法：練習更精準的估計、或者放棄估計準度。採用 Scrum 的團隊通常會採用 Point Poker 以及 Retrospective 來一次次改善時間估計能力，但你再怎麼準，不可能百發百中，軟體開發可不是折紙鶴。而我比較喜歡後者：不強調「有沒有準時」，而是強調要從最重要的事情開始做，而且開始的事情有盡快完成。當然人在江湖身不由己，估計、或者說「預報」還是必要的，但不要花太多時間跟心神在「把時間估準」，藉由放棄「高準度」、省下時間跟心神來做好其他更重要的事。
- 主要的 dashboard 裡不要有太長的 backlog，因為 card 太多就會增加心理負擔，有太多 cards 千年不動也會很洩氣。解決方法是在另外一個地方寫 Roadmap（如 Google Docs 或 Dynalist），當 idea 逐漸清晰、能分解成可執行步驟、也有資源實做的時候才放進 backlog，一旦放進去要盡快結案，確保 swim lanes 之間有很頻繁的流動而不是一灘死水。另一個解決方法是把備忘票從主要的 dashboard 中隱藏，眼不見為淨，而且確保成員們了解那些備忘票終究只是備忘，開成 cards 時要依照當下條件重新思考。
- 用 Time in List 視覺化「票的停滯程度」。讓你很容易發現停滯特別久的票，讓問題顯現出來。知道問題是解決問題的第一步。
- 用 WIP Limit 克制分心、Finish what you started。除了在 "In Progress" 設置 WIP Limit，我認為在 Backlog 設置 Limit 也是很重要的，因為當你的 Backlog 有 500 張有待開始的 cards 的時候，就會對 Limit 麻木不仁。
- Daily Standup 的時候可以考慮採用 Walking the board—以票為主角。以票為主角的好處是，再一次，加強 swim lanes 之間的流動。不過我覺得以人為主角的 Scrum 三個經典問題也是很 Ok 的。

我也立刻套用在我自己的私人任務管理，目前覺得還蠻好的，因為之前幾次都是因為太多票堆積而越來越不想看，最後變成「時常開出 chore 雜務然後優先消化掉，重要的事卻丟在一旁」。有意識的壓低 open 中的票，似乎有幫助，讓我可以分多一點注意力在「重要但不緊急」的事上。但一兩個月還太早斷定，之後若有新的心得也會分享。

我的 Trello board power-ups 設置是（要先有 Trello Gold (US$5/mo) 開啟 3 個 Power-ups）

- Custom Fields
- Agile Tools: WIP Limits
- Time in List for Trello (US$3/mo per person)

附帶一提，我的個人任務管理 Trello board 現在最新的票號是 #2376，這還沒算上早期在試行失敗時拋棄舊 Board 的份。

## 終於推出 awesome_rails_console 修正

這是我幾年前發布的 ruby gem，其中 hirb-unicode 一直有版本 dependency 的問題，雖然安裝的時候很容易排除，但就是芒刺在背。

也因為上面說的任務管理新嘗試，推了自己一把，就終於做下去了。但太久沒維護，果然搞砸了，但，完成了就是完成了，結果 Alright。

附帶一提，這個 gem 目前累積下載量突破 50k 了，最開始其實只是一篇分享文章：[超棒的 rails console 設定]({% link _posts/2014-08-13-awesome-rails-console-customization-using-pry.md %})。

## 把 side project 主機重架成 dokku

我之前用 intercity 管我自己的 side project 的 server。但 intercity 倒了，我不想自己維護 chef。跟幾個朋友討論後，我決定試試 dokku。這東西簡單來講就是 heroku 單機版。deploy 一樣是 git push 超簡單。

目前跑了 1 個月多，感覺還不錯。之後可能會寫一篇文章分享我怎麼 setup 的。

## 買了 iPad Pro 11"

因為前一代的鍵盤跟筆設計不是很理想，我一直很期待新款 iPad Pro，也有存預算。新的設計解決了好幾個重大缺點，從 iPad Pro 9.7" 跳過 10.5" 直接上 11" 是大升級，所以就砸錢買下去了。

![iPad Pro 11"]({% link /images/posts/2018-12-31-diary-2018-december/1_PT_H30DokVSgVAVZxsX-PQ@2x.jpg %})

有些人可能會想問，iPad Pro 值得買嗎？

我喜歡用 iPad Pro + Notability 畫圖思考，主要勝過紙筆的點是畫到邊邊、空間不夠畫還可以調整。除此之外也常用平板在健身房邊跑步邊看動畫，不這麼做的話有時很難找到時間悠閒地看動畫。再來就是會拿來看電子書（所以可以輕鬆拆掉保護殼很重要，才不用捧著一整組很重）

其實整體來說有點殺雞用牛刀，大部分功能都可以用新 iPad 做到，但 iPad Pro 體驗真的比較好。例如 Apple Pencil 反應較快、四邊都有喇叭、不用靠藍牙跟電池的 Smart Keyboard 鍵盤。不要小看這些小缺點，累積下來還是會爆發的。

## Philips Type-C 行動電源

因為手上的行動電源推不動 iPad Pro，一怒之下直接衝了一顆規格滿載的行動電源。

![Philips Type-C 行動電源1]({% link /images/posts/2018-12-31-diary-2018-december/1_tIbHiGKr606jsogHZoJd7w.jpg %})
![Philips Type-C 行動電源2]({% link /images/posts/2018-12-31-diary-2018-december/1_YO2BsEVIgrp2tOeTVAb1_w.jpg %})
![Philips Type-C 行動電源3]({% link /images/posts/2018-12-31-diary-2018-december/1_5deZMQrjLmNkc5rbMzjbdA.jpg %})

容量 10000 mAh，接孔依序是 USB 2.1A、Type-C 3A、QC 3.0。再加上之前累積起來的轉接頭，主流規格基本上都可以應付。我都把行動電源跟線放在一個小收納包裡放在背包裡，自己偶爾用到外、也解救過好幾個朋友 XD

但還是得說，帶著一堆轉接頭真的很蠢，希望下一代 iPhone 換成 Type-C，這樣再過幾年就可以省略轉接頭啦。


想知道那個多拉A夢滑鼠墊哪裡買嗎？這背後其實有個感慨，我特地發了一篇[貼文解釋]({% link _posts/2018-10-05-doraemon-mouse-pad.md %})。

## Anker soundcore Spirit X

除了行動電源推不動外，還有一個問題：這代 iPad Pro 的拿掉 Lightning 孔了，我慣用的 JBL Reflect Aware 防水 Lightning 運動耳機變成無用武之地，只好去買了條藍牙耳機替代。

![Anker soundcore Spirit X]({% link /images/posts/2018-12-31-diary-2018-december/1_S8sQdXRY4c84MBocNG5mEg.jpg %})

選這支的原因是防水防汗+被動隔音+ Bluetooh 5.0，因為我的主要使用情境是在健身房看動畫、但不想被健身房內播放的電音歌曲干擾（這也是為什麼我前一支是 JBL Relfect Aware，防水防汗+主動抗噪+有線）。

我基本上不喜歡藍牙耳機，因為 lag 跟斷線問題還是沒辦法根絕。雖說 BT 5.0 應該會比較好，可能從 works 99.5% of time 改善到 works 99.9% of time，但有線的話可以 works 100% of the time 啊！為什麼我非得忍受耳機有時不 work 呢？

說到這個就還得抱怨一下 Apple，不跟進 aptX, LDAC，自己搞一個 W1 chip，但又只有自家的 AirPod 跟 beats 有支援，導致選擇非常少，最後只得放棄 W1 chip 耳機的選擇。看看 Powerbeats3 Wireless 那精美的 1.8 顆星跟劣評。

還好有找到這隻 BT 5.0 的產品，用到目前穩定度確實還不錯。更棒的是因為這是電池大廠 Anker 進入無線耳機市場的試水溫產品，定價跟類似產品相比並不貴（39.99 USD），推薦！

## Grado SR60e

![Grado SR60e]({% link /images/posts/2018-12-31-diary-2018-december/1_wMllz0YY05DhKwWuezartw@2x.jpg %})

說到耳機，我今年收到 Grado SR60e 當生日禮物，這隻是 CP 值高得有名的入門耳機，能因此收編真是太感謝了。

## mac mini

![mac mini]({% link /images/posts/2018-12-31-diary-2018-december/1_ad1b7kV9mBJetfeonXESTA.jpg %})

另外也買了新的灰色 mac mini

這筆錢就花得很名正言順了，因為我的 MacBook Pro 2011 電池已經膨脹撐開外殼，哪天突然冒火都不意外，但我還是需要一台 Mac 來開發。

選 mac mini 的原因是，我之前就幾乎都把筆電當桌機用，後來電池退化後更沒辦法帶出去用（一下就沒電了），所以實質上已經是桌機了。加上最近幾代的 MacBook 設計問題一大堆，我就想：為何不買 mac mini 就好呢？

所以就付諸實踐了。而且因為前一台也用 7 年了，當然也有早有購買的預算。

## 撿到便宜二手 Bose Compainon 20 電腦喇叭

![Bose Compainon 20]({% link /images/posts/2018-12-31-diary-2018-december/1_Ix3Mr35l1YdOUHV6XyLS3w.jpg %})

再回到音樂相關產品，之前有過一台 Focal XS Book，但後來音量旋鈕壞了，不想自己處理、就賣掉了。後來就一直在找替代品，心目中的第一名其實是 Genelec 的主動式監聽喇叭，但畢竟貴且以後若要搬回台灣也沒辦法帶回去用（因為電壓不可調），所以最後還是買了簡單的產品。

新加坡定價 S$399，我撿到二手 S$150，非常劃算，唯一的問題就是旋扭的橡皮已經開始發黏了。雖然網路上有處理方法，但終究還是一時的，我覺得貼一層 3M 膠帶比較直接。

其實論聲音我喜歡 Focal XS Book 多一點，但那個旋扭的耐用度實在太讓人灰心了。

## 對照辦公桌 setup

![辦公桌 setup 2]({% link /images/posts/2018-12-31-diary-2018-december/1_W-Av9439y-7I5fb77V7xKg.jpg %})

如你所見，我有幾樣設備跟辦公小物都買了兩份，一份放辦公室、一份放家裡，我喜歡維持熟悉的環境。


其中那個 Belkin 無線充電器，底座是 3D 列印出來的，設計圖從[這裡](https://www.thingiverse.com/thing:2892828)找到的，然後透過 3D Hubs 找代印。

辦公室照片中的筆電立架則是 Daiso 的「砧板立架」。

講了一堆新買的玩具，最後來說說一個其他的變化吧：

## 我 unfollow 了 Facebook 上的所有朋友

![fb unfollow]({% link /images/posts/2018-12-31-diary-2018-december/1_TRxeg_NY20jxsO1Nt8ksoA.png %})

忘記在哪裡看到的文章推薦的撇步：把所有人都 unfollow（但保持 friend），這樣你不由自主打開 Facebook 後也沒東西可以看，就會覺得無聊，漸漸的就脫離 Facebook 的控制了。

實踐以後，我的 Facebook 時間確實驟減（但其他分心網站稍有增加）。可是跟大家動態更新脫節的感覺其實不是很好（這也是為什麼「刪除 Facebook 帳號」那麼難做到），雖然想到某個朋友的時候還是可以去對方牆上看一下，但我很確定我一定錯過了一些我有興趣的話題。可是同時我也不想改回去，因為脫離 Facebook 控制的利應該是大於弊，所以我目前還在爭扎中。

你用什麼方式控制自己的 Facebook 時間呢？歡迎留言分享。
