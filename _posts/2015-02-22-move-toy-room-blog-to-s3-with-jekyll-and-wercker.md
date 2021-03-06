---
layout: post
title: "部落格搬家筆記: 改用 Jekyll 並透過 wercker 自動發佈到 S3 上"
date: 2015-02-22 10:00
categories: [tw]
tags: []
og_image: /images/posts/003-jekyll-toyroom.png?v=2
---

> 2020-08-05 更新：這篇是記錄 2015 從 logdown 搬家到 Jekyll + wercker 的記錄，如今已不適用（wercker 被 Oracle 收購然後停止服務了，然後我不再堅持，把 Jekyll 放在 GitHub public repo 了）

過年在老家無聊的時候開始處理一些堆積已久的數位雜事，部落格搬家是其中一個特別大條的，從著手進行到可公開程度就花了 3 天多，搬家後第一篇當然就是搬家記錄囉！

![cover]({{ "/images/posts/003-jekyll-toyroom.png" | absolute_url }})

## 技術規格跟用到的服務

* Jekyll 2.5.3
  * Redcarpet (Markdown renderer)
  * Rouge (Syntax Highlighter)
  * [jekyll-sitemap](https://github.com/jekyll/jekyll-sitemap) 外掛
  * [jekyll-pages-directory](https://github.com/bbakersmith/jekyll-pages-directory) 外掛
  * 過程中還有嘗試過 [jekyll-paginate](https://github.com/jekyll/jekyll-paginate) 跟 [jekyll-category-archive-plugin](https://github.com/shigeya/jekyll-category-archive-plugin) 外掛，但最後不採用
* Amazon S3 (作為 Static Website Hosting)
* Amazon CloudFront (加速)
* BitBucket (放 Jekyll project source code)
* Wercker (BitBucket 有更新就會自動 deploy 到 S3)
* 其他用到的基本服務
  * Disqus
  * Amazon Route53
  * Google FeedBurner
  * Google Analytics
  * Google Custom Search
  * Google Webmaster

## 特殊功能

其實用別人的部落格平台還是比較方便的，不用自己管網站、機器、特殊字元、發佈機制等，但為什麼我還是換成 Jekyll 呢？其實這提供了幾個特殊功能，是我一直想要、但透過別人平台很難達成的：

* 有預設的全站 og:image，但單篇文章可以單獨指定 og:image (範例: [使用預設]({% link _posts/2014-12-10-resolve-sublime-text-3-erb-conflicting-end-tab-trigger.md %})、[自訂]({% link _posts/2015-01-06-effective-life-book-is-on-the-market-now.md %}))
* 首頁與 RSS feed 分中英兩組、Layout 可雙語切換、部分文章可雙語切換 ([範例]({% link _posts/2013-09-20-disable-itunes-starts-by-media-key.md %}))
* [作品集專頁](/tw/works/)，可以高度客製化 (畢竟 HTML 控制權在我手上，下次有空就會料理它)

接下來就是一些搬家過程筆記了

## 從 Logdown 搬來的注意事項

首先要注意 Logdown 匯出檔案有一些潛在問題：

1. 文章 title 內有單引號會變成不合法 YAML，遇到時改成用 double quoutes 包字串即可解決
2. Front matter 裡雖然有 `published:` key，但就算是草稿還是會給 true
3. 匯出檔會包含不該存在的 posts，猜測是因為用 soft-delete 機制沒注意到 scope

因此下載匯出檔後，務必檢查上述幾個問題，可以跟 Logdown 後台文章列表對照，針對第 3 點可以在 inspector console 下列出所有文章，整理格式後，跟 `ls _posts/` 的結果 diff，可較快找出不該存在的文章。

    $("li.post.group.published a.btn-link").each(function() { console.log($(this).attr('href')) })

接下來利用鴨七的 [hikkoshi](https://github.com/chitsaou/hikkoshi) Blog Migration Tool 把 Logdown 匯出檔轉成 Jekyll 格式。

但這樣還沒完，還有一些問題要處理

* 如果你是要連 domain name 一起轉到新家，要確保舊有文章不會壞掉，可在各文章的 front matter 段落裡指定 `permalink`
* Logdown 會自動把 `#` 翻成 `h2`，但 Jekyll 不會，一個頁面有多個 `h1` 的話對 SEO 有負面影響，所以要人工把 headers 退位
* 原本站內互連文章的超連結要改掉，這部分可利用 `post_url` 會比較方便 ([文件](http://jekyllrb.com/docs/templates/#post-url))
* Jekyll 提供的 markdown renderer 都不支援 code block 的 file title，鴨七因此寫了 [給 HtmlPipeline 的專用 filter](https://github.com/chitsaou/markdown-highlight-extended-filter)，但我因為一些考量只想用 Redcarpet，卻又沒有理想的解法，所以我直接捨棄 file title，把它移到 block 內變成註解，需手動處理。

## Jekyll

### 基本設定

依照 [Quick-start guide](http://jekyllrb.com/docs/quickstart/) 把 Jekyll 在 local 架起來。

此時你可能有想改的 Jekyll default 行為，幸好 Jekyll 文件寫得還蠻清楚的，這幾篇有一些基礎功能可以參考：

* [Creating pages](http://jekyllrb.com/docs/posts/)
* [Configuration](http://jekyllrb.com/docs/configuration/)
* [Templates](http://jekyllrb.com/docs/templates/)
* [Front Matter](http://jekyllrb.com/docs/frontmatter/)
* [Plugins](http://jekyllrb.com/docs/plugins/)

其中 markdown renderer 因故我選擇了 Redcarpet (目前預設是 kramdown)，在 Configuration 文件裡有設定教學。

{% raw %}
另外樣版裡 `{% if ... %}`, `{{ var }}` 等是 Liquid 語法，套版會用到的基本語法可參考 [Liquid for Designers](https://github.com/Shopify/liquid/wiki/Liquid-for-Designers)。
{% endraw %}

另外還有一件小事，生成靜態檔時，除了程式跟一些預設的東西外，一般檔案會被 copy 到 `_site` 底下，因此要確認 `_site` 下有無不該被生出來的檔案，例如我為了要用 wercker 就增加了 `Gemfile` 跟 `wercker.yml`，但這些檔案不是對外網站的一部份。

### 開啟常用 Redcarpet extensions

我開啟了一些外掛方便 markdown 撰寫，功效可參考 [Redcarpet Readme](https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use)

``` yaml
# in _config.yml

markdown: redcarpet
highlighter: rouge

redcarpet:
  extensions:
    - strikethrough
    - autolink
    - no_intra_emphasis
    - tables
    - with_toc_data
    - safe_links_only
```

### 如何在單篇文章內指定 og_image

前面提到的三個我一直想要的特殊功能，雙語切換可能大部分人都不需要，page 基本上也是 Jekyll 內建功能改改樣版而已，og_image 是我覺得比較值得分享一下的，對照 Jekyll 跟 Liquid 文件應該就能看懂，所以就不詳細解釋了：

``` yaml
# in _config.yml

title: Site title
description: Site description
# ...
og_image: "/images/default_og_image.jpg"
```

``` yaml
# front matter of a post
---
title: ...
date: ...
published: true
# ...
og_image: /images/xxx-post-excerpt.png
#           or
# og_image: http://example.com/images/xxx-post-excerpt.png
---
```

{% raw %}
``` html
<!-- in _includes/head.html -->
{% if page.og_image %}
  {% if page.og_image contains 'https://' or page.og_image contains 'http://' %}
    {% capture og_image %}{{ page.og_image }}{% endcapture %}
  {% else %}
    {% capture og_image %}{{ page.og_image | prepend: site.baseurl | prepend: site.url }}{% endcapture %}
  {% endif %}
{% else %}
  {% capture og_image %}{{ site.og_image | prepend: site.baseurl | prepend: site.url }}{% endcapture %}
{% endif %}

<!-- ... -->

<meta property="og:image" content="{{ og_image }}">
```
{% endraw %}

這部分有一些參考自 [Getting social with Jekyll](https://cooltrainer.org/getting-social-with-jekyll/) 這篇文章，但他使用到的技巧更多更複雜。

## 用 Wercker deploy 到 Amazon S3 上

### 設定 S3 Static Website Hosting

參考這兩篇文件用 S3 架設起一個測試網頁（架設過程先隨便寫一個 `index.html` 透過 Amazon 後台上傳即可），並把 custom domain 設定好：

* [Configure a Bucket for Website Hosting](http://docs.aws.amazon.com/AmazonS3/latest/dev/HowDoIWebsiteConfiguration.html)
* [Setting Up a Static Website Using a Custom Domain](http://docs.aws.amazon.com/AmazonS3/latest/dev/website-hosting-custom-domain-walkthrough.html)

### 設定 Wercker

[Wercker](http://wercker.com/) 是個幫你依照設定檔 deploy 的服務，當初注意到這個服務是因為 [Hugo.io](http://gohugo.io/) (Go 語言寫的 static site generator) 官方推薦用 Wercker deploy，覺得似乎不錯，因此想拿來跟 Jekyll 搭配使用，實際上也早有人做過這種組合。

參考 [Simplify your Jekyll publishing process with wercker and Amazon S3](http://blog.wercker.com/2013/05/31/simplify-you-jekyll-publishing-process-with-wercker.html) 設定。

完成的 `wercker.yml` 應該會類似這樣:

``` yaml
box: wercker/rvm
build:
    steps:
        - rvm-use:
            version: 2.0.0

        - bundle-install

        - script:
            name: generate site
            code: bundle exec jekyll build --trace

deploy:
    steps:
        - s3sync:
            key_id: $KEY
            key_secret: $SECRET
            bucket_url: $URL
            source_dir: _site/
```

其中 `bucket_url` 是 [s3cmd](http://s3tools.org/s3cmd) 在用的格式，在 S3 bucket 的 unique name 前面加上 `s3://`，以我的例子而言，就是 `s3://toyroom.bruceli.net`。不過這些設定不建議直接 commit 進 git，因此官方教學也是教使用 environment variables。

效果

![cover]({{ "/images/posts/004-wercker-deploy.png" | absolute_url }})

### 設定 404 page

如果 deploy 順利的話，你現在應該可以看到 S3 上的網站了，不過此時你隨便打個不存在的網址的話，會看到很醜的錯誤畫面。

製作一個 `404.html` 頁面，並在 S3 後台指定 Error Document 為 `404.html`

## 設定 CloudFront

由於是作為公開網站，為了加速一般都會建議過 CDN。

### 基本設定

參考 [Using CloudFront with Amazon S3](http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/MigrateS3ToCloudFront.html) 文件設定好並等待生效。

觀察下列指令結果是否有出現 CloudFront 的 headers:

    curl -I http://your.domain.name/index.html

### 除了 default root object 以外的 index file 都讀不到了

參考 [Why won’t index files deployed on Cloudfront work like it does in S3?](http://brajeshwar.com/2013/why-wont-index-files-deployed-on-cloudfront-work-like-it-does-in-s3/) 一文把預設的 Origin 改掉即可。

~~但接下來會遇到 Cache Invalidation 的問題，因此還是建議避免依靠 default index file (root 除外)。~~ 下一節會補充解決方法

### Cache Invalidations 問題

過 CDN 後就出現一個比較麻煩的問題：CDN 會 cache 住網站，browser 再怎麼 refresh 都沒有用，所以動到網站後就要通知 CloudFront 清 cache。

架站過程我暫時都去後台手動 invalidate，有幾個注意事項：

* 似乎不支援 wildcard 字元 (`*` 或 `**`)
* 所以我用 `find _site -type f` 列出所有靜態檔案再整理格式 (用空白或換行分隔)
* `/` 跟 `/index.html` 各自算一個 object，因此要分開列出

> 2015-05-21 起支援 wildcard 了，但有一些限制，請參考 [gslin 大大的重點整理](https://blog.gslin.org/archives/2015/05/23/5797/cloudfront-%E6%94%AF%E6%8F%B4-wildcard-invalidation/) 跟 [官方公告](http://aws.amazon.com/about-aws/whats-new/2015/05/amazon-cloudfront-makes-it-easier-to-invalidate-multiple-objects/)。

但長期來說這樣是很麻煩的，我之所以想用 Wercker 就是希望必要時可以 **直接在 BitBucket 線上編輯器改好後，剩下的 build, release, invalidate cache 就自動完成**。

研究一下後發現官方的 s3sync step 有個相關 issue: [Use newer s3cmd version](https://github.com/wercker/step-s3sync/issues/4)，大意是說 Wercker 使用的 `s3cmd` 版本太舊不支援 `--cf-invalidate` option，因此有人寫了自己的 step，把底層換成 s3_website gem。

> 補言：官方 s3sync 已經大更新，現在可以支援 `--cf-invalidate` option，我轉回去的過程很順利，只是 invalidate default index or path 的行為跟 s3_website 不一樣，需要自己加上參數，底下會介紹到。

確認了一下他的成果，發現似乎不適用於我採用的  Wercker box，所以我 又 fork 了自己的版本 [ascendbruce/step-s3sync](https://github.com/ascendbruce/step-s3sync) ，使用上有一些前提：

* 需使用 rvm box
* `Gemfile` 內要包含 `gem "s3_website"`
* `wercker.yml` 需修改內容如下（Wercker 後台變數也要追加）

    ``` diff
    deploy:
        steps:
    +       - rvm-use:
    +           version: ruby-x.x.x
    +       - bundle-install
    -       - s3sync:
    +       - ascendbruce/s3sync:
                key_id: $KEY
                key_secret: $SECRET
                source_dir: _site/
    -           bucket_url: $URL
    +           bucket_name: $BUCKET
    +           cf_distribution_id: $CF_DISTRIBUTION_ID
    +           region: ap-northeast-1 # 這個是 S3 的 region
    ```

官方文件有教怎麼寫自己的 step: [Creating your own steps](http://devcenter.wercker.com/articles/steps/create.html)，開發過程我有遇到一些小細節問題補了好幾次，如果想寫自己的版本的話，可以加減參考我的 commit log。

換成改過的 step 後，每次 sync 到 S3 後就會自動打 CloudFront API，就觀察似乎不是無差別全打，但不清楚是怎麼判斷的。

> 補言：應該是依照跟 S3 sync 時有更動的檔案。

subdirectory 的 index.html 預設並不會自動幫你送成 `/subdir/index.html` 跟 `/subdir/` 兩個，參考 [s3cmd Usage 文件](http://s3tools.org/usage) 加上你需要的 option：

* `--cf-invalidate-default-index`: invalidate /subdir/index.html
* `--cf-no-invalidate-default-index-root` 不 invalidate /subdir/ (因為預設會)

另外免費 invalidation 是有額度限制的，目前 [收費標準](http://aws.amazon.com/cloudfront/pricing/) 如下

> No additional charge for the first 1,000 files that you request for invalidation each month. $0.005 per file listed in your invalidation requests thereafter.

最後，展示一下自動發佈的總成果，這篇文章是這樣發佈的：

1. 在 BitBucket 上 Merge PR (到 master branch)
2. 自動 jekyll build > sync to S3 > invalidate CloudFront cache > 完成

<iframe width="640" height="360" src="https://www.youtube.com/embed/AMn5JB4Lpto?rel=0" frameborder="0" allowfullscreen></iframe>

以上就是這次搬家的筆記，喜歡的話請按個讚唄～

## 補言

* 有朋友問為何不用 GitHub page，我的主要原因是不希望 drafts 跟修改記錄被大家看到，而 GitHub 的 private 方案還蠻貴的，所以不太考慮。這點也是 [Jekyll blog Automatically generate and publish on AWS S3 and CloudFront](http://manuelgruber.com/2014/jekyll-auto-publish-aws-s3-cloudfront/) 這篇文章的理由之一。另外，這篇文章沒有主動打 CloudFront invalidation，而是在官方的 s3sync step 加上 `Cache-Control` header，效果跟省錢效果不知如何，過幾個月有空的話也許可以試試看。
* 之前一直覺得上 CDN 可以節省 S3 費用，但看了一下目前的帳單，發現這個不知道從哪聽來的經驗似乎不適用於貴森森的 Amazon CloudFront，所以只好當「享受加速的好處」了。
* 2020-08-05 更新：這篇是記錄 2015 從 logdown 搬家到 Jekyll + wercker 的記錄，如今已不適用（wercker 被 Oracle 收購然後停止服務了，然後我不再堅持，把 Jekyll 放在 GitHub public repo 了）
