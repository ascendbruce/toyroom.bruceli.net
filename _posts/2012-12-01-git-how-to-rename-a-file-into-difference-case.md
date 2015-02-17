---
layout: post
title: 'Git: How to rename a file or folder into different case (case-sensitive)'
published: true
date: 2012-12-01 15:22
tags:
- git
categories: []
comments: true
---

中文版: [如何修改git檔名大小寫](/posts/139007-git-how-to-rename-a-file-into-difference-case-zh-tw)

Yesterday I carelessly made a typo on case of directory name. Result in Rails can't find file correctly. But when I try to rename it. I found out that git doesn't recognize a change that same name in differ case (case-insensitive).

Althought I can run this

    git config core.ignorecase false

to make git case-sensitive. But this can cause unexpected consequence on other projects.

I read some tutorials（[How do I rename a file in git that differs by case only?](http://apple.stackexchange.com/questions/51346/how-do-i-rename-a-file-in-git-that-differs-by-case-only)、
[git mv and only change case of directory](http://stackoverflow.com/questions/3011625/git-mv-and-only-change-case-of-directory)）

And this is my final solution：

    mv Typo typo_temp
    git add . # add to staging area
    mv typo_temp typo
    git add .
    git commit -m "Fix case typo"

In some tutorials, they commit on "typo_temp" step. While I just put it in staging area, it still work.


BTW, the mistake I made is:

I want `/users` routes to `/app/controller/api/users_controller` (like scope :module). The purpose is to remain API url but move code file to a sub directory.

``` ruby config/routes.rb
  get "users" => "api/users_controller#index"
```

But, Yes, I made the typo on `api/` folder (as `Api/`)

The strange thing is, it works on my laptop. But throws this expection on production machine:

     ActionController::RoutingError (uninitialized constant Api)

Why it doesn't break on my laptop!? Really strange @_@
