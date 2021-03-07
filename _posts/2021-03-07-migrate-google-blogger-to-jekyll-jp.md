---
title: Google BloggerからJekyllへ移行した
excerpt: BloggerをJekyllに移行したときに学んだこと。...
category:
- jp
---

<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll-en.md %}" class="lang-btn">EN</a>
<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll.md %}" class="lang-btn">TW</a>
<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll-jp.md %}" class="lang-btn lang-current">JP</a>

BloggerをJekyllに移行したときに学んだこと。

要点：

1. [jekyll-import](https://import.jekyllrb.com/docs/blogger/)で記事をインポートする
2. JekyllとBloggerのpathは違うから、[jekyll-redirect-from](https://github.com/jekyll/jekyll-redirect-from) を使ってリダイレクトする。このプラグインは[Github Pages でサポートされています]((https://pages.github.com/versions/))。
3. 他のURL（Bloggerの機能）もリダイレクトする必要があります。例えば：
    - `/search/label/NAME` (タグ)
    - `/2020/02`、`/2020/02/` (年のアーカイブ)

https://blog.lunarlogic.io/2019/managing-tags-in-jekyll-blog-easily/ を参照してタグリスト機能を作ってみた
