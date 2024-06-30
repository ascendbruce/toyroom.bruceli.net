---
layout: post
title: CPAN安裝出現can't access URL錯誤訊息 (已解決)
published: true
date: 2011-10-25 17:25
tags: []
category:
- tw
comments: true
redirect_from:
  - /2011/10/cpancant-access-url.html
---


為了安裝AWS的SES功能，依照指示要安裝一些相依套件，在Mac的terminal執行以下指令：

		perl -MCPAN -e 'install LWP::Protocol::https'


結果出現了一堆錯誤訊息，主要大概是這樣：
		Not connected.
		Not connected.
		Passive mode: off; fallback to active mode: off.
		Not connected.
		Bad luck... Still failed!
		Can't access URL ftp://mirror.ihost.md/CPAN/authors/01mailrc.txt.gz.

		Please check, if the URLs I found in your configuration file
		(ftp://cpan.mirror.ac.za/, ftp://cpan.inode.at/,
		ftp://ftp.lip6.fr/pub/perl/CPAN/, ftp://cpan.cict.fr/pub/CPAN/,
		ftp://mirror.ihost.md/CPAN/) are valid. The urllist can be edited. E.g.
		with 'o conf urllist push ftp://myurl/'

		Could not fetch authors/01mailrc.txt.gz


解法：
		export FTP_PASSIVE=1
		# 之後再執行
		perl -MCPAN -e 'install LWP::Protocol::https' # 這行需要root權限

## 來源：http://www.nntp.perl.org/group/perl.macosx/2007/10/msg10405.html


我的環境是Mac OS X 10.7，但Unix-like的應該都適用。

