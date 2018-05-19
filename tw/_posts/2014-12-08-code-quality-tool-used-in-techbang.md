---
layout: post
title: T客邦目前使用的 code 品質輔助工具
published: true
date: 2014-12-08 02:42
tags:
- Techbang
categories: [tw]
comments: true

---
這篇介紹一下T客邦跟我個人有在使用的品質（尤其是 coding style）輔助工具，有些是我幫T客邦引入的，有些是我從T客邦現有的制度學來的。

## RSpec

比起這篇要介紹的其他項目，測試算是不太一樣的類別，但它很重要。例如改 `Apple` modle 意外的搞爆 `Banana` controller 而不知，如果你沒寫測試，可能就會到上線後才知道。

> 小作業：去查 regression testing 跟 non-regression testing 是什麼

寫這篇的時候，T客邦的測試大部分還是很陽春的狀態，覆蓋率不高、寫法也沒有特別遵循一些已知的 guidelines，但即使是最基本的測試也可以享受到一些好處。T客邦的測試寫法還有很大個改善空間，就等優秀的你來應徵。(☉▽☉)

加入 Gemfile

``` ruby
# Gemfile
group :development, :test do
  gem 'rspec-rails', '~> 3.0'
end
```

跑

``` shell
bundle install
```

跑 generator

``` shell
rails generate rspec:install
```

先寫一個很陽春的 spec，改到 rspec 可以順利跑完為止

``` ruby
# spec/controllers/posts_controller_spec.rb
require "rails_helper"

describe PostsController, type: :controller do
  describe "GET 'index'" do
    it "renders index template" do
      get :index
      expect(response).to be_success
    end
  end
end
```

之後再視需求追加測試、追加 gems (例如 capybara, faker, fabricator 等)。如果你的目標是確保執行路徑上不要有嚴重錯誤就好，可考慮寫 feature tests 為主。

