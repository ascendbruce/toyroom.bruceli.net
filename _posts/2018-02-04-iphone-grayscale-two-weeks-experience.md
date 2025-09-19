---
layout: post
title: 把手機調成灰階並使用兩週的心得
date: 2018-02-04 00:00:00 +0800
updated: 2024-10-11 00:00:00 +0800
category:
- tw
tags:
- productivity
preview_image: /images/posts/2018-02-04-iphone-grayscale-preview.png
---

> 2024–10–11 補言：iOS 18 後多了一個客製化桌面 icon 色調的功能，一樣可以達到桌面顏色變無聊的效果而不必關閉整個系統的顏色，我認為是較理想的方式，推薦可以試試看。

![iPhone 灰階模式預覽]({% link images/posts/2018-02-04-iphone-grayscale-preview.png %})

最近因為 [NY Times 刊登了一篇講「把 iPhone 調成灰階以抵抗手機成癮」的文章](https://www.nytimes.com/2018/01/12/technology/grayscale-phone.html)，讓這件事進入大眾的視線。但文章看得人多，實際改成灰階的人好像蠻少的，大多的文章也停留在「噢我剛才看到某篇文章因此把手機改成灰階，現在感覺好極了」的結論。

所以我就想來分享一下，實際使用整整兩週的灰階手機有什麼感覺、學到什麼經驗。

## 開啟灰階顯示的方法

Settings > General > Accessibility > Display Accommodations > 開啟 Color Filters > 勾選 Grayscale

使用一天確實發現，習慣性掏手機出來滑一下時、馬上就會覺得無趣而放回口袋，有達到減緩分心的效果。但也遇上一些困難：

### 困難一：還是有需要顏色的時候

我是工程師，手機上有不少 app 開發中的 beta 版，有時候會需要對照螢幕截圖與設計稿，只要 icon、色塊有關都是都需要顏色的。

另外還有使用內建相機 app 拍照時，不太清楚拍得如何，例如風景照是不是夠鮮豔。還有在要分享時會快速地修照片（裁切、filter），這類也都需要顏色。

**解決方法：設定成「按三下 home 鍵 = 切換模式」**

Settings > General > Accessibility > Accessibility Shortcut > 勾選 Color Filters

現在按三下 home 鍵就可以在灰階和彩色之間切換。

### 困難二：找 app 變困難

因為幾乎所有 app icon 長得都一樣了（黑白），要在桌面找 app 的速度變超慢。解決後仍然慢一點，只能說是適應了。

**解決方法：**

1. 換一個圖樣單純的 wallpaper。原本用的是 iOS 10 的預設彩虹 wallpaper，在開灰階後所有 icon 都「融進」wallpaper 裡了。換一個單色背景會好很多。
2. 資料夾只放一頁 app。我以前會在資料夾裡塞很多 app（兩頁、三頁），但要找時就需要注意看 icon，有時候還要翻頁。現在發現真的不行，太花時間了。現在調整成資料夾內最多 9 個，讓它不需要翻頁、而且 icon 在預覽時也會比較大一點。
3. 不常用的 app 用 search。其實也就是 command line 的概念，知道名字的話，下拉搜尋再點第一個結果，會比在幾十個長得一樣的 icon 海裡找還快。

### 困難三：按鈕不易分辨

平常沒特別注意，但原來蠻多按鈕是純粹用「顏色」來分辨是否 active 或是表達不同功能，這在變成灰階的時候會有點困擾。例如「愛心」的按鈕在點擊前和點擊後的顏色都變成灰色（有深淺差異），我就不太確定是否有點到。

**解決方法：**

開啟加強對比度

Settings > General > Accessibility > Increase Contrast

* 開啟 Darken Colors：系統 UI 的字會變比較深色
* 開啟 Reduce Transparency：毛玻璃效果會變成實色，比較不會受背景顏色干擾

（這些設定也剛好解決我的另一個問題：在戶外大太陽下看螢幕會不太清楚，加強對比有所改善）

### 困難四：某些 app 設計時沒有考慮 accessibility

某些遊戲完全分不清按鈕差別、看不出文字，Web 版常見顏色太淡，例如 medium 文章的 blockquote。還有因為 Twitter 會把圖片的主色變成背景色，有些人的 profile 在灰階下「完全看不到」handle 和自介。

解決方法：無，只能將就著用或是切換成彩色模式。

## 學到的經驗

經過適應之後，效果確實有的，滑手機的分鐘數從原本約 4hr/day 降到約 2.5hr/day。手機從彩色變成灰階、視覺刺激下降後，會發現大部分的 app 其實沒你想像的有趣；手遊會變得很無聊、Instagram 看照片會變得像在看舊報紙。我會想把手機當成傳統手機＋瑞士刀的感覺，有需求時使用，但沒事不會把瑞士刀拿出來賞玩（以前會）。

因為用了灰階模式，學到第一手的色盲經驗，發現不少 app、網站其實有基本 accessibility 的問題，有些流行但不是每個工程師都會去考量、沒特別測試的話根本不會發現。

另外，雖然用灰階達到預定的目的，但整個流程需要不少「撇步」、完全客製化自己的使用習慣。

我有發現兩個人本質的問題：

1. 不管手機成不成癮，我還是得用手機做正事（看 Google Map、2FA、拍照、查資料）
2. 把顏色關掉後確實有抵抗分心的效果，但人生有時候需要 guilty pleasure，全部刪掉也不對

我在第二週結束之後，覺得還是全彩手機比較實際，但這個兩週的體驗讓我保留了「按三下」的設定。所以當哪天我想要做正事但怕分心，還是可以按三下進入灰階模式。

---

後記：文章發佈之後，有朋友提到 [Android 也有類似功能](https://www.greenbot.com/article/3264497/android/how-to-enable-developer-options-android.html)（開發者選項裡），可以調成全灰階（Monochromacy），但因為沒辦法綁快捷鍵，要開關需要每次進選單調整，不是很方便。不過也有很多第三方 app，像[這款](https://play.google.com/store/apps/details?id=com.suyashsrijan.lowbatterymonochrome&hl=zh_TW)，按一下 widget 就可以開關灰階。

延伸閱讀： [Lifehacker 有一篇淺談為何 grayscale 螢幕會讓人減少使用慾望](https://lifehacker.com/change-your-screen-to-grayscale-to-combat-phone-addic-1795821843)
