---
layout: post
title: "為什麼我拋棄 Google Authenticator 改用 1Password 管理 OTP token"
date: 2018-05-21 00:00:00 +0800
categories: tw
tags:
- productivity
---

![1Password 2FA preview](/images/posts/2018-05-21-why-i-use-1password-for-2fa-token/preview.png)

2-factor authentication (雙因素認證, 2FA) 的基本想法是：登入時除了密碼以外，還要**第二個因子**來驗證，也就是「你所知道的（密碼）」跟「你所擁有的（裝置）」兩個因子來更加確保你就是帳號擁有者本人。一般會透過簡訊、硬體或軟體 token，因此就算密碼被別人知道了，沒有拿到我的手機（或其他形式的 token 裝置）的話也無法登入我的帳號，以增加安全性。

> [雙因素認證 ≠ 二階段驗證](https://www.techbang.com/posts/42804-password-for-two-factor-authorization-two-factor-authentication-the-5-things-you-need-to-know)，簡訊驗證已經不太能稱做雙因素、只能算兩步驟了，但這邊就不詳述。

有看過類似這樣的畫面嗎？

![1Password 2FA token screen](/images/posts/2018-05-21-why-i-use-1password-for-2fa-token/token-screen.png)

雖然還有其他形式的 2FA，但今天主要討論的是 [TOTP](https://zh.wikipedia.org/zh-tw/%E5%9F%BA%E4%BA%8E%E6%97%B6%E9%97%B4%E7%9A%84%E4%B8%80%E6%AC%A1%E6%80%A7%E5%AF%86%E7%A0%81%E7%AE%97%E6%B3%95) 的 [軟體 token](https://en.wikipedia.org/wiki/Software_token)，Google Authenticator 可能是其中最主流的選擇，我一開始也是用它。但為什麼我現在把 TOTP 移到 1Password 了呢？這樣不是不安全嗎？（一旦 1Password 被破的話，兩個會一起流出，就失去了雙因素的保護）

主要原因是：只少一單位的安全，我能換到很多的方便，是我可以接受的平衡。

這邊要先澄清一下，這裡說的少一點安全還是相當安全的，類似這樣：

![1Password 2FA security comparison](/images/posts/2018-05-21-why-i-use-1password-for-2fa-token/security-comparison.png)

> 無法理解為什麼把密碼交給別人是安全的，請參考 [用 Password Manager 大幅提升網路帳號密碼安全性](https://medium.com/daily-life-productivity/pasword-manager-will-upgrade-your-online-account-security-36d36623b545)

因為雖然失去了 2FA 的好處，但 TOTP 的好處仍在。

失去的防護：
- 密碼跟 TOTP 資訊一起從 1Password 流出

仍然保有的防護：
- 密碼被暴力破解出來
- 因為網站方的疏忽導致流出密碼（覺得不可能嗎？[Twitter 曾經不小心留下明文密碼](https://buzzorange.com/techorange/2018/05/07/twitter-save-userdata-with-decrypt/)，要是差一步可能就流出了）
- 因為重複使用密碼，從別的地方流出了密碼
- 被高明的釣魚釣到密碼

這 deal 聽起來沒有壓倒性的好，但請想一想：

- 風險不是只有盜帳號，手機弄丟、摔壞、莫名其妙就自己壞掉了也都是風險。一旦弄丟/損壞，不支援 SMS 驗證的網站，你可能會永遠失去該帳號（寫這篇的時候，2018 年 5 月，Google Authenticator 仍沒有支援雲端 sync。2020 年 5 月開始多了轉移功能，但仍然不是雲端 sync。2023 年 4 月終於推出雲端 sync）
- 而且如果你把 backup code 存在 1Password，其實早已失去 2FA 了，你沒有多損失什麼。問題是 backup code 不存在 1Password 的話，又要存哪才安全又方便呢？

覺得這一絲風險還是不容放過的人，可考慮以下的方案：

- 密碼放 1Password
- TOTP 放在 Authy 並開啟 sync，但其 master 密碼不可以放進 1Password
- 2FA backup code 放在文字檔，並用 GPG 或 AES 加密，其密碼不可以放到 1Password，而且未加密的文字檔不要放到會 sync 的資料夾底下（例如 iCloud Drive, Dropbox, … Backblaze 備份也得排除）

這個組合我短暫嘗試過，但土砲檔案加密解密麻煩許多，麻煩的事情就難以持續。而且還要多記一組比較少使用的密碼，「忘記這組密碼」就成為一個風險。因此我最後的解答就是這篇文章的作法。

## 補充：其他常見的 2FA 工具選擇

- Google Authenticator：沒有 sync，手機弄丟就糟了
- Authy：相容 Google Authenticator + 有 sync，推薦文 [Google Authenticator Backups — The Right Way To Do Two Factor Authentication](https://www.icontrolwp.com/blog/google-authenticator-backups/)
- [U2F](https://en.wikipedia.org/wiki/Universal_2nd_Factor)：用 USB 或 NFC 的硬體裝置進行驗證，需要買硬體、目前支援的網站也比較少，弄丟就糟了
- SMS 簡訊：[透過簡訊執行二次驗證不再安全，美國國家標準技術研究所建議別再使用](http://www.ithome.com.tw/news/112845)
