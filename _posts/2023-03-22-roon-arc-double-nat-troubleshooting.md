---
title: Roon ARC 網路設定方法 常見問題與解法
excerpt: 如果 Roon ARC 設定不起來，遇到類似下面的畫面：... 解決方法要根據網路配置有所不同，最常見的狀況應該是以下兩種，對策分別不同。...
category:
- tw
---

如果 Roon ARC 設定不起來，遇到類似下面的畫面：

<p><img alt="cover image" src="/images/posts/2023-03-22-roon-arc-error.png" width="1600" height="818" /></p>

解決方法要根據網路配置有所不同，如果你像我一樣，沒有對家裡的網路弄過什麼了不起的設定，那麼最常見的狀況應該是以下兩種，對策分別不同。但在開始之前，我想先很快的交代一下相關名詞。

**數據機 modem / 路由器 router / 交換機 switch  / WIFI 基地台 WIFI AP / IP 分享器...**

這些都是網路架構裡常見的設備，早期或者商用級產品裡可能會是各自一台機器，但現在家用通常就一台搞定，包含好幾個功能在裡面，部分功能可以透過後台決定要不要啟用。

ISP 提供的數據機基本上都同時有以上功能。數據機 modem 也有人用音譯為「魔電」，在台灣俗稱為「小烏龜」。中華電信工程師來牽網路的時候，會留給你一台設備，就是那台。

但通常 ISP 給的那台提供的 WIFI 很容易當機，動不動就斷線，所以有些人會另外去買一台比較好的 WIFI 分享器，例如 UniFi, Netgear, Linksys, Asus, ... 出的產品。

雖然現在都是一台多功能了，但為了稱呼方便，以下會分別統稱為「ISP提供的數據機」跟「你另外買的WIFI分享器」，實際上它們各自有 Router、WIFI 分享等功能。

> ISP 是網路服務供應商，例如中華電信、台灣大哥大、...。

有興趣進一步了解這些裝置各自在幹嘛的話，可以參考這篇: https://dotblogs.com.tw/brian/2012/10/18/77596

### 狀況A：電話線或光纖 → [ISP提供的數據機] → 你的 Roon core

首先，進入ISP提供的數據機的後台

> ISP 是中華電信的話，後台入口通常是在 <https://192.168.1.1/login.html> ，但必須透過網路線實體連線才能進入工程模式。工程帳號是 `cht`，密碼有規則可循，但每幾年會變化，所以先用關鍵字搜尋「中華電信 小烏龜 工程密碼 cht」來確認最新的密碼規則。

然後

1. 找到 UPnP 這個功能，並啟用
2. 找到 Port fowarding 這個功能，把 Roon core 的 IP 跟 port 加入到清單裡，內部外部 port 填一樣的就可以，這邊的服務名稱其實可以隨便打，自己認得出來就好

設定的時候除了 port 跟內部 IP，注意一下畫面上是否有網路介面的選項，以我的設備 (Nokia G-040W-Q) 為例，我需要設定在 `WAN1/ppp0.1` 介面才會成功，因為那是我連到 internet 實際用的介面。

找不到以上功能的話，用設備的型號+關鍵字，通常可以找到 step by step 文章。

### 狀況B：電話線或光纖 → [ISP提供的數據機] → [你另外買的WIFI分享器] → 你的 Roon core

這邊的狀況比較複雜，所以先稍微解說一下幾個名詞跟概念，以下都是簡化來說，我網路概論苦手，如果有錯請鞭小力一點 🙏

**Port forwarding 是什麼**

IP 分享器後面的每個設備會有個內部 IP （通常會長得像 `192.168.1.xxx` 或 `10.0.0.xxx`），但對外則共享同一個外部 IP。從裡面找外面的設備沒問題（例如從裡面傳訊息給外面的人，訊息一定會過 IP 分享器，所以訊息回來的時候，IP 分享器知道要轉給誰），但反過來要從外面找進內部的 Roon core 的話，既然對外只有一個 IP，沒頭沒尾的怎麼知道要找誰呢？

所以需要在 IP 分享器指定「55000 這個 port 就保留給某某內部 IP (假設是 `192.168.1.87`) 的設備用了，所以透過 port 55000 的外找，就是轉給內網 `192.168.1.87` 的 port 55000 喔」，這叫做 port forwarding。

**Double NAT 問題**

> 遇到此問題時，Roon ARC 的錯誤訊息叫做 `MultipleNatFound`

> NAT (Network Address Translation) 是達到 IP 分享的技術，如果你在路由器打開 NAT 功能的話，那我們就會俗稱它是 IP 分享器。

