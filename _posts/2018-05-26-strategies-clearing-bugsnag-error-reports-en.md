---
title: "Strategies for emptying error reports from bugsnag/airbrake/sentry"
date: 2018-05-26 17:40
category: [en]
tags: []
image: /images/posts/010-line-chart-heading-down.png
excerpt: "Error monitoring tool is one of the must-have tools nowadays. But you may also have seen this: There are thousands of errors every day. Serious ones and minor ones are all mixed. People become numb because there are way too many. That is not really monitoring errors. Following strategies are what I usually do when I need to introduce error monitoring to a new team"
---

<a href="{% link _posts/2018-05-26-strategies-clearing-bugsnag-error-reports-en.md %}" class="lang-btn lang-current">EN</a>
<a href="{% link _posts/2018-05-26-strategies-clearing-bugsnag-error-reports.md %}" class="lang-btn">TW</a>

![cover]({{ "/images/posts/010-line-chart-heading-down.png" | absolute_url }})

Error monitoring tool is one of the must-have tools nowadays. But you may also have seen this: There are thousands of errors every day. Serious ones and minor ones are all mixed. People become numb because there are way too many. That is not really "monitoring" errors.

Following strategies are what I usually do when I need to introduce error monitoring to a new team:

* Enable the integration for Bugsnag and slack (or the services you use). But don't notify the low severity ones.
* **Ask all team members to enable slack notification of the channel.**  ★️ important
* Classify errors that don't require action. Set them to "Info" (low severity) for one time.
* When working on [handled error reporting](https://docs.bugsnag.com/platforms/ruby/rails/reporting-handled-errors/), set it to low severity if applicable.
* Use an issue tracking system and integrate with Bugsnag's worflow automation. To avoid duplicate work on resolving the same Bugsnag report.
* When the flood of error notifications come, identify the issue, snooze the notification and fix it ASAP.

The result:

Every member receives notifications. A flood of errors happens from time to time. However, everyone is happy:

* Developers know that something really needs to take a look when receiving a notification.
* Business owner knows that those errors will be noticed very soon. No need to watch after developers.
* Users won't be put aside and seeing the same error for days.

Further reading:

* [Strategies for improving your debugging workflow](https://blog.bugsnag.com/debugging-workflow/)
