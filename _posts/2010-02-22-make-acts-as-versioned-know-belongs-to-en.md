---
title: Make acts_as_versioned know target model belongs_to association
published: true
date: 2010-02-22 20:56
tags: []
category:
- en
comments: true
redirect_from:
  - /2010/02/make-actsasversioned-know-target-model.html
---

<a href="{% link _posts/2010-02-22-make-acts-as-versioned-know-belongs-to-en.md %}" class="lang-btn lang-current">EN</a>
<a href="{% link _posts/2010-02-22-make-acts-as-versioned-know-belongs-to.md %}" class="lang-btn">TW</a>

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


