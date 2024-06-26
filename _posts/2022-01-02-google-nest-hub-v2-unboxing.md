---
title: Google Nest Hub (第二代) 使用心得：功能很多、串連很強，但大致上都很難用
excerpt: 最近 Google Nest Hub 相關的開箱文章、評測影片也越來越多了，我當初很期待、而且是用預購的，但實際用起來發現難用的點是在太多了，想寫文分享一下我的實際體驗。
category:
- tw
tags:
- life
- 敗家好物
---

<blockquote class="hightlight">
  我後來也拍成了一集影片，別忘了去看看：

  <iframe width="560" height="315" src="https://www.youtube.com/embed/E2DCwTcPzZQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</blockquote>

最近 Google Nest Hub 相關的開箱文章、評測影片也越來越多了，我當初很期待、而且是用預購的，但實際用起來發現難用的點是在太多了，想寫文分享一下我的實際體驗 ~~抱怨一下~~ 。

總得來說，我覺得 Google Nest Hub 還有**極巨大**的改善空間，但它也確實有幫我實現一些以前我辦不到的應用方式，所以我不會說這是不值得買的東西，但要買的話記得要有正確的預期：不要期待它能全面提升房子的智慧，它有強項，但大致上都很蠢。

![cover](/images/posts/2022-01-02-google-nest-hub.jpeg)

## 我為什麼購入 Google Nest Hub

（不 care 我為什麼要買 Gooole Nest Hub 的話，可以直接跳到下一個大段落）

我原本就有買智慧燈，原因是要模擬日出幫助我調整起床時間。當初選擇了 Philips WiZ，主要原因是價格較便宜*，其代價之一就是缺了一大功能：不支援 Apple HomeKit → 聲控方案不能選我熟悉的 Apple 生態系。

但 WiZ 有實體遙控器可以搭配，我覺得形式還蠻理想的，只要有個遙控器讓我按就好，我不一定要聲控。**我一直都覺得用手按開關是很直覺的事、沒有必要從日常中排除這個動作，用聲控不見得能完成的比較快、還會被其他人聽到聲音**。而且有時候語音辨識一直解析錯的話，還不如手指按一下都比較快好嗎。

但用著用著，**WiZ 遙控器實在連線不穩到沒辦法正常使用**，狀況就變得很尷尬，實體遙控器跟不存在一樣，開燈都只能透過手機 app，但除非燈泡重買否則也沒辦法串 Apple Homekit。

於是我決定給 Google Nest Hub 一個機會，一來是平價且可以直接串接我家裡現有的產品、不會浪費我原有的設備，還有個很加分的理由是：有螢幕。有些情境下用按的控制燈光就是比較方便（例如半夜不想吵到隔壁房的人），而且問「今天天氣」的時候，瞄一眼螢幕也能看到更多資訊。

> \*「價格較便宜」是差多少呢？當時我比較的對象是 Hue：一顆燈泡大概 NT$1,800、房間需搭配一台 1,800 的主控設備（另售）。WiZ 的燈泡：一顆 NT$800，不需要主控設備，整個平價多了，但相比之下就是可串接的服務少很多以及少掉（大多用不到的）功能。其中唯一對我最有差別的就是無法串 Apple Homekit。**如果是現在才要入手智慧燈、且想串 Apple Homekit 的話，可研究一下 Nanoleaf 或 Ikea Trådfri 的選擇。**

———

產品啟用設定沒有太大的問題，雖然流程有點長、需要耐著性子回答，但基本上在合理範圍內。

但實際開始用起來馬上遇到非常多問題，例如：

## 根本就是各種壞掉的部分

以下這些都是開始使用的頭兩天就遇到的事，有些可以繞過，有些到現在都還沒有解決

1. **螢幕點「居家控制」 > 「房間」 → 總是白畫面，重開也沒用**  
  → 過了三天後自己好了，原因不明
2. **八點的時候問「現在幾點」→ 現在三點**  
  → 要自己點進設定，設定裝置的所在地址
3. **說「黃光燈」「最大亮度」 → 畫面顯示 100% 但亮度遠遠不及那個燈泡真正能耐的一半**  
  → 先用燈泡的 app 把「黃光燈情境」的亮度設為 100%，然後在 Google Home 把「黃光燈」設定成「啟動黃光燈情境」的指令
4. **用 iPhone 藍牙連線播放，明明連著卻無法發出任何聲音**  
  → unpair 裝置再重新 pair，如果無效，再重新 pair，如果重試 10 次還是無效，就...只能放棄了
5. **routine 裡面的「朗讀自訂文字」動作是沒有作用的，不管中文英文都不會唸出來** 
  → 無解

根本就是各種壞掉，就是這麼的殘念

而且這台還是「晚美國一年上市」的「第二代」產品，怎麼還可以如此崩壞...

## 想像中應該是很基本的功能，卻沒有提供

除了這些看起來就是壞掉的功能，就算是功能正常的部分，我覺得也是相當的難用。

操作不順、找不到東西還可以說是 Apple vs. Google 的設計理念不同、而我還不熟悉操作而已，這些就算了。但有些功能居然沒有就讓我很意外，例如：

1. 不能自訂快速鍵放在螢幕上，甚至連 routine 列表裡也只有 built-in 的 routines 可以選
2. routine 不能用 time-based trigger (後來 2022-03-03 再度查看的時候發現可以了)
3. 暫停幾秒的功能無法在 built-in 的 routine 裡使用，自訂的卻可以

