---
layout: post
title: "雲端加密備份(封存)你的外接硬碟"
date: 2018-03-26 00:00:00 +0800
category:
- tw
tags:
- productivity
image: /images/posts/2018-03-26-backup-cloud-archive-preview.jpeg
---

![backup]({% link images/posts/2018-03-26-backup-cloud-archive-preview.jpeg %})

> Pic CC-BY-NC 2.0 by [Scott Schiller](https://www.flickr.com/photos/schill/7036990623/)

很多文章都討論到系統備份，這篇想介紹一下一個比較少文章提及的備份需求 — — 資料封存。

差別在哪裡呢？

- **系統備份**：假設你已經花了一個月寫論文或專案製作，就在快完成前夕內接硬碟突然壞了，你能換到另外一台電腦上、復原寫到一半的文件、然後繼續工作嗎？
- **資料封存**：假如你有一些學生時期的舊資料、舊照片、大檔案等放在外接硬碟裡，因為筆電硬碟空間很有限、你並沒有放一份在現在用的電腦上，假如這顆外接硬碟摔到地上、損壞的時候，你還有備份嗎？

系統備份方面已經有非常成熟好用的方案了，例如 Mac 內建的 Time Machine 以及線上備份服務 [Backblaze](https://secure.backblaze.com/r/01kpf5)。上述的論文案例，如果編輯中的文件都放在 Dropbox 的話也可以避免悲劇。

但資料封存方面，我花了好一些心力才找到自己覺得適合的方法，因此分享出來幫大家節省研究的時間。

## 我的解答是 rclone + Backblaze B2

[rclone](https://rclone.org/docs/) 是一個 open source 軟體，它可以把本地端的資料夾 sync 到遠端主機甚至雲端的資料夾。例如說把硬碟裡某個資料夾複製到 Amazon S3、Google Drive 或 FTP 上。範例語法如下

```bash
rclone sync /Volumes/ExHDD/ b2:my-bucket-name/Backup/
```

更棒之處是他支援加密，例如我的 rclone.conf 內容如下

```ini
[b2]
type = b2
account = ***********
key = ***********
[b2crypt]
type = crypt
remote = b2:my-bucket-name/Backup
filename_encryption = standard
directory_name_encryption = true
password = ***********
password2 = ***********
```

前一個範例，這次 sync 到 "b2crypt"：

```bash
rclone sync /Volumes/ExHDD/ b2crypt:/
```

出現在遠端的資料都會是亂碼，雲端服務商並無法知道我的檔案內容，有額外的隱私跟機密資料保護。而我透過 rclone 來列出檔案名稱或下載檔案時，檔名跟內容則會是正常的（因為 rclone.conf 裡有正確的密碼）。

```bash
# 列出檔案名稱
rclone ls b2crypt:my-bucket-name/Backup/
# 把一個遠端檔案複製到本地端
rclone copy b2crypt:my-bucket-name/Backup/D929C0S0... ~/Downloads/
```

以上就是我研究一段時間最後的選擇，熟悉 command line 操作的朋友應該讀一下[文件](https://rclone.org/docs/)很快就能掌握了，就不多加介紹。

接下來我想分析一下備份的考量點以及為什麼選擇 [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html)。

### 備份方法的考量點

1. **硬體工具壽命**
   資料複製一份到外接硬碟就是最基本的備份了，但外接硬碟壞了怎麼辦？再多一顆外接硬碟也壞了怎麼辦？買外接盒自己組 RAID 0 結果插孔壞掉怎麼辦？

2. **異地備援**
   也就是兩份備份要在不同物理地點，主要是避免火燒厝、地震樓垮、所有硬碟都遭殃的狀況。

3. **簡單方便**
   麻煩的話就會懶得做，懶得做就會提升資料丟失風險。例如燒光碟備份簡直是自找麻煩。

4. **軟體工具壽命**
   把備份綁在外接硬碟廠商特製的備份軟體是很方便，但廠商倒了怎麼辦？廠商放棄軟體支援怎麼辦？

5. **隱私**
   上傳到別的地方就會多一份洩漏風險，例如雲端廠商被駭、導致你的個人資訊、機密文件、甚至寫在純文字檔裡的密碼洩漏怎麼辦？

問題 1, 2 可以透過「檔案放在雲端」來解決，因為雲端廠商會做 [RAID](https://en.wikipedia.org/wiki/RAID)、也有專人更換硬碟，資料丟失的可能性會比自己買兩三顆硬碟還低。

問題 3, 4 用 rclone 來面對，每一段時間執行一次 sync 指令即可，不用煩惱哪些檔案更動過，rclone 會自己比對。而且因為是 open source 專案，就算被作者棄置，最差狀況下也可以自己來維護。

問題 5 則可以透過 rclone 的加密功能來解決。

### 為什麼選 Backblaze B2

Backblaze B2 是個類似 Amazon S3 的服務，選 B2 有幾個好處：

1. **彈性**：不像 Dropbox 等服務有 1TB 的上限
2. **不浪費**：放多少檔案算多少錢
3. **便宜**：價錢比 Amazon S3 便宜

這邊試算幾個費用的例子，單位都是 1TB 每年費用（美金）：

- Amazon Glacier ≈ $49.2 (但是 Glacier 使用非常麻煩，要從 S3 轉入轉出，不太實用)
- **Backblaze B2 ≈ $61.56** ✅
- Office 365 Personal = $69.99 (上限 1TB)
- Dropbox Plus 方案 = $99 (上限 1TB)
- Amazon S3 Infrequent Access ≈ $153.6 (貴)
- Amazon S3 Standard ≈ $281.28 (貴)

不過要注意的是 B2 的計費方法：上傳不用錢，但儲存、下載跟檔案操作要錢，所以上面試算的數字雖然很漂亮，但你如果傳上去以後常常下載回來，可能就不划算。不過我找上 B2 本來就是為了雲端封存，除了硬碟壞掉以外，不會去下載回來。

## 我的備份計畫

最後，分享一下我的配置。我很滿意這個配置，但不代表這可以適用所有人，只是提供給大家參考。

### 能夠雲端化的就雲端化

例如我現在照片都丟在 iCloud（用 Android 的話就是 Google Photos），iPhone 的備份也是在 iCloud，iPhone 要重灌或換新手機的時候都可以連線復原。

工作中的檔案放在 Dropbox 或 Google Drive 上，除了預防電腦臨時故障，也可以 sync 到不同的電腦方便無縫接軌，甚至可以與其他人協作。

軟體專案用 git，隨時 push 到 GitHub 或 BitBucket。

我用 1Password Membership 管理我的密碼，不喜歡工具跟雲端同一家的話也可以買單機版、加密後用 Dropbox sync。（看我的 1Password 介紹：[用 Password Manager 大幅提升網路帳號密碼安全性](/tw/2017/05/16/password-manager-will-upgrade-your-online-account-security.html)）

### 系統備份

Mac 可以用 Time Machine。

Windows 10 也有類似的功能在 Settings > Update & Security > Backup。

還是覺得擔心的話可以用跨平台的 Backblaze，它會在背景自動上傳。

### 外接硬碟封存

也就是這篇文章的主旨：rclone + Backblze B2。

有些大檔案如果不是那麼重要、其實可以排除在外。例如從藍光光碟 rip 出來的影片，只要光碟片還留著的話其實就不用把檔案傳到雲端每年產生費用。稍微整理一下外接硬碟的資料夾，讓要備份的集中在同一個大資料夾下，每次只針對這個資料夾 sync 即可。

我知道不斷強調很囉唆，但還是要勸世一下：

> 不要等到丟失資料才學到教訓，立刻著手你的備份計畫。

若覺得這篇文章有幫助到您、還請分享出去，讓更多人也可以學到重要的備份知識！
