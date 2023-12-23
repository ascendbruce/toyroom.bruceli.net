---
title: Google BloggerからJekyllへ移行した
excerpt: BloggerをJekyllに移行したときに学んだこと。...
category:
- jp
tags:
- 站務公告
---

<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll-en.md %}" title="Migrate from Google blogger to Jekyll" class="lang-btn">EN</a>
<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll.md %}" title="從 Google blogger 搬家到 Jekyll" class="lang-btn">TW</a>
<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll-jp.md %}" title="Google BloggerからJekyllへ移行した" class="lang-btn lang-current">JP</a>

メンテナンスのしやすさと管理性の良さを理由に、いくつか分かれて運営していたブログを統合することにしました。以前のブログは Google Blogger（ブログスポット）にあり、引っ越しに関する注意事項をいくつか記録して、引っ越し/統合が必要な人たちに参考にしてもらいました。

ポイント：

1. [jekyll-import](https://import.jekyllrb.com/docs/blogger/)を使用して投稿をインポートします。
2. JekyllのURLはBloggerよりも日付の階層が多いため、jekyll-redirect-fromを使用して元のパスを新しい場所にリダイレクトします。このプラグインはGithub Pagesでサポートされています。
3. 一部のBlogger機能のURLも適切なページにリダイレクトする必要があります。例：
    - `/search/label/NAME` (タグページ)
    - `/2020/02`、`/2020/02/` (年次アーカイブ)

最初のJekyllデフォルトにはタグページの機能がないため、https://blog.lunarlogic.io/2019/managing-tags-in-jekyll-blog-easily/ を主に参考にして、タグを表示/リストアップする機能を作成しました。
