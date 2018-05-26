# toyroom.bruceli.net blog

## build and preview locally

Make sure:

* ruby (version specified in `.ruby-version`)
* bundler
* Run `bundle install`

Then

```
jekyll s --drafts --config _config.yml,_config-dev.yml
```

other usful commands

```
jekyll build # or
jekyll server
```

## Site URL

* http://toyroom.bruceli.net/
* http://toyroom-staging.bruceli.net/

## Deploy Production

Uses GitHub pages

git push master to https://github.com/ascendbruce/toyroom.bruceli.net

## Deploy Staging

1. branch off
2. make change following configs:
    ```diff
    - url: "https://toyroom.bruceli.net"
    + url: "https://toyroom-staging.bruceli.net"
    ```
3. git push master to https://github.com/ascendbruce/toyroom.bruceli.net-staging
