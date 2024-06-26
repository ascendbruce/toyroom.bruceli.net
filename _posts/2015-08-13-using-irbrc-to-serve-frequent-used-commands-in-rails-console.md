---
title: Save your time in rails console by using irbrc to provide shortcuts for frequent commands
date: 2015-08-13 22:10
category:
- en
tags:
- dev
- rails
image: /images/posts/007-use-irbrc-to-save-time-with-rails-console.png?v=1
excerpt: Finding your own user account in rails console is very frequent command in daily work. But key the full command is very inconvenient and waste time. You can use this technique to save time!

---

<a href="{% link _posts/2015-08-13-using-irbrc-to-serve-frequent-used-commands-in-rails-console.md %}" class="lang-btn lang-current">EN</a>
<a href="{% link _posts/2014-06-14-using-irbrc-to-serve-frequent-used-commands-in-rails-console.md %}" class="lang-btn">TW</a>

Finding your own user account in rails console is very frequent command in daily work. But key the full command is very inconvenient and waste time. You can use this technique to save time!

## Solution

Edit `~/.irbrc` (or `~/.pryrc` if you are using pry)

``` ruby
class Dev
  def self.me
    User.find_by_email("your_mail@example.com")
  end
end
```

Then in rails console:

```
[1] pry(main)> user = Dev.me
  User Load (0.3ms)  SELECT `users`.* FROM `users` WHERE `users`.`email` = 'your_mail@example.com' LIMIT 1
  ...
```

You can put most frequent used commands in there. But watch out for name collision.

> p.s. I used to put a `app/models/dev.rb` in every projects. But it gets inconvenient when maintaining too many projects. Also your colleagues might have a different shortcut preferences. So I decided to put them in `~/.pryrc`
