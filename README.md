# www.bruceli.net blog

## build and preview locally

Make sure:

* ruby (version specified in `.ruby-version`)
* bundler
* Run `bundle install`

Then

```bash
jekyll serve --livereload --drafts --config _config.yml,_config-dev.yml -P 4001 --incremental
```

other usful commands

```
jekyll build
jekyll server
```

## Site URL

* http://www.bruceli.net/

## Deploy Production

Uses GitHub pages

git push master to https://github.com/ascendbruce/toyroom.bruceli.net
