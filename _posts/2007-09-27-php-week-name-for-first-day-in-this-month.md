---
layout: post
title: 用PHP算出本月的第一天是星期幾
published: true
date: 2007-09-27 18:11
tags: []
category: [tw]
comments: true
redirect_from:
  - /2007/09/php_28.html
---


筆者曾經用Date函數取得今日的日期跟星期，再往前推算，程式碼要寫好幾行，至少五行跑不掉。
最近筆者想到了一個更好的解決辦法
這是Date函數的語法：
string date (string format [, int timestamp])
我們可以直接指定timestamp再取出格式化時間，timestamp的觀念在上一篇「倒數計日」已經講的很清楚了。
而取得星期的格式參數如下：
D：取得英文簡寫(如Wed/Fri等)
l(小L)：取得英文名稱(如：Friday/Sunday等)
w：取得數字代表：0=星期日 2=星期二…
如果我們這樣寫

```php
date("w");
```

我們將會得到5 （筆者寫這篇文是在禮拜五）
那如果我利用指定timestamp的方式，指定到這個月的第一天不就得了？！
程式碼如下：

```php
date("l", strtotime(date("Y-n-1")));
```


為了讓大家看的更清楚，筆者分解一下動作：(假設今日2006-3-17 Friday)

```php
date("l", strtotime(date("Y-n-1")));

date("l", strtotime("2006-3-1"));
date("l", 1141142400); //這串數字是timestamp，請參考[這一篇][1]

"Wednesday"
```


[1]: http://littlebmix.blogspot.com/2007/09/php.html
