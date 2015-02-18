---
layout: post
title: Refactoring Workshop 補充 (Rails Pacific 2014)
published: true
date: 2014-10-01 13:59
tags:
- rails
categories: [tw]
comments: true

---
2014-09-26 我在 Rails Pacific 主持一場 Refactoring 的 Workshop，這篇是補充一些可參考的資源。

## 原始投影片

<iframe src="//www.slideshare.net/slideshow/embed_code/39561461" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe>

個人其實對這次的品質有一些遺憾，有些細節跟題目設定都沒有很好，也沒有足夠的排演，實在對參加者很抱歉，但我真的盡力了，且讓我解釋一下發生了什麼事。

Rails Pacific 開始的前幾天，因為下腹持續疼痛跑醫院，醫生建議我立刻掛急診做斷層掃描，依照報告結果選擇要「住院+打抗生素」或「住院+開刀」，結果我回醫師說：

> # 可是我禮拜五有活動耶

醫師就一臉無奈：「我們醫生是這樣建議啦，但還是要尊重你的意見」，於是 workshop 教材還是做出來了（驚險萬分），我只能說這真的是用半條命換來的，其實 workshop 當天早上我人也在醫院，現在寫這篇的同時，身體也都還有一點不舒服。

進入正題

## pry 的進階

* http://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debugger-gem
* http://knomedia.github.io/blog/2013/01/21/debugging-ruby-with-pry/
* {% post_url tw/2014-08-13-awesome-rails-console-customization-using-pry %}
* https://github.com/pry/pry/wiki

## 關於 Concerns

為什麼這個 workshop 完全沒有提到放進 concerns，即使有些題目其實是可以用的？

> “Any application with an app/concerns directory is concerning.”

請看這篇文章 http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/

需了解這其實沒有標準答案，需依照條件，例如說如果是拋棄式活動網站（只維護短期），「花時間把架構搞得很好」是錯誤的。團隊現有慣例與未來接手維護的安排也都是要考量的點。

## 只有一個地方用到，還要抽成 method 嗎？

這基本上有兩派說法，容我引用 [Ga Dii 的心得](http://tech.gadii.net/blog/2014/09/28/rails-pacific-2014/)

> 其中印象比較深刻的是被問到對於 over refactoring 的看法：Akira 說他 over refactoring 的經驗是過度抽象化，有時候甚至是 commit 之後才覺得後悔；Ryan 認為有時候一些 method 只有在一個地方被呼叫到的話，就不應該抽出來，而是讓整個 function 一氣呵成；Nick 則不贊同 Ryan 的想法，他認為這些 method 即使是只有被呼叫一次，但如果抽出來能夠讓 code 可讀性變高，那還是應該要拆開比較好。

不過我沒有當場聽到 Panel discussion，因為那個時候我人在醫院。

## Service Object 的補充

RailsCasts 上有一篇講得不錯(付費) http://railscasts.com/episodes/398-service-objects

## Form Object 的補充

也是 RailsCasts，也是付費 http://railscasts.com/episodes/416-form-objects

需注意 workshop 主要目的是帶觀念，production 網站要使用的話，應該用類似 [Reform](https://github.com/apotonick/reform) 的工具來做比較理想。(Reform 的作者也就是這次的講者之一 Nick Sutterer)
