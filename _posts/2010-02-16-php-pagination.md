---
layout: post
title: php分頁功能
published: true
date: 2010-02-16 19:27
tags: []
category:
- tw
comments: true
redirect_from:
  - /2010/02/php.html
---


## 注意！這篇文章的方法可能存在資料隱碼(sql injection)的風險，如果您沒有設定自動排除特殊字元(magic_quotes_gpc設定值)，那您必須進行防護，例如參考->[這篇][1]<-

#

## (整理資料時翻出來的，之前有人問我php分頁要怎麼弄時，寫給他的文章)

= = = = =

## try this!

沒有經過測試，請仔細研究。


#### 觀察SQL語法

> SELECT * 
> FROM `news` 
> ORDER BY `startdate` 
> LIMIT 5 , 1 #代表「LIMIT 第5筆, 一頁1筆」(but是0開始算喔，所以給5會傳回第6筆)
> #所以這個query會傳回單一筆、依照startdate欄位排列後的第6筆record



#### 實作方法構想

####

1.頁面「view.php?lid=χ」，用lid傳入來使用「LIMIT $lid, 1」，傳回該筆資料的內容
2.並給予view.php?lid=χ-1或+1的超連結(按下後回到第一步驟，如此循環)

#### 構想程式碼

> <?PHP
> $lid=$_GET['lid'];
> $sql="SELECT * FROM `news` WHERE `startdate`<='$today' AND `enddate`>='$today' ORDER BY `startdate`, `id` LIMIT $lid, 1";
> //(見註1)
> //執行query與印出
> ?>
> <a herf="自己.php?lid=<?PHP echo $lid-- ?>">上一筆</a> | <a herf="自己.php?lid=<?PHP echo $lid++ ?>">下一筆</a>

最頭尾的資料須加上防呆，由於指定給LIMIT第一個參數沒有對應到record的話不會傳回資料，可以藉此判斷是否到達最尾，最頭的話就簡單多了，指定負數絕對是不合法的筆數，因此在lid=0的時候便不給?lid=$lid-1的連結。
效能最佳化：第一次查詢時先得到目前公告的總筆數(見註2)，紀錄在SESSION中，$lid==該值的時候不給?lid=$lid+1的連結即可，但須考慮即時更新時掛網的使用者可能無法看到，可以再加寫更新機制。



#### 註解

註1：SELECT使用*號是不良示範，請使用「SELECT `title`, `content`, `startdate`, `enddate` FROM ...」，如果無須顯示兩個時間，減少讀取的欄位會讓效能好一點點，但累積下來總是龐大的。php+mysql最佳化請見[此文][2]。

註2：請善用SQL function，以下sql查詢將傳回一欄一列的result，該值為資料列的數量，其他常見的function還有MAX、MIN、SUM、…等等。

> SELECT COUNT(`id`) FROM `news` WHERE `startdate`<='$today' AND `enddate`>='$today'
>

註3：sql function的下法我所知道的有三種，「COUNT(`id`)」、「COUNT(1)」跟「COUNT(*)」，經過測試，「COUNT(`id`)」是效能最佳的方法，可能原因是PK具有索引性(index)，以下是兩次 [單筆1000次查詢*100回]的測試數據

> COUNT(*)            |   COUNT(1)             |    COUNT(`id`)
> 0.1283900737760  |   0.1033070087430  |   0.0965209007263
> 0.0977160930634  |   0.0935349464417  |   0.0874459743500





[1]: http://www.php5.idv.tw/modules.php?mod=books&act=show&shid=2475
[2]: http://www.dublish.com/articles/10.html (此文)
