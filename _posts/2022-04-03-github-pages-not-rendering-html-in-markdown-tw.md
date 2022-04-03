---
title: GitHub pages 無法 render HTML 了（例如超連結 a 標籤）
excerpt: GitHub 在 2022-03-04 改了點東西，導致現在必須加入 UNSAFE option 到 commonmark （並傳給 jekyll-commonmark-ghpages）才能 render HTML。
category:
- tw
---

<a href="{% link _posts/2022-04-03-github-pages-not-rendering-html-in-markdown.md %}" title="GitHub pages not rendering HTML in markdown (eg. a tags)" class="lang-btn">EN</a>
<a href="{% link _posts/2022-04-03-github-pages-not-rendering-html-in-markdown-tw.md %}" title="GitHub pages 無法 render HTML 了（例如超連結 a 標籤）" class="lang-btn lang-current">TW</a>

最近我更新這個 blog (使用 jekyll and github-pages) 的時候發現超連結 a 標籤都壞了。

稍微研究一下後，在 [github/pages-gem/releases/tag/v225](https://github.com/github/pages-gem/releases/tag/v225) 發現了點線索。

看來 GitHub 在 2022-03-04 改了點東西，導致現在必須加入 `UNSAFE` option 到
`commonmark` （並傳給 `jekyll-commonmark-ghpages`）才能 render HTML。

我加了 `UNSAFE` option 以後，重新 deploy 就正常了。

在 `_config.yml`:

```diff
commonmark:
-  options: ["SMART", "FOOTNOTES"]
+  options: ["UNSAFE", "SMART", "FOOTNOTES"]
  extensions: ["strikethrough", "autolink", "table"]
```

他們其實有在 [github/jekyll-commonmark-ghpages](https://github.com/github/jekyll-commonmark-ghpages/blob/master/README.md) 警告說

> The UNSAFE option is required for HTML rendering.

不確定他們有沒有在哪邊公告，總之我是發現我的 blog 連結壞掉才發現的 🥲

在 local 跑 `jekyll serve` 的時候，它可能會顯示以下錯誤訊息：

> CommonMark: UNSAFE is not a valid option

這個沒有關係，可以忽略。

希望這篇文章可以幫你省下一點點 debug 的時間。
