---
layout: post
title: 超棒的 rails console 設定
published: true
date: 2014-08-13 02:13
tags:
- ruby
- rails
- Techbang
category: [tw]
comments: true
image: https://lh4.googleusercontent.com/-r2NUITCa9P8/U-psYQ1rw0I/AAAAAAAAB4A/ZI2zIEh94fs/w832-h450-no/rails-console-5-both-pry-rails-and-hirb.png
excerpt: 這篇是我閱讀 Using pry in production 後，結合我自己的經驗與公司前輩留下來的設定等，最後得出的一套組合。由於主題的關係這篇只介紹 rails console 相關的部分，實際上那套組合還有別的東西，以後若有機會再另外介紹。我把本篇提到的大部分技巧都包成一個 gem 了，歡迎使用： awesome_rails_console
---

<blockquote class="hightlight">
  <h4>現在有 gem 可直接使用</h4>
  我把本篇提到的大部分技巧都包成一個 gem 了，歡迎使用：
  <a href="https://github.com/ascendbruce/awesome_rails_console">awesome_rails_console</a>
</blockquote>

這篇是我閱讀 [Using pry in production](https://bugsnag.com/blog/production-pry) 後，結合我自己的經驗與公司前輩留下來的設定等，最後得出的一套組合。由於主題的關係這篇只介紹 rails console 相關的部分，實際上那套組合還有別的東西，以後若有機會再另外介紹。

> ps. 依照 [Using pry in production](https://bugsnag.com/blog/production-pry) 的設定將會受到一個 readline 的 bug 影響，在 pry 解決該問題前，本篇有 workaround 教學。

## 想達到的效果

1\. 預設漂亮的格式、還可以輸出 table

> 注意到 prompt 顯示出 project 的名稱，而不是預設的 "irb" 或 "pry"，同時維護多個專案的話很實用。

![pry-rails and awesome_print and hirb](https://lh4.googleusercontent.com/-r2NUITCa9P8/U-psYQ1rw0I/AAAAAAAAB4A/ZI2zIEh94fs/w832-h450-no/rails-console-5-both-pry-rails-and-hirb.png)

2\. 在 staging/production 的 rails console 會有明顯提示，防止手誤

![different prompt in each environment](https://lh6.googleusercontent.com/DhwI7z_5lH9cQBMoKiqsuiC6VDQF38AMiogLAhIuEFc=w836-h510-no)

## 設定

1\. 修改 `Gemfile` 加入以下 gems

> 如果已經有該 gem 請不要重複列，但請更新到最新版，因為有些功能是前幾個月才開始支援的。
> 如果要保留中文註解，請確保 encoding 沒有問題，我自己沒有全部試過。

``` ruby
## Gemfile
## 所有環境都綁，包含 production
gem "pry-rails"
gem "awesome_print", :require => false

group :development, :test do # 也包含 test 是為了讓寫 test case 時也可以 debug
  gem "pry-plus"
  gem "hirb", :require => false
  gem "hirb-unicode", :require => false
end

group :development do
  gem "pry-remote"
end
```

2\. 跑 `bundle install`
3\. 在 project 根目錄新增 `.pryrc`，內容如下：

``` ruby
## .pryrc
require "awesome_print"
AwesomePrint.pry!

begin
  require "hirb"
  require "hirb-unicode"
  extend Hirb::Console
rescue LoadError => e
end
```

4\. 新增 `config/initializers/pry.rb`，內容如下：

``` ruby
## config/initializers/pry.rb
## encoding: utf-8
## 預設的 prompt_name 是 pry，下面這行會把 prompt_name 變成該 project 的名稱 (自動抓)
Pry.config.prompt_name = Rails.application.class.parent_name.underscore.dasherize

unless Rails.env.development?
  old_prompt = Pry.config.prompt

  if Rails.env.production?
    # 這邊本來應該是 Pry::Helpers::Text.red(Rails.env.upcase)
    #   相當於 "\e[0;31m#{Rails.env.upcase}\e[0m"
    #   但因為一個 readline 引起的 bug 導致輸入游標錯位，因此需加上 \001 \002 來跳過此問題，下同
    #   此問題的討論串在 https://github.com/pry/pry/issues/493
    env = "\001\e[0;31m\002#{Rails.env.upcase}\001\e[0m\002" # 紅色 的 env 名稱
  else
    env = "\001\e[0;33m\002#{Rails.env.upcase}\001\e[0m\002" # 黃色 的 env 名稱
  end

	# 替換 pry prompt 的方法在 https://github.com/pry/pry/wiki/Customization-and-configuration#Config_prompt 有教學
  Pry.config.prompt = [
    proc { |*a| "#{env} #{old_prompt.first.call(*a)}"  },
    proc { |*a| "#{env} #{old_prompt.second.call(*a)}" }
  ]
end
```

4\. 此時打開 `rails console` 並下一些指令，應該就可以發覺到明顯不同之處了！

## 補充說明

### awesome_print 的用途

若先安裝好 awesome_print 後，打開一個純 irb session，執行：

``` ruby
require "awesome_print"
ap [1, 2, 3]
```

就會看到漂亮的輸出結果

但我們希望 `rails console` 預設就用這種格式。達成的要點在於設定時的這行：

``` ruby
AwesomePrint.pry!
```

它的 code 在 [這裡](https://github.com/michaeldv/awesome_print/blob/10efa1d60a463b05f14a4d2d1e73d2621cfa567c/lib/awesome_print/inspector.rb#L43)，看其內容會發現與 pry 官方 wiki 上的 [How can I use awesome_print with Pry?](https://github.com/pry/pry/wiki/FAQ#how-can-i-use-awesome_print-with-pry) 內容基本上是一樣的。

#### 以下是使用前使用後對照

irb (預設)

![](https://lh6.googleusercontent.com/-6w6PSne9lk0/U-psXAzO7SI/AAAAAAAAB3s/ZKYKRMFLUDk/w808-h129-no/rails-console-1-irb.png)

使用 irb + hirb (需在 `config/environment.rb` 設定)

![](https://lh5.googleusercontent.com/-nZ9H6-bEiVc/U-psX50T5bI/AAAAAAAAB3w/JljHTRjF7Fo/w833-h199-no/rails-console-3-hib.png)

使用 pry-rails (加到 Gemfile 並 bundle 過即可)

![](https://lh6.googleusercontent.com/-4D7smYsC6rw/U-psXCVsLLI/AAAAAAAAB3o/8bNTn1XVi28/w808-h129-no/rails-console-2-pry-rails.png)

使用 pry-rails + awesome_print (需在 .pryrc 設定)

![](https://lh3.googleusercontent.com/-65GPNMfZkhA/U-psYAb66LI/AAAAAAAAB4E/Rywl95Tgzug/w806-h265-no/rails-console-4-pry_ap.png)

### hirb 與 hirb-unicode 的用途

引入 hirb 並執行 `extend Hirb::Console`

``` ruby
require "hirb"
require "hirb-unicode"
extend Hirb::Console
```

之後，就可在 rails console 內使用

``` ruby
table User.select([:id, :email, :xxx_count]).where("xxx_count > 100"), :markdown => true
```

會得到類似這樣的結果：

```
| id    |  email                     |  xxx_count |
|------ | -------------------------- | -----------|
| 1234  |  hello@example.com         | 109        |
| 1545  |  hi@example.com            | 299        |
| 1694  |  nihao@example.com         | 300        |
```

有時候要匯出符合某種條件的 uesr 的帳號資料、並回在 issue tracking system 上之類的，利用這個功能可以節省很多排版時間。

至於 [hirb-unicode](https://github.com/miaout17/hirb-unicode) 是處理全形字對齊用的，身在中文環境，這個免不了要一起裝。

> ps. hirb 其實還有更多功能，不過有些與 awesome_print 的用途重複，我比較喜歡後者。因此 hirb 我只使用到 `table` 語法的部分。若您有興趣，可以在 [hirb 的 github page](https://github.com/cldwalker/hirb) 看到更多設定。

### pry-plus 的用途

[pry-plus](https://github.com/rking/pry-plus) 其實是一整包 pry 相關方便工作的外掛，包括

* pry-debugger (就算你不裝 pry-plus 這個也必須裝，不然會缺少 break 之類的 debugger 語法支援)
* pry-stack_explorer (實用，也很多人推薦)
* pry-exception_explorer
* pry-doc
* pry-docmore
* pry-rescue
* bond
* jist

> 注意：pry-debugger 不支援 ruby 2.0 以上，應該用 pry-byebug 取代（這點 pry-debugger 的 README 裡面也有寫），不過 pry-plus 沒有提供這種組合，所以就需要自己列在 Gemfile 裡了。

以前好像還有包括 pry-remote，但現在的版本沒有了，需另外列在 Gemfile 裡。

> 但是我與很多朋友都不喜歡 pry-remote，雖然可以解決使用 pow 時不能直接 `binding.pry` 的問題，但 pry-remote 時常有 lag、輸入點錯位、斷線等問題，因此我要開 `binding.pry` 的時候會另外打開 `rails server` 來用。

## 可改進的地方

目前的設定是最近期試出來的，有些可能還未經過長期的驗證，以下有幾個點我覺得可能可以改進的

* 無論任何環境都嘗試 `require "hirb"` 是否會影響 production 的啟動速度、甚至炸掉？
* 一定要分 `.pryrc` 跟 `config/initializers/pry.rb` 兩個檔案嗎？

歡迎回報您的改進方案 :-D

補充

* <https://github.com/nixme/jazz_hands> 用了很多跟這篇一樣的套件，而且從介紹看起來還多做了一些東西，我可能改天會試試看。