如果你使用 capistrano 做 deploy，但沒有架 CI server 的話，可以參考 [Use codeclimate-test-reporter without a CI server]({% link en/_posts/2014-11-15-use-codeclimate-test-reporter-without-a-ci-server.md %}) 把 run_tests 的 capistrano task 設定好，如此一來若有忘記跟著功能程式碼一起修改的 test 敗壞的話，就會阻止你 deploy。(這部分是學自 [Reliably Deploying Rails Applications](https://leanpub.com/deploying_rails_applications) 一書)

## Coding style, code smell 與 best pratices 工具

這幾個項目其實都不用寫在 Gemfile 內，但我習慣直接加進去，因為只要 bundle install 就都裝好了，且以後新人即使一開始不知道有這些 gems 可用、只要肯搜尋各個 gems 的用法就也會發現。

修改這些警告項目時，如果有不錯的測試覆蓋率將會增加修改的信心，反之就會很擔心會不會搞爆功能了、最後還是不敢動它。如果你維護的專案既沒有測試也沒有遵循 coding style，我會建議：

1. 先修嚴重的問題，例如 brakeman 警告中，特別嚴重的安全問題
2. 補一些陽春測試，確保執行路徑上不要有嚴重錯誤，並且跑不過就不准 deploy
3. 之後再開始修次要 coding style

### Brakeman

是用來偵測 Rails 寫法造成的安全性問題的工具。

``` ruby
# Gemfile
group :development do
  gem 'brakeman', :require => false
end
```

跑

``` shell
bundle install
```

在 project 根目錄執行

``` shell
brakeman
```

就會看到它提出的建議，似乎大部分建議也都可以在官方的 [Ruby on Rails Security Guide](http://guides.rubyonrails.org/security.html) 看到。

### rails best pratices

是依照社群維護的 [Rails Best Practices](http://rails-bestpractices.com/) 提供寫法建議，常見的建議有：[在 partial 內不要用 @instance_variable](http://rails-bestpractices.com/posts/27-replace-instance-variable-with-local-variable)、[使用 render 的簡化寫法](http://rails-bestpractices.com/posts/61-simplify-render-in-views)、[應該從 view 移到 model](http://rails-bestpractices.com/posts/25-move-code-into-model) / [controller](http://rails-bestpractices.com/posts/24-move-code-into-controller) / [helper 的 code](http://rails-bestpractices.com/posts/26-move-code-into-helper)、[移除行尾空白](http://rails-bestpractices.com/posts/60-remove-trailing-whitespace) 等。

``` ruby
# Gemfile
group :development do
  gem 'rails_best_practices', :require => false
end
```

跑

``` shell
bundle install
```

在 project 根目錄執行

``` shell
rails_best_practices
```

參考[官方 README > Customize Configuration](https://github.com/railsbp/rails_best_practices#customize-configuration) 把你確定不處理的警告關掉。

### EditorConfig

是指定空行、換行 style 的編輯器外掛+設定檔。雖然各編輯器通常可以自己設定，但使用 EditorConfig 的好處是只要要求新人裝對應的外掛即可，不怕新人設定錯，而且設定可以跟著 project 走。

在 project 根目錄加設定檔

``` ruby
# .editorconfig
# Please install EditorConfig plugin for your editor or IDE
# Usage and plugin list can be found here: http://EditorConfig.org

# top-most EditorConfig file
root = true

[*]
end_of_line = lf
indent_style = space
indent_size = 2
insert_final_newline = true
trim_trailing_whitespace = true

[*.md]
indent_size = 4
```

並到 [EditorConfig](http://editorconfig.org/) 官方網站尋找你使用的編輯器，安裝相應的編輯器外掛。

幾個月前我第一次嘗試使用 EditorConfig 時發現 Sublime 的 global settings 會覆蓋掉 EditorConfig 的設定，但第二次嘗試時就正常了，不確定是誰 update 過。

### rubocop

依照社群維護的 [bbatsov/rails-style-guide](https://github.com/bbatsov/rails-style-guide)、[bbatsov/ruby-style-guide](https://github.com/bbatsov/ruby-style-guide) 提供建議。常見的建議有各種縮排層級、空白、空行的位置/數量、統一使用單引號或雙引號(依照你的設定) 等非常詳細的 coding style 問題。

``` ruby
# Gemfile
group :development do
  gem 'rubocop', :require => false
end
```

跑

``` shell
bundle install
```

在 project 根目錄執行

``` shell
rubocop
```

就會看到修改的建議

參考 [官方 README > Configuration](https://github.com/bbatsov/rubocop#configuration) 把不修正的警告關閉、與團隊現有 coding style 不符的地方改參數。另外也可以在誤判的程式碼前後加上[特殊的註解](https://github.com/bbatsov/rubocop#disabling-cops-within-source-code)即可小範圍排除特定的警告。

另外，Rubocop 具有自動修正的功能，我使用以下的流程（實際指令要去翻 README）：

1. 寫一個把所有 cop 都關閉的設定檔
2. 寫一個繼承上述設定檔，並且 override 掉想修正的項目（但不是所有 Cop 都支援自動修正）
3. 執行 Rubocop 的自動修正指令
4. 回到第二步，改成下一種要修正的項目

## 可用的外部服務

這部分是一些可以幫你跑檢測工具，並透過較友善的介面回報給你的服務。

### [Hound](https://houndci.com/)

是 Rubocup + CoffeeLint + JSHint 的服務
且偵測到問題會自動在 Pull Request 上直接留言

計費方式

* 12USD per project per month
* 有 Open Source 可以自己架

### [Code Climate](https://codeclimate.com/)

是 Brakeman + 複雜度與重複性 的網路服務
其介面設計的很漂亮，且若有誤判可以從網頁介面隱藏掉（如果你自己跑 brakeman 的話，可能就要自己記住那個其實是誤判等等）

計費方式

* 5 users x 5 private repos = 99USD per month
* 16 users x 10 private repos = 199USD per month
* 32 users x 20 private repos = 399USD per month

### [PullReview](https://www.pullreview.com/)

還沒有認真的用，但初步看起來，使用方式跟 Code Climate 類似、功能較多，但計費方式不同。
功能似乎相當於有 Rubocop + Brakeman + 複雜度與重複性檢測，但底層是用誰目前不確定，支援 GitHub 跟 BitBucket。

* 1 user x unlimited private repos = 20EUR per month

其實還有一些其他的服務，但因為我自己沒用過所以就不特別介紹了。
