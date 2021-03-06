---
layout: post
title: MySQL 的 between 會不會包含開頭跟結尾本身？答：會
published: true
date: 2013-09-25 06:51
tags:
- mysql
category: [tw]
comments: true

---
## TL;DR

> MySQL 的 between 會包含開頭跟結尾本身，也就是 `column >= lower_limit and column <= upper_limit`

## 為什麼要寫這篇

做個備忘，因為老是忘記。

但是這邊的結論不能直接套用到其他 DBMS，請看 W3CSchool 的貼心提醒：

> **Notice that the `BETWEEN` operator can produce different result in different databases!**
> In some databases, `BETWEEN` selects fields that are between and excluding the test values.
> In other databases, `BETWEEN` selects fields that are between and including the test values.
> And in other databases, `BETWEEN` selects fields between the test values, including the first test value and excluding the last test value.
>
> Therefore: Check how your database treats the BETWEEN operator!

## 小實驗的過程

```
$ mysql -u root -p

mysql> create database test_between;
Query OK, 1 row affected (0.28 sec)

mysql> use test_between;
Database changed
mysql> create table test_between ( val int );
Query OK, 0 rows affected (0.34 sec)

mysql> insert into test_between values (1),(2),(3),(4),(5);
Query OK, 5 rows affected (0.05 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from test_between where val between 2 and 4;
+------+
| val  |
+------+
|    2 |
|    3 |
|    4 |
+------+
3 rows in set (0.02 sec)
```