如果「ISP提供的數據機」有開 NAT (預設應該會開)，而你另外買的WIFI分享器也處於 Router 模式，這會造成所謂 Double NAT 的問題。意思是因為你的設備經過兩台 IP 分享器，所以就算你在「你另外買的WIFI分享器」上設定好 port forwarding 打通到外面世界 —— 但外面的世界其實還是在另一個 IP 分享器之內（~~夢中夢~~），所以外找還是找不到。

> 如果你發現上述造成 Double NAT 的前提在你的環境裡並不成立，那麼你可以先試試看狀況A的處置，也就是直接在「ISP提供的數據機」設定 UPnP 跟 port forwarding。

我找到 & 考慮過的解法有以下幾種

1. **「ISP提供的數據機」改成 bridge mode**
   - Roon 官方推薦
   - 此時這兩個網路之間橋接起來變成同一個，此時原本「ISP提供的數據機」在負責的 DHCP 要轉給「自己買的 Router」來負責，不然兩個會打架
   - 但有些型號無法自己啟動 bridge mode，會需要打電話去 ISP 問（然後他們會從機房改，或換給你一台支援的機器）
   - 另一個不推薦的原因是，現在的數據機設定起來很複雜，如果改到搞砸了、改到無法挽回、需要重設的話，可能會需要打電話求救 ISP 才有辦法解決
2. **「自己買的 Router」改成 AP mode**
   - 「自己買的 Router」插到「ISP提供的數據機」身上當 WIFI 天線用的概念，此時所以透過第二層 IP 分享器連線的設備其實是在同一層網路，DHCP 還是「ISP提供的數據機」在負責
   - 「自己買的 Router」的一些進階功能會無法使用，因為它現在其實是「ISP提供的數據機」的延伸而已
   - 萬一搞砸了，大不了就裝置重設然後再設定成一樣的 WIFI SSID 即可，裝置會自動恢復連線
3. **兩層都設定 port forwarding**
   - 外層的 IP 分享器要 port forward 內層的 IP 分享器，然後內層的 IP 分享器再 port forward 更內層的 Roon core
   - DHCP 會定期換 IP，導致 port forwarding 的 IP 找不到原本的那台設備，所以這兩臺設備都要設定成固定 IP
   - 這一切都會比較麻煩，而且我自己一直無法打通，所以放棄
4. **自己買的 Router 設定成 PPPoE 撥接**
   - 設備等級夠高的話，也許有可能比 ISP 提供的設備可靠
   - 不過我自己沒有設定成功，所以也是放棄
   - 有看到一些說法是前提條件為「ISP提供的數據機」需要是 bridge mode、且故意把上網密碼打錯。
6. **乾脆不管第二層 IP 分享器了**
   - 直接從ISP提供的數據機拉一條網路線出來，再用一台好一點的 Switch 網路交換器分接上 Roon core, NAS, 串流機, 電腦
   - 這個方法的明顯缺點是：如果你的手機是透過你另外買的WIFI分享器連線的話，它們處於不同網路，所以你無法用手機當 Roon Remote
   - 解決 Double NAT 跟直接拉線不衝突，直接拉線可以減少途中經過的消費級設備 = 減少不必要的干擾，因此解決 Double NAT 之後還是可以做

解決了 Double NAT 問題後，就回到狀況A，設定外層 router 的 UPnP 跟 port forward 後，應該就完全打通了。

總得來說，Double NAT 的解法 1 跟 2 是最可行的，雖然 Roon 官方推薦解法 1，但我自己是靠解法 2 才打通。

如果覺得以上的建議覺得還不夠細節、難以參考，推薦閱讀 Roon 官方的 troubleshooting 文章，其實寫得相當清楚明白:  [Port Forwarding Troubleshooting](https://help.roonlabs.com/portal/en/kb/articles/port-forwarding-troubleshooting)

唯一的問題是文章是英文的，雖然遠水救不了近火，但如果想要學到基本可看懂、不求文學造詣高的話，歡迎參考我們公司跟以琳老師合作推出的熱銷英文課程： [多益只是想考600分｜英文弱底 79 天多益達標訓練營](https://shop.wordup.com.tw/en/product/490)

再來還有一些可參考的文章：

- 品嘉音響撰寫的 [Roon 2.0 & Roon ARC 網路設定問題](https://www.pincha.com.tw/blog/posts/roon-arc-further-network-issue-solution) （他們的推薦是直接走解法 2）
- [Port Forwarding With Two Routers](https://portforward.com/help/doublerouterportforwarding.htm) 裡面的示意圖蠻精美的，但這篇是在推銷 port forward 設定軟體就是了...
