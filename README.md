# www.bruceli.net blog

## build and preview locally

Make sure:

* ruby (version specified in `.ruby-version`)
* bundler
* Run `bundle install`

Then

```bash
# Normal server
jekyll server --drafts --config _config.yml,_config-dev.yml -P 4001

# Livereload
jekyll server --livereload --drafts --config _config.yml,_config-dev.yml -P 4001 --incremental

# Rebuild all and start Livereload
jekyll build --drafts --config _config.yml,_config-dev.yml; jekyll server --livereload --drafts --config _config.yml,_config-dev.yml -P 4001 --incremental
```

other usful commands

```
jekyll build
jekyll server
```

## Managing tags

- Use `site.tags` to find out all used tags. Example: `_layouts/label_page.html`
- To add tag page: create a file at `_labels/TAG_NAME.md`. You may use `scripts/refresh_labels.rb` to batch create
- To remove a tag page: delete the file, and add a `redirect_from:` config accordingly

## Site URL

* http://www.bruceli.net/

## Deploy Production

Uses GitHub pages

git push master to https://github.com/ascendbruce/toyroom.bruceli.net

# Useful tools

* HTML to Markdown https://codebeautify.org/html-to-markdown (for migrating legacy posts)
