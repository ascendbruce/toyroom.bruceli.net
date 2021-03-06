---
title: 'Tutorial: How to install Virtualbox Guest Additions in CentOS 5.3 Linux'
published: true
date: 2012-01-10 09:00
tags: []
category: [en]
comments: true
redirect_from:
  - /2012/01/tutorial-how-to-install-virtualbox.html
---


[Device > Install Guest Additions] to download guest OS additions zip. Then exact to a folder.

In that folder, run:

``./VBoxLinuxAdditions.run``
If you got an error on "build main" section with a message about KERN_DIR. Try:
		yum install -y gcc kernel-devel kernel-headers
		yum install -y kernel sources # I'm not sure if those are necessary. but i've installed it.
		And reboot client OS.

And run again:
``./VBoxLinuxAdditions.run``
Now you should get all "OK". Reboot client OS again. Now the additions should take placed.

If still not work, this is further problem shooting teach: [How to install VBox Guest Additions on CentOS 5.6-No Problem][1]

[1]: http://gamblis.com/2011/06/26/how-to-install-vbox-guest-additions-on-centos-5-6-no-problem/
