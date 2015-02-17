---
layout: post
title: Rails 3 多人共同開發時Migration版本相插的問題
published: true
date: 2011-11-27 22:44
tags: []
categories: []
comments: true

---


在Rails 1的時代migration版本號是用流水號，共同開發時就容易撞號，schema_migrations又是只記最新的號碼，結果就是：撞號又較晚commit的人，那隻migration就無法執行，必須手動改號碼。  
  
最近專案也遇到這個疑慮，所以測試了一下，發現在Rails 3下，schema_migrations會記所有的版本，所以你只要下rake db:migrate，他就會把所有的migration，不管新舊，只要沒跑過的都會run它，因此不需要擔心migration沒被run到的狀況。  
  
你也可以用  

		rake db:migrate:up VERSION=20080906120000  
		指定**只執行該版本號的up區塊**的部份（給down就會執行down區塊）  
  
但如果你下這樣  
		rake db:migrate VERSION=20080906120000  
		**它會一路執行途中所有的migration**，直到你指定的版本號為止  
  
相關語法可參考[rails guide][1]  
  
  
但是，如果你在migration內有寫row內容的轉換處理程式，或者欄位有相依性、順序不能錯的話，那事情就沒有那麼單純了。Rails可以自動幫你跑所有你還沒跑過的migration，但管不到這種問題。  
  
如果你的專案真的有這種需求，你可能需要設立一個專門統籌migration的角色（可以把這個差事丟給DBA），所有人要開migration要先經過這個人的規劃。

[1]: http://guides.rubyonrails.org/migrations.html#being-specific