其中 1 是我覺得最可惜的，既然有螢幕，那麼讓我把預先定義的快捷鍵放在首頁應該是很合理的功能吧？而且既然都空間推薦「灰狗可以跑多快？」這種沒有幫助的問題了（到底干我屁事蛤？），怎麼不讓我放些按鈕用來觸發我常用的燈光情境勒？這明顯比較有用啊！

![image](/images/posts/2022-01-02-google-home-explore.jpeg)

而且就算不放在首頁，至少在調整燈光的頁面，比起現在會有亮度拉條跟大量的顏色列表供選擇（我選擇障礙都要發作了），讓我釘選 2~4 個「常用燈光組合」在第一頁應該很合理吧？但目前也是沒有這個功能。

![image](/images/posts/2022-01-02-google-nest-hub-light-control.jpeg)

感覺 Google 沒有好好利用螢幕這個介面，實在是頗可惜。或者是說，Google 設計產品的理念沒有把「易用性」這件事情放在優先（相對的，「串接能力強」就有比較優先，這倒也是某種「好用」，但跟「易用性」還是不一樣的）。

## 聲控的天生不利

更不用說機器的語意辨識能力要追上人類（成人）還有很大一段路，有時候實在蠢到讓人很灰心。例如以下都是實際發生的例子：

「Ok Google, 黃光燈，最大亮度」 → 『我不清楚你的意思』

「Ok Google, 黃光燈」 → (開燈了) →「Ok Google, 最大亮度」 → 『我找到了附近的加油站...』

「Ok Google, 黃光燈」 → 『如果要控制燈光，請到設定...』（明明就都有設定）

「Ok Google, 開燈」 → 『我不清楚你的意思』→「開燈啦幹！」

「Ok Google, 我要出門了」 → 『如果有要事要出門，請注意安全』『...』 → 「欸不是，那你要幫我關燈啊」（平常都會自動關）

### 影響家人

除了比人類更容易聽錯指令，如果家裡有其他人（家人或合租室友），聲控家電還有一個怎麼樣都不可能克服的問題：別人會聽到你在講話。

然後隔天他可能會問你：「我昨天半睡半醒的時候聽到你在念念有詞，你昨晚在幹嘛？」原因是你不想影響家人、所以壓低聲量說指令，導致智慧音箱更聽不懂你在說什麼指令，然後你就又得重說一次…

## 結論

我買 Google Nest Hub 是為了在我現有的設備下，讓我有第二種手段可以開關我房間的智慧燈、順便可以問天氣預報，它確實達到了當初設想的目的（雖然有時候聽不懂指令）。但在家裡沒有太多智慧家電、需求很單純的情況下，其實它的優勢發揮是不完全的。導致有種「帶來的好處無法抵銷它在使用上的缺點」的感覺。

如果你很明確知道你想要 Google Nest Hub（或其他的智慧音箱）幫你達成什麼、而且能接受它帶來的限制（上面有提到一些），入手它會是個不錯的選擇。

但如果你想要「全面提升家電的智慧、讓你住得更爽」，我只能說智慧家電、智慧音箱還有一大段路要走。現階段看來，**比起「全面提升房子的智慧」，智慧音箱配家電更像是「串連的能力大勝，其他的全面敗給現有方案」**，反應速度、可靠度、成本方面都比較差，要說有多善解人意好像也沒有（畢竟連開個燈都會聽錯）。如果你願意花大把錢去買各種可串連設備，雖然設計還是很難用、語音控制還是要摸順他的邏輯，但帶來的好處也許可以壓過難用的缺點。這取捨就要看你能不能接受了。

那我後悔買 Google Nest Hub 嗎？其實也沒有，以他的售價+有達成我預設的目標，我覺得還是個勉強 OK 的購買決定。但如果沒有頭洗到一半的前提（先買了不能串 Apple 的 WiZ 智慧燈），我可能不會選擇 Google 音響，但實際使用後更加確定有小螢幕才方便，謠傳 Apple 也有在開發這種形式的產品，但目前還沒看到。

以上是目前實際使用 Google Nest Hub 心得，供有興趣購買的人參考。

## 用我的推薦連結購買

如果您覺得我的觀點有幫助到您做出更好的購物決定，請多多透過我的推薦連結購買商品，這樣我可以賺取一些佣金。以下是這篇文章相關的商品：

* [Google Nest Hub 2](https://www.momoshop.com.tw/goods/GoodsDetail.jsp?i_code=9435657&Area=search&mdiv=403&oid=1_1&cid=index&kw=google%2Bnest%2Bhub&memid=6000018258&cid=apuad&oid=1&osm=league)
* [Apple HomePod mini](https://www.momoshop.com.tw/goods/GoodsDetail.jsp?i_code=8460759&Area=search&mdiv=403&oid=1_1&cid=index&kw=homepod%20mini&memid=6000018258&cid=apuad&oid=1&osm=league)
* [Philips Hue 入門套件組](https://www.momoshop.com.tw/goods/GoodsDetail.jsp?i_code=8253184&Area=search&mdiv=403&oid=1_10&cid=index&kw=Philips%20Hue&memid=6000018258&cid=apuad&oid=1&osm=league)
* [Philips WiZ 燈泡3入組](https://www.momoshop.com.tw/goods/GoodsDetail.jsp?i_code=8395421&Area=search&mdiv=403&oid=1_1&cid=index&kw=Philips%20WiZ&memid=6000018258&cid=apuad&oid=1&osm=league) (請注意，如文章所述，這個商品對 Apple 生態系的整合較差)
