---
layout: post
title: Make acts_as_versioned know target model belongs_to association
published: true
date: 2010-02-22 20:56
tags: []
categories: [tw]
comments: true

---


acts_as_versioned is a great plug-in for Rails. It can keep track of all modifications to your target model with only a little setup. But it seems not support has_*/belongs_to association by default. So let's see how to enable this.  
  
Assume that you are going to keep track of the 'Post' model. and this is probably your model looks like:  

		class Post < ActiveRecord::Base  
		acts_as_versioned   
		belongs_to :user  
		end  
But version.user will not work (at least, for this version).  
  
  
(1) For newer version of acts_as_versioned, try this:  
		class Post < ActiveRecord::Base  
		acts_as_versioned do  
		belongs_to :user  
		end  
		end  
		  
(2) And for older version, try this:  
		class Post < ActiveRecord::Base  
		acts_as_versioned   
		belongs_to :user  
		end  
		  
		Post.versioned_class.class_eval do  
		belongs_to :user  
		end  
		  
  
solution 2 works for me! but solution 1 not (ruby 1.8.6, rails 2.3.2, acts_as_versioned 0.3.1)  
  
  
==Traditional Chinese version==  
  
  
acts_as_versioned 是個好套件。只要一點設定他就可以幫你紀錄model的版本變動。可是他預設沒有支援has_*/belongs_to的資料庫關聯，所以讓我們來看看要如何打開這個功能。 
  

  

假設你要追蹤的是Post這個model，那你的model檔大概長這樣：

  
		class Post < ActiveRecord::Base  
		acts_as_versioned   
		belongs_to :user  
		end  

  

但這個時候 version.user 是會掛掉的(至少這版套件如此)

  

  

(1) 套件版本較新者可以試試這個：

  
		class Post < ActiveRecord::Base  
		acts_as_versioned do  
		belongs_to :user  
		end  
		end  
		  

  

(2) 舊版者，則試這個：

  
		class Post < ActiveRecord::Base  
		acts_as_versioned   
		belongs_to :user  
		end  
		  
		Post.versioned_class.class_eval do  
		belongs_to :user  
		end  
		  

  

  

我用第2個方案OK，但是第1個方案則不行... (ruby 1.8.6, rails 2.3.2, acts_as_versioned 0.3.1) 



