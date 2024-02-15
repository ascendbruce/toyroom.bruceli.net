---
title: 如何節省 ChatGPT 訂閱費但達到類似體驗：改訂 Setapp
excerpt: ChatGPT 訂閱費不便宜 (US$20/mo) 雖說 ChatGPT 有幫助，但以我的用量，總覺得沒有真的很 justify 它的訂閱費。總之呢，之前剛好看到 Ash Wu 分享：Setapp 訂閱其實有包含 OpenAI API 免費 quota，而且 quota 其實並不算少...
tags:
- productivity
- 好用工具
category:
- tw
---

## 前言

ChatGPT 訂閱費不便宜 (US$20/mo)

雖說 ChatGPT 有幫助，但以我的用量，總覺得沒有真的很 justify 它的訂閱費。

而且其實幾個月前就有看到「現在 ChatGPT 訂閱不划算，OpenAI API 計價比較划算」的說法。

## 替代方案

總之呢，之前剛好看到 [Ash Wu 分享：Setapp 訂閱其實有包含 OpenAI API 免費 quota](https://twitter.com/hSATAC/status/1742825905083552136)，而且 quota 其實並不算少。

> Setapp 簡單來說就是 mac 應用程式的吃到飽，付固定月費就可以用平台內的多種付費軟體。

因為我有在訂 Setapp，所以就順手查一下，發現 Setapp 裡其中一個 app 叫做 TypingMind，就是一個聊天 UI，背後串接 OpenAI API，簡單來說就是第三方做的 ChatGPT client，操作方式跟 ChatGPT 大同小異，而且還有一些進階選項。

![screenshot of TypingMind app](/images/posts/2024-01-22-chatgpt-alternative-setapp-typingmind.png)

所以用了幾天後，覺得替代起來沒什麼問題，就決定取消訂閱 ChatGPT 了。

這不是唯一一種替代方案，也有其缺點存在（下面會寫到），不過對我來說夠用了，橫向評測不是我關注的點所以也沒有更深入研究。

這個方法有個很重要的特性，那就是：

## 划算！

尤其你如果現在有訂 ChatGPT 的話。

你看喔，ChatGPT 月費 US$20，改訂 Setapp 的話平均月費 US$8.99，除了可以用 TypingMind、還附帶每個月免費 OpenAI quota，加上 OpenAI API 費用算全部 $15 好了，還省 $5 塊，等於 Setapp 裡面的 app 全都是免費送的。裡面不乏受歡迎且單買要數十美金的 apps，例如我自己愛用的：

- AlDente Pro - 設定電池充電上限，延長電池 lifetime 壽命
- Bartender - 隱藏次要的 status bar icon，尤其瀏海款 Macbook 會擋到
- Gemini - 好用的 duplicate finder
- CleanMyMac - 偶爾想大清理硬碟空間的時候可以用
- RapidAPI (以前叫 Paw) - 介面友善、功能也多的 API client，推薦網頁/後端工程師使用
- TablePlus - 介面友善、功能也多的 DB GUI，單買要 $89 也只保證一年更新而已
- Dash for macOS - 搜尋速度很快的開發文件搜尋，單買是 €15 但每幾年大改版就要付費升級

> Setapp 宣布會在 2024-02-28 推出新的方案 "Setapp AI+"，同時普通方案能用的額度將會降低。不過如果你的用量不大的話，就搭配自己的 Open AI API 來用也是不貴的。

<blockquote class="hightlight">
  <b>如果你還沒註冊過 Setapp，歡迎使用 <a href="https://setapp.sjv.io/c/5130946/1857409/5114">我的推薦連結</a> 註冊訂閱！</b>

  利益揭露: 你訂閱的話我會得到一些分潤，不過都以上是我真心推薦。其實我是先寫到這裡才想到應該插個 AP 連結、才去申請的 XD...
</blockquote>

如果不喜歡訂閱模式，想買斷（長期省錢）的話，TypingMind 本身可以用 US$39\~79 買斷 (越貴的方案功能越多)，差不多是 ChatGPT 訂 2\~4 個月而已，就算假設一年後使用 AI 的方式會完全顛覆好了，能用一年也是划算的。而且很多人甚至在這之前都已經續訂 ChatGPT 超過 4 個月了，只是把接下來的續訂金移過去，從這個角度看也可以是划算的選擇。

那就沒缺點嗎？當然不可能

## 缺點

我目前能想到最虧的狀況是：當 ChatGPT 推出新的獨家功能、而且你很想趕快使用該功能，就會只能回頭訂 ChatGPT，等於兩邊都花錢。甚至如果有管制總使用者人數，想重新付費升級搞不好還得排隊。

例如，就在寫這篇文的時候，官方剛正式推出了 GPT 商店，但我初步看其他人的心得跟新聞（說是一堆人違規推出 AI 女友 XD），這次我決定先觀望就好。但未來肯定也會繼續推出新功能，會不會哪天推出讓我現在馬上立刻想要的新功能，我也不知道。

這好像也沒什麼辦法，就是得自行考量風險。

其他缺點

- ChatGPT 的最新功能的支援度、high demand 時候的穩定度、對話的優化程度，可能跟官方有差距。
- Setapp GTP-4 雖然有免費 quota，但目前觀察有極高機率遇到 timeout error，改用自己的 OpenAI API 付費 token 就比較少問題，所以時不時要切換並重試。
- 沒有手機 app。typingmind.com 本身可以用瀏覽器開、可以加到 homescreen 當 app 用，但 mac 跟手機之間的 cloud sync 就變成很頭大的問題：
  - cloud sync 功能目前還是 beta，不知道可不可靠
  - 我不太想再多讓一個第三方儲存我的資料
  - Setapp 的 TypingMind 的授權不能用在網頁版本上，所以在手機上要當免費仔，限制多，更無法 sync (想要跨裝置 sync 的話，就只能買 TypingMind 的買斷授權了)

除此之外，也需要多幾個步驟

- 以前需要排隊申請開通 OpenAI API，現在好像不用排了，但還是要去產 access token
- 目前，OpenAI API 剛註冊完是不會馬上開啟 GPT4 model 的，需要先儲值一筆 US$10 才會解鎖，但規則可能會隨著時間變，詳細請看官方公告

## 結語

總之，推薦有在付費 ChatGPT 但又只有輕～中度使用的人，可以考慮看看 Setapp (TypingMind + 免費 quota) 的組合，來節省點訂閱費。

然後如果你還沒註冊過 Setapp，歡迎使用 <a href="https://setapp.sjv.io/c/5130946/1857409/5114">我的推薦連結</a> 註冊訂閱。
