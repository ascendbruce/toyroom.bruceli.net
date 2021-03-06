---
title: Use codeclimate-test-reporter without a CI server
published: true
date: 2014-11-15 13:29
tags:
- rails
- Techbang
category: [en]
comments: true
excerpt: For some reason, we didn’t setup a CI server. But we still want Code Climate to know test coverage after each deployment. After some searching and experiment. We came up with this solution.
---
For some reason, we didn't setup a CI server. But we still want Code Climate to know test coverage after each deployment.

After some searching and experiment. We came up with this solution.

## 1. Add Capistrano run_tests task

Because we don't have a CI server. We use Ben Dixon's [run_tests](https://github.com/TalkingQuickly/capistrano-3-rails-template/blob/master/lib/capistrano/tasks/run_tests.cap) technique covered in his book [Reliably Deploying Rails Applications](https://leanpub.com/deploying_rails_applications), which is:

``` ruby
# lib/capistrano/tasks/run_tests.cap
namespace :deploy do
  desc "Runs test before deploying, can't deploy unless they pass"
  task :run_tests do
    test_log = "log/capistrano.test.log"
    tests = fetch(:tests)
    tests.each do |test|
      puts "--> Running tests: '#{test}', please wait ..."
      unless system "bundle exec rspec #{test} > #{test_log} 2>&1"
        puts "--> Tests: '#{test}' failed. Results in: #{test_log} and below:"
        system "cat #{test_log}"
        exit;
      end
      puts "--> '#{test}' passed"
    end
    puts "--> All tests passed"
    system "rm #{test_log}"
  end
end
```

``` ruby
# config/deploy.rb
set :tests, ["spec"]
before :deploy, "deploy:run_tests"
```

It will run test before every deploy. And stop deploy process if there are any failed test.

## 2. Install and setup codeclimate-test-reporter

Install [codeclimate-test-reporter](https://github.com/codeclimate/ruby-test-reporter) by adding it into `Gemfile`

``` ruby
# Gemfile
gem "codeclimate-test-reporter", group: :test
```

and run `bundle install`

Start the test reporter. Make sure that you put these lines at top of your `spec_helper.rb`.

``` ruby
# spec_helper.rb
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
```

Manually tirgger fist test report (your project token can be found at `Settings > Test Coverage`)

``` shell (in terminal)
$ cd your_project_root
$ CODECLIMATE_REPO_TOKEN=your_token_here bundle exec rspec spec
```

It should show following message:

    Coverage = xx.xx%. Sending report to https://codeclimate.com for branch master... done.

Now you should be able to see the report showing in Code Climate. Sometimes it can take a few minutes.

## 3. Modify run_tests and make it report after each deployment

When you run `rspec` without `CODECLIMATE_REPO_TOKEN`, even you have test reporter started, it won't send test report to Code Climate. In other words, you can control when to send report by giving token or not.

Modify the rspec command in `lib/capistrano/tasks/run_tests.cap`

> I assume you always run complete test suit with this technique.

``` diff
# lib/capistrano/tasks/run_tests.cap
namespace :deploy do
  desc "Runs test before deploying, can't deploy unless they pass"
  task :run_tests do
    test_log = "log/capistrano.test.log"
    tests = fetch(:tests)
    tests.each do |test|
      puts "--> Running tests: '#{test}', please wait ..."
+      rspec_command = "bundle exec rspec #{test} > #{test_log} 2>&1"
+      rspec_command = "CODECLIMATE_REPO_TOKEN=#{fetch(:codeclimate_token)} #{rspec_command}" if fetch(:codeclimate_token)
+      puts "--> Running tests: '#{rspec_command}', please wait ..."
+      unless system(rspec_command)
-      unless system "bundle exec rspec #{test} > #{test_log} 2>&1"
        puts "--> Tests: '#{test}' failed. Results in: #{test_log} and below:"
        system "cat #{test_log}"
        exit;
      end
      puts "--> '#{test}' passed"
    end
    puts "--> All tests passed"
    system "rm #{test_log}"
  end
end
```

``` ruby
# config/deploy.rb
set :codeclimate_token, your_token_here
```

Now, test will be run before every deployment and test report will be sent after that.

> Note: you can put your token in `run_tests.cap` for simplicity. But I rarely commit any key or token into repostory. Instead, I put it in a git-ignored, separated config file. Than read and assign the value in `config/deploy.rb`.
