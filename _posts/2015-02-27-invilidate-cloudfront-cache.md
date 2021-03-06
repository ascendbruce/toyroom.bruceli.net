---
title: "Publish Jekyll to S3 and invalidate CloudFront cache automatically with Wercker"
date: 2015-02-27 14:00
categories: [en]
tags: []
og_image: /images/posts/005-wercker-deploy-done.png
---

![cover]({{ "/images/posts/005-wercker-deploy-done.png" | absolute_url }})

I wrote a [custom Wercker deploy step](https://github.com/ascendbruce/step-s3sync) to invalidate CloudFront cache because it was not supported by [the official s3sync step](https://github.com/wercker/step-s3sync/). But in Feb 24, 2015, wercker team has [upgraded s3cmd to 1.5.1.2](https://github.com/wercker/step-s3sync/issues/4). Means that if you followed those tutorials to setup your Jekyll blog:

1. [Configure a Bucket for Website Hosting](http://docs.aws.amazon.com/AmazonS3/latest/dev/HowDoIWebsiteConfiguration.html)
2. [Simplify your Jekyll publishing process with wercker and Amazon S3](http://blog.wercker.com/2013/05/31/simplify-you-jekyll-publishing-process-with-wercker.html)
3. [Using CloudFront with Amazon S3](http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/MigrateS3ToCloudFront.html)

You can simply add this option and wercker will do the rest for you:

``` diff
# in wercker.yml

deploy:
    steps:
        - s3sync:
            key_id: $KEY
            key_secret: $SECRET
            bucket_url: $URL
            source_dir: _site/
+           opts: --cf-invalidate
```

It will invalidate the path for default index (`/subdir/`). If you'd like to invalidate default index (`/subdir/index.html`) or both. Add applicable options:

* `--cf-invalidate-default-index`: Will invalidate `/subdir/index.html`
* `--cf-no-invalidate-default-index-root`: Will **NOT** invalidate `/subdir/`

Details are in [s3cmd tool Usage](http://s3tools.org/usage).
