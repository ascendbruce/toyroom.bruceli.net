---
layout: post
title: mac rvm 安裝 ruby 解決問題記錄
published: true
date: 2013-11-16 14:00
tags:
- ruby
- mac
categories: []
comments: true

---
今天把家裡的 mac 安裝 ruby 1.9.3-p448，來幫朋友看一個 project，沒想到這台太久沒有維護環境，遇到不少問題。想說應該有些新手遇到這類問題還蠻不知道怎麼解，就丟出來做個記錄，整個 console log 沒有做太多編修。

這篇的重點是如何設定 mac 的開發環境，而不是 ruby 技術問題。

通則就是： **要仔細看錯誤訊息在講什麼** ~~如果看到錯誤就放棄，一切就結束了~~

開始

    macbook:project bruce$ rvm install ruby-1.9.3-p448

<!--more-->

錯誤

    Searching for binary rubies, this might take some time.
    No binary rubies available for: osx/10.7/x86_64/ruby-1.9.3-p448.
    Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
    Checking requirements for osx.
    Warning: port definitions are more than two weeks old, consider updating them by running 'port selfupdate'.
    Error! ncursesw was replaced by ncurses a long time ago, please uninstall 'ncursesw',
             for more details check http://comments.gmane.org/gmane.os.apple.macports.user/28039
    Requirements installation failed with status: 1.

首先，rvm 安裝可能會遇到 rvm 本身太舊，所以不管三七二十一先 update 一下

    macbook:project bruce$ rvm update
    
錯誤
    
    ERROR: rvm update has been removed. Try 'rvm get head' or see the 'rvm get' and rvm 'rubygems' CLI API instead

噢，原來語法改了

    macbook:project bruce$ rvm get head
    
看來這次有成功了
    
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100   184  100   184    0     0    177      0  0:00:01  0:00:01 --:--:--   258
    100 19527  100 19527    0     0   7868      0  0:00:02  0:00:02 --:--:-- 37123
    Downloading RVM branch master
    Downloading https://github.com/wayneeseguin/rvm/archive/master.tar.gz to rvm-master.tgz.
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100   124  100   124    0     0    139      0 --:--:-- --:--:-- --:--:--   186
    100 1088k  100 1088k    0     0   257k      0  0:00:04  0:00:04 --:--:--  411k

    Upgrading the RVM installation in /Users/bruce/.rvm/
        RVM PATH line found in /Users/bruce/.zshrc.
        RVM PATH line not found for Bash, run the installer with '--auto-dotfiles' to fix it.
        RVM sourcing line found in /Users/bruce/.bash_profile.
        RVM sourcing line not found for Zsh, run the installer with '--auto-dotfiles' to fix it.
    Upgrade of RVM in /Users/bruce/.rvm/ is complete.

    # Bruce Li,
    #
    #   Thank you for using RVM!
    #   We sincerely hope that RVM helps to make your life easier and more enjoyable!!!
    #
    # ~Wayne, Michal & team.

    In case of problems: http://rvm.io/help and https://twitter.com/rvm_io

    Upgrade Notes:

      * No new notes to display.

    RVM reloaded!

再來裝裝看

    macbook:project bruce$ rvm install ruby-1.9.3-p448
    Searching for binary rubies, this might take some time.
    No binary rubies available for: osx/10.7/x86_64/ruby-1.9.3-p448.
    Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
    Checking requirements for osx.
    Warning: port definitions are more than two weeks old, consider updating them by running 'port selfupdate'.
    Error! ncursesw was replaced by ncurses a long time ago, please uninstall 'ncursesw',
             for more details check http://comments.gmane.org/gmane.os.apple.macports.user/28039
    Requirements installation failed with status: 1.

它抱怨 `ncursesw` 已經不使用了，要改用 `ncurses` （注意看，他們兩個的拼法不一樣）。那我們就先把 `ncursesw` 移除掉

    macbook:project bruce$ brew uninstall ncursesw

錯誤了

    bash: brew: command not found

這才想到，對喔，我這台電腦是用 macport，來用 `port` 指令移除 `ncursesw`

    macbook:project bruce$ port uninstall ncursesw

port 也抱怨了

    Warning: port definitions are more than two weeks old, consider updating them by running 'port selfupdate'.
    Error: Insufficient privileges to write to MacPorts install prefix.

