---
layout: post
title: 如何保持乾淨的 Downloads 資料夾
date: '2017-03-13T00:00:00+08:00'
tags:
- productivity
- 好用工具
- mac
category:
- tw
redirect_from:
  - /daily-life-productivity/how-to-keep-downloads-folder-clean-cd9182b403ba
---

一招養成保持下載資料夾乾淨、自動刪除 Downloads 資料夾裡面的舊檔案 (Mac)

你是否曾經歷過「看著 Downloads 資料夾裡堆積的無用檔案，雖然絕大部分都可以刪了，但又不敢無差別全選刪除」？

安裝[這個我寫的 open source 的小程式](https://github.com/ascendbruce/downloads-folder-cleaner)，再也沒有垃圾檔案堆積在 Downloads 資料夾裡了！

![]({% link images/posts/2017-03-13-downloads-folder-clean-01.png %})

> 寫文章當下，空蕩蕩的 Downloads 資料夾，絕對沒有剛重灌

## Why?

### 為什麼要保持乾淨

1. 硬碟空間不是無限的
2. 一堆垃圾檔案留在那邊會有不爽的感覺
3. 思考「如何整理 Downloads 資料夾」本身會消耗認知資源，越少想越好

### 為什麼我的方法比較好（相較於其他方法）

1. 累積一段時間後大清理：很痛苦，因為要判斷大量的檔案，費神又花時間去檢視 99% 沒用的檔案，**很浪費珍貴的認知資源**
2. [養成習慣每隔幾天整理 Downloads 資料夾](http://www.idownloadblog.com/2014/08/20/delete-files-downloads-folders-storage-space/)：聽起來很美好，但很難持續，而且非常依賴「要記得做」以及紀律，**很浪費珍貴的認知資源**
3. Hazel 軟體：功能很多，但要 US$42，單純要維持 Download 資料夾整潔的話太殺雞用牛刀

## 安裝

> ⚠️ 安裝這個工具前、你應該先完全清空 Downloads folder，你可以開一個 Downloads-backup 資料夾，把現有的檔案全部移進去即可。要不然它一執行就會把現有的東西全部丟到垃圾桶。

1. 打開 Terminal (終端機) app
2. 貼上入這行指令並按 Enter 就會安裝：

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ascendbruce/downloads-folder-cleaner/master/install.sh)"
```

## How it works?

這個工具會在每天晚上 11 點，自動檢查 Downloads 資料夾裡 "Date Added" 超過 24 小時以前的檔案，發現的話就丟進系統垃圾桶。（如果晚上 11 點的時候電腦在休眠狀態，那就會在喚醒的時候補做）

這個 solution 的想法其實很單純，但一開始可能會不習慣，它基於以下的假設：

1. Downloads 資料夾本身是個暫存資料夾，大部分的下載檔案打開來看完、安裝完就沒用了，不需要留存
2. 對於重要檔案，本來就應該有適當的歸檔位置，例如例如放進 Dropbox、iCloud Drive、備份到或外接硬碟、甚至[加密封存到另一個雲端](https://medium.com/daily-life-productivity/backup-cloud-archive-external-hard-drives-1afd46a105a5)
3. 所以需留存的下載檔案，下載完成後要「立刻」移到適當的歸檔位置，否則會被丟進垃圾桶（雖然你可以從系統垃圾桶挖回來）

如此一來，你會被迫養成立即歸檔的好習慣，但因為本來就必須移到歸檔的位置，整個流程沒有額外工，只是提早做。同時你就不用去想「整理 Downloads 資料夾」這件事，因為最慢 48 小時後就會被自動丟進垃圾桶。

然後你就有一個隨時都算乾淨的 Downloads 資料夾了！

### Bonus 1: 自動清理垃圾桶

macOS Sierra 以上可以開啟 30 天自動清除垃圾桶。

開啟方法：左上角蘋果選單 > About This Mac > Storage > Manage… > Empty Trash Automatically

![macOS Storage Management - Empty Trash Automatically]({% link images/posts/2017-03-13-downloads-folder-clean-02.png %})

### Bonus 2: 截圖儲存位置改成 Downloads 資料夾

如此一來就不會有截圖留在系統上

打開 Terminal app 貼上：

```lua
defaults write com.apple.screencapture location ~/Downloads
killall SystemUIServer
```

參考 https://www.ihash.eu/2014/11/change-screenshot-save-file-location-os-x-10-10-yosemite/

### Bonus 3: 留存的暫存區

有時候歸檔的最終位置是外接硬碟，但硬碟可能沒帶出門，或就是懶得接，想等到下一次一起 copy。

我現在的做法是會有一個暫存資料夾，以免留在 Downloads 資料會被自動清空。而在暫存區裡的至少都是挑選過、確定要留存的檔案，所以不至於堆積到超過負荷。

### 有沒有缺點？

以下是一些已知的小缺點：

1. 因為實際上是丟進垃圾桶，程式執行的時候會發出系統內建的「丟進垃圾桶」的提示音，有時候可能會嚇到自己
2. 如果有一個資料夾裡面有大量小檔案，這個程式是進去一個一個刪的，所以會刪很久，然後會一直發出提示音
3. 有時候不知道為什麼就是有零星無法自動刪掉的檔案（我自己使用 5 年以來，大概遇到 5 次以內）
4. 有時候會因為 mac 系統更新等原因整個 script 無法運作，有時候真的不太知道為什麼

除了第 1 點是系統音效的關係，其他幾理論上是可以修正的，熟悉 AppleScript 的朋友歡迎來 contribute 🙏

### 為什麼是 11pm 執行、Date Added 以 24 小時為界線？

這樣子會保證檔案至少保留 24 小時，但至多 48 小時後就會被丟到垃圾桶。時間短到讓你覺得當下就必須歸檔以免明天檔案會消失，但又不至於短到吃完飯回來檔案就被丟了。

## 被說服了嗎？這邊再提供一次安裝語法：

打開 Terminal (終端機) app，貼上：

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ascendbruce/downloads-folder-cleaner/master/install.sh)"
```
