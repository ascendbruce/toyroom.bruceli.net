---
title: 用 Password Manager 大幅提升網路帳號密碼安全性
excerpt: 把密碼存在某個雲端服務似乎是個壞點子,但對大部分人來說反而是大進步,讓我告訴你為什麼
category:
- tw
tags:
- productivity
image: /images/posts/2017-05-16-how-secure-password.png
---

![](/images/posts/2017-05-16-how-secure-password.png)

除非你有[雨人](https://zh.wikipedia.org/wiki/%E9%9B%A8%E4%BA%BA)那種程度的驚人記憶力,否則記憶每個網站一組獨特又隨機的密碼是不切實際的。這不是我自己的感覺而已,[當初擬出「要用奇怪而無意義的字加上罕見的字元、大寫英文和數字,並且時常更換密碼」指南的人都說後悔了](https://www.inside.com.tw/2017/08/10/the-guy-who-invented-those-annoying-password-rules-now-regrets-wasting-your-time)。

因為根本記不了那麼多不同的隨機密碼,於是人們:

- 重複使用相同的密碼
- 使用簡單好記的密碼(例如 password, 12345678, 1234qwer 或生日)
- 使用簡單的密碼編碼規則 (例如單純的把網址放進密碼以達成差異)

> 用自訂的規則(替換字元、改順序、用注音輸入法的方式輸入英文等)為每個網站算出獨一的密碼確實有不錯的效果,但也很快會遇到極限,例如有些網站會限制長度跟可用的字元、每年強制換密碼而且還不能跟之前的密碼太像,你有再好的密碼轉換規則也無用武之地。

很多人不信任 password manager,認為一旦該服務被駭、所有的密碼都會流出。這種事件無法否認其可能性,但是風險不是只有密碼被管理的網站流出,以下都是風險:

- 一個服務流出密碼導致其他網站也被盜帳號(因為在不同網站使用了相同的密碼,或者密碼編碼方式不夠強、被察覺出規則。尤其有些[網站密碼根本沒加密](http://plainpass.com/p/about-this-site.html),非常可能流出。用 [' — have i been pwned? ](https://haveibeenpwned.com/)檢查 email 沒有被列在駭客公布的中獎名單裡)
- 被釣魚釣到其中一個網站密碼,導致其他網站也被盜帳號(理由同上,別以為自己不會中,[釣魚手法日新月異,其中有很厲害的](https://blog.gslin.org/archives/2017/04/23/7259/%E5%88%A9%E7%94%A8-unicode-domain-%E9%87%A3%E9%AD%9A%EF%BC%8C%E4%BB%A5%E5%8F%8A-chrome-%E8%88%87-firefox-%E7%9A%84%E8%A7%A3%E6%B3%95/))
- 被暴力破解、字典檔攻擊(因為使用了相對簡單的密碼,[這個網站](https://howsecureismypassword.net/)可以幫你估計某個字串當密碼需要多久破解,輸入一個跟你目前密碼接近的字串看看?)
- 因為真的忘記密碼、多次登入失敗被瑣帳號(尤其上面提過的有密碼限制的網站,你不得不想一個例外規則的密碼,結果就是忘記)
- 每次都依靠「忘記密碼」功能換新的免洗密碼登入(是的,這也是一種不錯的策略),但如果急著登入的時候 email 掉信老半天、事情就沒辦法做

我的想法是,簡單的密碼被破、或數百個網站其中一個流出密碼,比一個專門做安全的公司被攻破來的可能。因此選擇「增加一點點點所有密碼被流出的可能性」來換取「消滅還蠻可能發生的:共用密碼流出/暴力破解/帳號被鎖」是划算的。

做 password manager 的公司也知道自己的產品安全度是取得使用者信任的關鍵,所以當然有一些防堵機制。最基本的就是 sync 到雲端之前都已經加密,只有你的密碼可以解開,於是就算 sync 過程中有人竊聽或雲端資料被偷,少了正確的密碼還是無法在短時間內解開(短時間:用超級電腦跑暴力破解幾千年之類的)。所以 password manager 網站都會說如果你忘記 master 密碼的話連他們也沒辦法救你(如果他們沒有這麼說的話最好別用那家)。

### 你說的我都理解,但我的疑心病還是很重

我懂你的感覺,因為幾年前我也是如此,我覺得可以在幾個原則下使用 password manager,即可達到比較麻煩一點、但也更安全一點(我是已經棄守了)

1. 使用單機版並且永遠只用隨身碟 copy 或直連的 wifi 傳到另一台電腦 (而不是透過官方的 cloud sync 或 dropbox),這樣子你的資料不會傳到雲端服務上
2. password manager 只放次要網站,重要網站如 Google, Apple 還是自己記憶
3. 能開 2FA 的網站都要開 2FA,這是稍微不一樣的話題,請 follow [Daily Life Productivity](https://medium.com/daily-life-productivity),下次會有專文討論。

如果這樣子還是無法說服你安心使用 password manager,那就別用吧。如果你已有能力防堵上一節提到的各種風險,犧牲了一些東西後如果沒辦法提供等值或超值的好處的話,那也沒道理去用。

### 超過 password manager 能處理的安全問題與對策

password manager 並非完美無瑕,但有些是已知難以用軟體防堵的問題,使用者自己要意識到。以下舉 1Password 為例因為是我長期使用、比較熟悉的產品(另一個曾經用過的產品是 LastPass,但自從 [2015 年被駭](http://lifehacker.com/lastpass-hacked-time-to-change-your-master-password-1711463571) 後就失去信心不再使用了,雖然存在裡面的密碼應該是安全的):

1. 剪貼簿內容側錄
對策:不嫌麻煩的話,可以只看著打但不複製
2. 1Password 與瀏覽器外掛的溝通是明文
[1Password sends your password across the loopback interface in clear text](https://medium.com/@rosshosman/1password-sends-your-password-across-the-loopback-interface-in-clear-text-307cefca6389) 一文提及這個問題,如果你的機器 root 權限已經被攻下,技術上可以監聽兩者之間的溝通(當然如果你的 root 已經被攻下的話,沒有什麼是安全的)
對策:一樣是只看但不複製
3. 按鍵側錄或瀏覽器偷看 form 的 malware
這個倒不需要煩惱對策了 — — 因為如果中了這兩種東西,不管你有沒有用 password manager 都是不安全的。

### 現在就行動

現在就申請個 password manager 試用版、並丟幾個次要帳號進去試用看看,以下是比較知名的廠商

- [1Password](https://1password.com/) (以及 [單機版](https://agilebits.com/Store))
- [Dashlane](https://www.dashlane.com/)
- [LastPass](https://www.lastpass.com/)

閱讀我另一篇文章： [為什麼我拋棄 Google Authenticator 改用 1Password 管理 OTP token]({% link _posts/2018-05-21-why-i-use-1password-for-2fa-token.md %})

---

寫這篇文章主要是受到以下兩篇文章/影片的啟發

- [你以為把帳號密碼記在腦袋就不怕被駭?專家教你更有用的方式!](https://www.thenewslens.com/article/62637)
- Facebook 貼文 [比起讀經,更值得背誦的應該是自己的各種帳號密碼吧,尤其是強迫每年都要換的那種…](https://www.facebook.com/krisnight/posts/1365138240202065) (請看網友回應討論)
