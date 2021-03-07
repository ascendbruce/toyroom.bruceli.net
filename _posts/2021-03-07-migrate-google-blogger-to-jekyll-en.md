---
title: Migrate from Google blogger to Jekyll
excerpt: "For time-saving and better control reasons, I decided to merge few other blogs into this one. They were hosted on Google's blogger. Here are some lessons I learned during the migration. Hope this helps..."
category:
- en
---

<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll-en.md %}" class="lang-btn lang-current">EN</a>
<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll.md %}" class="lang-btn">TW</a>
<a href="{% link _posts/2021-03-07-migrate-google-blogger-to-jekyll-jp.md %}" class="lang-btn">JP</a>

For time-saving and better control reasons, I decided to merge few other blogs into this one. They were hosted on Google's blogger. Here are some lessons I learned during the migration. Hope this helps.

Main steps:

1. Use [jekyll-import](https://import.jekyllrb.com/docs/blogger/) to import articles
2. Due to the different URL formats, I use [jekyll-redirect-from](https://github.com/jekyll/jekyll-redirect-from) to redirect the old paths to the correct ones. This plugin [is being supported by Github Pages](https://pages.github.com/versions/)
3. Redirect some Blogger's feature path to proper pages, for examples：
    - `/search/label/NAME` (article tagged with certain label)
    - `/2020/02`、`/2020/02/` (archives by year)

The vanilla Jekyll didn't come with label pages by default, I built the tag page base on this article:  https://blog.lunarlogic.io/2019/managing-tags-in-jekyll-blog-easily/
