---
title: GitHub pages not rendering HTML in markdown (eg. "a" tags)
excerpt: Apparently GitHub pages did a change on 2022-03-04. Now you need to pass UNSAFE option to jekyll-commonmark-ghpages via commonmark options in order to make it work.
category:
- en
tags:
- dev
---

<a href="{% link _posts/2022-04-03-github-pages-not-rendering-html-in-markdown.md %}" title="GitHub pages not rendering HTML in markdown (eg. a tags)" class="lang-btn lang-current">EN</a>
<a href="{% link _posts/2022-04-03-github-pages-not-rendering-html-in-markdown-tw.md %}" title="GitHub pages 無法 render HTML 了（例如超連結 a 標籤）" class="lang-btn">TW</a>

In a recent deploy of this blog -- which is powered by jekyll and github-pages, I found out that
a tags stop working. Those links were broken.

After a quick study, I found a hint in [github/pages-gem/releases/tag/v225](https://github.com/github/pages-gem/releases/tag/v225)

Apparently GitHub pages did a change on 2022-03-04. Now you need to pass `UNSAFE` option to 
`jekyll-commonmark-ghpages` via `commonmark` options in order to make it work.

In my case, I add the `UNSAFE` option, deploy again and it's back to normal.

in `_config.yml`:

```diff
commonmark:
-  options: ["SMART", "FOOTNOTES"]
+  options: ["UNSAFE", "SMART", "FOOTNOTES"]
  extensions: ["strikethrough", "autolink", "table"]
```

They did put a little warning in [github/jekyll-commonmark-ghpages](https://github.com/github/jekyll-commonmark-ghpages/blob/master/README.md) saying that

> The UNSAFE option is required for HTML rendering.

Not sure if they announced somewhere, but I only noticed it when my pages broken 🥲

Note that when running `jekyll serve` locally, it may show the following warning:

> CommonMark: UNSAFE is not a valid option

Which is fine, you can ignore it.

Hope this help.
