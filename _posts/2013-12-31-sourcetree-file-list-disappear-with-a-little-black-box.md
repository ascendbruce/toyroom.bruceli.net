---
layout: post
title: 解決 SourceTree 小黑方框同時File list 消失的問題
published: true
date: 2013-12-31 05:37
tags:
- mac
categories: []
comments: true

---
遇到的問題狀況是

![](https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-ash3/733861_685692514776068_1277441928_n.jpg)

整個檔案列表不見了，有時甚至連 Commit info 整欄都不見了，然後會出現一個黑色的小方形。

根據 [這篇](https://answers.atlassian.com/questions/212296/file-list-suddenly-disappeared-from-log-view-for-all-repos) 說刪除 資料跟Caches 可以解決此問題，其資料的位置是參考 [這篇](https://answers.atlassian.com/questions/72774/how-do-i-do-a-full-uninstall1)。

1. 完全關閉SourceTree / Fully quit SourceTree
2. 備份後刪除以下資料夾跟檔案 / Backup and delete those folders and files

        ~/Library/Application Support/SourceTree
        ~/Library/Preferences/com.torusknot.SourceTreeNotMAS.*
        ~/Library/Caches/com.torusknot.SourceTreeNotMAS

3. 重開 SourceTree 並重新設定 / Reopen and setup SourceTree

> ### 在 Finder 開啟 Library 的方法
> 
> 1. 打開 Finder 視窗
> 2. 按 menu 的 "Go" 下拉選單
> 3. 按著 option 鍵，就會出現 Library
> 
> 建議把 Library 拉到 Finder 側欄，以後要用到時比較方便