依照指示（這個會跑很久）

    macbook:project bruce$ port selfupdate
    --->  Updating MacPorts base sources using rsync
    Error: Error synchronizing MacPorts sources: command execution failed
    Please run `port -v selfupdate' for details.
    Error: /opt/local/bin/port: port selfupdate failed: Error synchronizing MacPorts sources: command execution failed

炸了，嗯... 雖然沒有明說，但依照之前的經驗，大概是權限問題

    macbook:project bruce$ sudo port selfupdate
    Password:
    --->  Updating MacPorts base sources using rsync
    MacPorts base version 2.2.0 installed,
    MacPorts base version 2.2.1 downloaded.
    --->  Updating the ports tree
    --->  MacPorts base is outdated, installing new version 2.2.1
    Installing new MacPorts release in /opt/local as root:admin; permissions 0755; Tcl-Package in /Library/Tcl


    The ports tree has been updated. To upgrade your installed ports, you should run
      port upgrade outdated

果然，那接下來可以順利用 `port` 指令了

    macbook:project bruce$ port uninstall ncursesw
    Error: Insufficient privileges to write to MacPorts install prefix.

又忘記加 `sudo`，而且這次有明說

    macbook:project bruce$ sudo port uninstall ncursesw
    Password:
    --->  Deactivating ncursesw @5.8_0
    --->  Cleaning ncursesw
    --->  Uninstalling ncursesw @5.8_0
    --->  Cleaning ncursesw

移掉了以後，裝新的 `ncurses`

    macbook:project bruce$ sudo port install ncurses
    --->  Cleaning ncurses
    --->  Scanning binaries for linking errors: 100.0%
    --->  No broken files found.

那麼，再來嘗試裝 ruby

    macbook:project bruce$ rvm install ruby-1.9.3-p448
    Searching for binary rubies, this might take some time.
    No binary rubies available for: osx/10.7/x86_64/ruby-1.9.3-p448.
    Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
    Checking requirements for osx.
    Updating certificates in '/opt/local/etc/openssl/cert.pem'.
    Requirements installation successful.
    Installing Ruby from source to: /Users/bruce/.rvm/rubies/ruby-1.9.3-p448, this may take a while depending on your cpu(s)...
    ruby-1.9.3-p448 - #downloading ruby-1.9.3-p448, this may take a while depending on your connection...
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100 9816k  100 9816k    0     0  81497      0  0:02:03  0:02:03 --:--:-- 70359
    ruby-1.9.3-p448 - #extracting ruby-1.9.3-p448 to /Users/bruce/.rvm/src/ruby-1.9.3-p448
    ruby-1.9.3-p448 - #extracted to /Users/bruce/.rvm/src/ruby-1.9.3-p448
    ruby-1.9.3-p448 - #configuring....................................................................................................................................................................................................................................................................................................................................................................................................................................................................
    ruby-1.9.3-p448 - #post-configuration
    ruby-1.9.3-p448 - #compiling..................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
    ruby-1.9.3-p448 - #installing.....................................................................................................................................
    Retrieving rubygems-2.1.11
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100  358k  100  358k    0     0   180k      0  0:00:01  0:00:01 --:--:--  202k
    Extracting rubygems-2.1.11 ...
    Removing old Rubygems files...
    Installing rubygems-2.1.11 for ruby-1.9.3-p448.......................................................................................................................................................................................................................................
    Installation of rubygems completed successfully.
    Saving wrappers to '/Users/bruce/.rvm/wrappers/ruby-1.9.3-p448'........

    ruby-1.9.3-p448 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
    ruby-1.9.3-p448 - #importing default gemsets, this may take time..................
    Install of ruby-1.9.3-p448 - #complete
    Ruby was built without documentation, to build it run: rvm docs generate-ri
    'rvm_codesign_identity' is not set so RVM can't sign ruby
     Set it in ~/.rvmrc after reading the following about OS X code signing:
     https://developer.apple.com/library/mac/#documentation/Security/Conceptual/CodeSigningGuide/Introduction/Introduction.html

驗收

    macbook:project bruce$ rvm use 1.9.3-p448
    Using /Users/bruce/.rvm/gems/ruby-1.9.3-p448
    macbook:project bruce$ ruby -v
    ruby 1.9.3p448 (2013-06-27 revision 41675) [x86_64-darwin11.4.2]

可喜可賀！


附帶一提，用了 logdown 以後，再廢的小文也願意花時間寫一下... 這到底是好是壞...