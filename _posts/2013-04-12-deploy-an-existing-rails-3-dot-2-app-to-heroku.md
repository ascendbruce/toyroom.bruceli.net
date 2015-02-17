---
layout: post
title: Deploy an existing rails 3.2 app to heroku
published: true
date: 2013-04-12 23:33
tags:
- rails
categories: []
comments: true

---


Assume that your project directory is `~/my_project`. Using MySQL And manage you code with git. You want to deploying it to heroku and keeping working locally with MySQL. This is my solution:

## Pre-requirements

Download and install [heroku toolbelt](https://toolbelt.heroku.com/).

After installed, you should got `heroku` command in CLI now.

cd to your project directory:

    cd ~/my_project

## Set up heroku app

Login to heroku with email and password:

    heroku login

> You might be asked to generate SSH publich key at first time login

Create and rename an heroku app

    heroku create
    heroku rename MY_PROJECT

## Code modifications
[Heroku provide 3 ways to use asset pipeline](https://devcenter.heroku.com/articles/rails-asset-pipeline). I currently use "compiling assets locally". It's simple but less automatically.

> Make sure your had set production environmnet correctly in local. Or you may encounter problems on running `rake … RAILS_ENV=production`.

    rake db:create RAILS_ENV=production
    
    RAILS_ENV=production bundle exec rake assets:precompile

    git add .
    git commit -m "precompile assets"


To keep local working with MySQL. I opened a branch for heroku depolyment called `heroku`.

    git branch heroku
    git checkout heroku

Edit `~/my_project/Gemfile`. change:

    gem 'mysql2'

To this:

    gem 'pg'

Now run bundle install

    bundle install

Last, deploy to heroku

    git push heroku heroku:master

> If you are pushing local `master` branch to heroku than you should use `git push heroku master`

## Notes
I like to keep heroku-related modifications to `heroku` branch. So merge frequently:

    # modifications don on master...
    git checkout heroku
    git merge master --no-ff
    git push heroku heroku:master

## Links
* [Getting Started with Heroku](https://devcenter.heroku.com/articles/quickstart)
* [Getting Started with Rails 3.x on Heroku](https://devcenter.heroku.com/articles/rails3)

