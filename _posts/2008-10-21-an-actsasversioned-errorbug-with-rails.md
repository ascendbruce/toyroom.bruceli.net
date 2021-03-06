---
layout: post
title: an acts_as_versioned error/bug with Rails 2.1 -在rails 2.1用acts_as_versioned插件奇怪的錯誤
published: true
date: 2008-10-21 03:34
tags: []
categories: [tw]
comments: true
redirect_from:
  - /2008/10/actsasversioned-errorbug-with-rails-21.html
---

use acts_as_versioned plug-in lead to an unknown exception:

```
"NoMethodError: You have a nil object when you didn't expect it!"

from /opt/local/lib/ruby/gems/**1**.8/gems/activerecord-**2**.**1**.**0**/lib/active_record/attribute_methods.rb:**211**:in

`version='
from /Users/toby/rorbar/olhc_website/vendor/plugins/**acts_as_versioned**/lib/**acts_as_versioned**.rb:431:in

`send'
from /Users/toby/rorbar/olhc_website/vendor/plugins/**acts_as_versioned**/lib/**acts_as_versioned**.rb:431:in

`set_new_version'
```


It is maybe because of out-of-day acts_as_versioned plugin with rails 2.1 or above.

>
> The partial updates feature in **2**.**1** caused a conflict with the the way
>
> **acts_as_versioned** handles it's own change history. Check out the
> latest master on github as this has been resolved:
> [http://github.com/technoweenie/**acts_as_versioned**/tree/master][1]

see http://www.nabble.com/acts_as_versioned-and-Rails-2.1-td17665890.html

To solve this. reinstall the acts_as_versioned gem. or download tarbal/zip package from GitHub(link above) and unzip into the rails application's vendor/plugin directory.
(i have problem in re-installation. it always install only Docs. even give a -f augment Do anyone know how to re-install a gems plug-in?)



==Chinese version==
使用acts_as_versioned插件時導致了以下的錯誤


```
"NoMethodError: You have a nil object when you didn't expect it!"

from /opt/local/lib/ruby/gems/**1**.8/gems/activerecord-**2**.**1**.**0**/lib/active_record/attribute_methods.rb:**211**:in

`version='
from /Users/toby/rorbar/olhc_website/vendor/plugins/**acts_as_versioned**/lib/**acts_as_versioned**.rb:431:in

`send'
from /Users/toby/rorbar/olhc_website/vendor/plugins/**acts_as_versioned**/lib/**acts_as_versioned**.rb:431:in

`set_new_version'
```

這可能是因為您在rails 2.1或更新的版本中使用老舊的acts_as_versioned插件

>
> The partial updates feature in **2**.**1** caused a conflict with the the way
> 有一部分rails 2.1的新功能導致acts_as_versioned插件處理歷史紀錄功能壞掉
> **acts_as_versioned** handles it's own change history. Check out the
> latest master on github as this has been resolved:
> 請從github弄出最新的程式碼，master已經修正:
>    [http://github.com/technoweenie/**acts_as_versioned**/tree/master][1]

請參考 http://www.nabble.com/acts_as_versioned-and-Rails-2.1-td17665890.html


要解決這個問題，重新安裝acts_as_versioned插件，或直接從github網站下載tarbal/zip的壓縮檔，解壓縮到rails目錄的vendor/plugin子目錄中

(但是我重新安裝有問題，即使我下了-f參數，他還是只會安裝新的文件工具，有人知道要如何確實重新安裝gems的插件嗎？)

[1]: http://github.com/technoweenie/acts_as_versioned/tree/master
