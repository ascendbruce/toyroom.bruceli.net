---
layout: post
title: ASP.NET C# ADO.NET的Type, Provider, Service的做法與觀念（目前還處於我猜測的階段）
published: true
date: 2008-12-18 04:22
category:
- tw
tags:
- dev
comments: true
redirect_from:
  - /2008/12/aspnet-c-adonettype-provider-service.html
---


Type class內宣告instance variables跟其accessors

Provider class內放資料的CRUD oprations，傳入參數而非透過O/R mapping來操作的話，這些oprations應該宣告成static，也就是class method。

舉例來說，假設有兩個物件，作者跟書
Authors (id, name, gender) // 編號，姓名，性別
Books (id, author_id, title, subtitle, published_at) //編號，作者FK，標題，副標題，出版日

要更新書籍時，透過Books的provider進行以下動作：

...BooksService.Make().Update(modified_row);

或
beyound_java.Update(modified_row) // beyound_java是一個books物件
都是不好的，

前者不符合LoD，只跟親近的朋友溝通，或稱最少知識原則。
後者有可能產生不make sense的狀況，看看下列的語法

beyound_java.Update(3, 4, "better faster and lighter java", null, null) //
beyound_java是一個books物件

竟然由beyound java這本書去更新另一本書的資料，這很詭異，正常的作法應該是所謂「上系統」去修改資料，所以我目前認為這些oprations宣告成class method會比較合理一點。

至於service，其實可以不必存在，將為了跟控制項溝通的語法寫在provider裡面的各個method前即可。



