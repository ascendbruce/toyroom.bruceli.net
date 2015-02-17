---
layout: post
title: Enable desktop notification for BitBucket HipChat hook
published: true
date: 2014-04-15 13:42
tags: []
categories: []
comments: true

---
Althought there is no checkbox for room notify. We can enable desktop notification by editing the API URL.

### To enable desktop notification:

1. Go to `Admin (the Gear icon) > Hooks > HipChat > Edit`
2. Update `API URL` to `https://api.hipchat.com/v1/rooms/message?notify=1`
3. Save

> If you did not have a HipChat hook yet. Select `HipChat` from dropdown, hit `Add hook` and fill in RoomID and Token to add it.

### The difference

`https://api.hipchat.com/v1/rooms/message` (Default)
`https://api.hipchat.com/v1/rooms/message?notify=1` (Enable desktop notification)

Inspired by [this comment](https://bitbucket.org/site/master/issue/5974/add-room-notification-option-to-hipchat#comment-3383334)
