---
layout: post
title: 用PHP算出兩日期差幾日 (倒數計日)
published: true
date: 2007-09-27 18:33
tags: []
categories: [tw]
comments: true
redirect_from:
  - /2007/09/php.html
---


用Date函數格式化日期的時候 (省略參數→目前時間)
PHP從參數(或省略參數時從系統中)得到一個整數



這個整數是從Unix系統零時(1970年1月1日凌晨) (有人說Unix時期、總之就是設定給Unix的誕辰日) ~~到指定時間點的累積總秒數 (叫epoch day，以下用timestamp表示)
例如：1970年1月2日下午3點半的timestamp等於142200 (39小時+30分鐘=140400+1800)
PHP下可以用mktime來產生指定日期時間的timestamp (請自行參考函式庫)

> ☆注意：
> Unix系統零時是在格林威治時間(GMT)下，台灣的時區是GMT+8，也就是早GMT 8小時
> 時區設定在台灣的主機，使用mktime的PHP函數 產生1970.1.1　0:00:00的timestamp將小於0!!! (當時GMT還在1969.12.31　16:00:00)
> 換句話說，產生1970.1.1　8:00:00的timestamp將等於0 (GMT正好到1970.1.1　0:00:00)
> 這麼說...用mktime產生目前時間的timestamp都會差8小時了!!
> 這時可以用gmmktime函數(將參數給的時間視為GMT時間而非該時區的時間) 直接產生GMT的timestamp
> 但是gmmktime在時區為台灣的主機，仍無法產生1970.1.1　8:00:00以前的timestamp (這我就想不通為什麼了...錯誤訊息：[**Warning**: gmmktime(): Windows does not support negative values for this function] 不巧手邊也沒Linux主機可以測試....)



>



知道timestamp是總秒數了...那如果把兩日期的timestamp相減，得到的不就是兩日期的差異總秒數了嗎!?
要算差異的天數的話，那就是除以1天的秒數囉 (1天=86400秒)



筆者這支程式取得timestamp的函數用strtotime，省得時分秒的問題 (strtotime使用方法請自行參考函式庫) 但是取得的是主機的時區...不過因為不可能遇到1970.1.1前8小時的情況(除非故意的)...所以筆者就不予考慮...
照這個想法寫的程式如下： (範例是今年的統一入學測驗日，是5月20號)

> $today = strtotime(date("Y-n-j"));
> $tdehu = strtotime("2006-5-20");
> $diff = ($tdehu - $today) / 86400;
> echo "倒數$diff天"



