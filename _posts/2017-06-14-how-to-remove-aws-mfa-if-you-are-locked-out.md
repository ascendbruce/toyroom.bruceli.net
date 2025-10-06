---
title: AWS MFA 驗證不通過無法登入怎麼辦 — 差點買到的教訓 2
excerpt: 不知道為什麼我的 AWS MFA 失效了，嘗試過輸入兩組 token re-sync 仍然無效。本文分享如何處理 AWS MFA 鎖定問題...
category:
- tw
tags:
- dev
image: /images/posts/2017-06-14-aws-mfa.jpeg
---

不知道為什麼我的 AWS MFA 失效了，嘗試過輸入兩組 token re-sync 仍然無效。

![AWS MFA]({% link images/posts/2017-06-14-aws-mfa.jpeg %})

> 被鎖在外面啦~ (⊙_⊙) | Pic CC-BY by [Justin Jensen](https://flic.kr/p/8bgazq)

## 如果你當初綁 MFA 的電話跟 email 都還在使用

1. 填 [Unusable Authentication Device support request](https://aws.amazon.com/forms/aws-mfa-support)
2. AWS 客服會在幾分鐘內打電話給你，以確認號碼是你帳號上登記的號碼
3. 對方會寄一封 email 到帳號登記的 email 地址，裡面有一組密碼
4. 在電話上口頭唸密碼給對方

## 如果當初綁 MFA 電話或 email 已經停掉了

1. 對方會給你一份文件 [Identity Verification Form and Affidavit](https://s3.amazonaws.com/AWSCS_CustomerForms/IdentityVerificationFormAffidavit.doc)，印出來填寫
2. 根據 [Required Documentation for MFA Removal](https://s3.amazonaws.com/AWSCS_CustomerForms/Required_Documentation_for_MFA_Removal.pdf) 的文件要求準備：身份證明、地址證明
3. 帶以上文件去找律師事務所公證
4. 掃描以上文件並 email 傳回去

## 學到的教訓

- 換新號碼的時候要把所有的 2FA, MFA 手機更新
- 網路上有人建議要保留當初綁定 TOTP 時的 QR code
- Amazon 跟 Amazon AWS 的 2FA 是分開設定的，不要搞混了

---

最近很巧的連續遇到兩個差點要花錢消災的事情，想說寫成文章造福以後焦急 Google 找解法的人們好了。另一篇是 [買了 multi-city 的機票，可以從第中轉機場開始搭機嗎]({% link _posts/2017-06-14-dont-buy-multi-city-flight-lesson-learned.md %})。
