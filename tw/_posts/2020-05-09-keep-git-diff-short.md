---
title: "盡量讓 git diff 精簡"
date: 2020-05-11 02:40
categories: [tw]
tags: []
og_image: /images/posts/011-git-diff.png
excerpt: "盡量讓每次發 PR（或者每個 git commit ）的 git 變動都精簡、且目的明確、沒有太多與該變動的目的無關的東西。這樣子較易於閱讀、讓 code review 更順暢，且 git blame 的時候容易一次就找到對的人"
---

![cover]({{ "/images/posts/011-git-diff.png" | absolute_url }})

（你有立刻看到那個真正重要的 change 在哪裡嗎？）

# TL; DR;

盡量讓每次發 PR（或者每個 git commit ）的 git 變動都精簡、且目的明確、沒有太多與該變動的目的無關的東西。這樣子較易於閱讀、讓 code review 更順暢，且 git blame 的時候容易一次就找到對的人（最後 commit 的人其實只是調個 coding style 之類的）

這並不是放諸四海皆準的 practice，要依照團隊、專案的狀況考量。舉例來說，如果在需求爆發、進度火燒屁股的時候、要求過去很 freestyle 開發的人開始要嚴守這些「好」規定，結果肯定會很糟。甚至在那種時候，原本有的習慣、規定也可以放下，因為比起實行那些規則帶來的好處，也許省下 cognitive resource、省下時間所帶來的好處（及時回應、搶得市場先機、避免倒閉等）是更重要的。

# 具體作法

## 避免一個 PR 做太多事

diff 大就較難全面看清，更不用說不同的事情混在同一個 PR 裡，肯定是很難看的。但有時候規模就是大，該怎麼辦呢？

**都是相關變動，但規模大**

通常已經採用 feature branch 的團隊很容易推動 epic branch：相關的 feature branch merge 進 epic branch，此時進行 code reivew，最後才把 epic merge 進 master branch。不過最後的 merge 的 resolve conflicts 跟 QA 測試要多注意。（根據不同團隊的 git branching 策略，這個的做法細節會有所不同）

另一種方法是逐步追加修改，例如不影響現有功能的前提下，把 db 欄位開好、model/service/command 邏輯、unit test 寫好就進 master，再用另一個 PR 套用到 API 或 view 上。必要的話，也可使用 feature toggle 機制。

**彼此不直接相關的變動**

兩個目的不相同的改動、應該盡量分成兩個 PRs，而不是因為發現的時間相近就 commit 在一起。

開 PR 的時候，要嘛新增一個（組）功能、要嘛修 bug、要嘛 refactoring，避免一邊開功能又 refactoring。如果為了容易做到某個功能而需要 refactoring，建議是先 refactoring，然後再另用一個 PR（或至少另一個 commit）去寫功能。

不過總是都這樣分的話也是頗費心力的，根據團隊狀況有些妥協作法。例如：

1. 可接受同 PR 裡、依目的/性質分 commits
2. 太瑣碎、低風險的小修改可以打包在一起開 PR
3. 功能混搭 5 行內的 coding style fix 可接受
4. ...等等

## 統一 coding style

如果現有 codebase 沒有明訂 coding style，常常會有同一段 code 每個人改到附近就順手改成自己看順眼的樣子。導致這些反覆又不必要的 git changes 不時會出現在 PR 裡。

找個時間跟團隊成員討論出一個標準，短時間內一整批修好、並設定好自動校正工具，以後就不會在開功能的 PR 裡「順便」修一個 coding style 了。如果時間很有限，建議從最常發生爭議的 style violation 開始修，少發生的就先放手。

導入 coding standard 也是一大學問，未來有機會再來談些經驗分享，但這裡想先對「滿腔熱血想在團隊導入 coding guidelines」的讀者提醒：決定 coding style 時常有不同意見針鋒相對，除了部分 style 確實對於避免犯錯有提醒作用、有些有特定的副作用（底下就會介紹幾個），很多 style 說到底就是「看習慣、順眼」的問題，有時還得兼顧撼動不了的歷史包袱。有時候最佳解是「讓自己看習慣那個目前看不順眼的 style」，不要去堅持「這是最好的 style、要辯到採用才罷休」或是「既然要統一 style 就一次做到完美」。

## 現況允許的話，避免採用這些 style 作為標準

因為會不必要的佔版面。這邊以 ruby 為例，不過很多語言也都會有類似的狀況。

### 各種跨行對齊 🙅‍♂️

```rb
this_is_a_long_variable_name = a + b
short_one                    = c + d
short_two                    = e * f
short_three                  = g * 2

this_is_a_long_variable_name = if condition
                                 do_a
                               else
                                 do_b_instead
                               end

do_something(:type, option_a: a,
                    option_b: b,
                    option_c: c)
```

原因是一旦第一個變數改名或刪除，後面幾行全都要改。

### 最後一個不加結尾逗號 🙅‍♂️

```rb
do_something(
  :type,
  option_a: a,
  option_b: b,
  option_c: c
)
```

原因是如果 option_b 跟 option_c 位置互換的話，一個要加逗號、另一個要刪逗號，會多一行不必要的改動。

# 其他選擇

如同開頭提到的，這樣的 practice 不是永遠的 best practice。在大家都自顧不暇的時候，爛 code (甚至 bug) 有改總比沒改好。

有些團隊甚至現在不應該考慮這個，而是應該要先去處理更基本的問題，例如：至少導入版本管理。

# 結論

其實這些都是相對小事，尤其是 coding style 什麼的，真的沒有那麼大的差別，不會改變公司的成敗，但如果有在承平時期導入成功的話，還是比較看順眼、顧眼睛的。

至於「避免一個 PR 做太多事」就有比較重要一點，這也是為了你的同事著想，請不要醞釀很久突然給出一個超大 PR，那種很難 review、也容易漏看。
