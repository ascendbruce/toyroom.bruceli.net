# toyroom.bruceli.net blog

## build and preview locally

Make sure:

* ruby (version specified in `.ruby-version`)
* bundler
* Run `bundle install`

Then

```
jekyll build # or
jekyll server
```

## Site URL

* http://toyroom.bruceli.net/
* http://toyroom-staging.bruceli.net/

## Build and deploy system

* https://app.wercker.com/ascendbruce/toyroom.bruceli.net
* when push to origin
  * if master => deploy staging and production
  * else => deploy to staging only

## Repo

* https://github.com/ascendbruce/toyroom.bruceli.net
* https://github.com/ascendbruce/toyroom.bruceli.net-staging (experimental for github pages)
