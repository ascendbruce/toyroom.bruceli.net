---
title: 從 Google blogger 搬家到 Jekyll
excerpt: "因為維護方便、較好掌控的緣故，我決定將幾個原本分開經營的部落格合併，原本的部落格是在 Google Blogger (blogspot) 上，剛搬完紀錄一些注意事項下來給需要搬家/合併的人參考。..."
category:
- tw
---

<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll-en.md %}" class="lang-btn">EN</a>
<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll.md %}" class="lang-btn lang-current">TW</a>
<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll-jp.md %}" class="lang-btn">JP</a>

因為維護方便、較好掌控的緣故，我決定將幾個原本分開經營的部落格合併，原本的部落格是在 Google Blogger (blogspot) 上，剛搬完紀錄一些注意事項下來給需要搬家/合併的人參考。

主要步驟

1. 用 [jekyll-import](https://import.jekyllrb.com/docs/blogger/) 匯入文章
2. 因為 Jekyll 的 URL 比 Blogger 多了日期的階層，我採用 [jekyll-redirect-from](https://github.com/jekyll/jekyll-redirect-from) 把原本的 path 轉到新的位子上，這個 plugin [有被 Github Pages 支援](https://pages.github.com/versions/)
3. 一些 Blogger 功能的網址也要 redirect 到適合的頁面，如：
    - `/search/label/NAME` (標籤頁)
    - `/2020/02`、`/2020/02/` (年份 archives)

初始的 Jekyll 基本款並沒有標籤頁的功能，我主要參考 https://blog.lunarlogic.io/2019/managing-tags-in-jekyll-blog-easily/ 刻出顯示/列出 tag 的功能
