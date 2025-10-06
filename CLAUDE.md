# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Site Overview

This is a Jekyll-based blog for "Bruce 的玩具間 Blog" hosted on GitHub Pages. The site uses the Minima theme with customizations and supports multiple languages (primarily Traditional Chinese, some English and Japanese content).

## Development Commands

### Local Development Server

```bash
# Normal server with drafts
jekyll server --drafts --config _config.yml,_config-dev.yml -P 4001

# With livereload for development
jekyll server --livereload --drafts --config _config.yml,_config-dev.yml -P 4001 --incremental

# Force rebuild all and start with livereload
jekyll build --drafts --config _config.yml,_config-dev.yml; jekyll server --livereload --drafts --config _config.yml,_config-dev.yml -P 4001 --incremental
```

### Basic Jekyll Commands

```bash
jekyll build     # Build site
jekyll server    # Start development server (basic)
bundle install   # Install Ruby dependencies
```

## Site Architecture

### Content Structure

- **Posts**: Located in `_posts/` with date-based filename format (YYYY-MM-DD-title.md)
- **Pages**: Located in `_pages/` and project root (eg. now-tw.md, search.html, support-tw.md, ...)
- **Work Projects**: Special posts in `_posts/works/` subdirectory for portfolio items
- **Labels/Tags**: Tag pages auto-generated in `_labels/` collection, managed via `scripts/refresh_labels.rb`
- **Images**: Stored in `images/posts/` with organized naming convention

### Key Configuration

- **Theme**: Uses Minima theme with customizations
- **Markdown**: CommonMarkGhPages processor with UNSAFE, SMART, FOOTNOTES options
- **Collections**: `_labels` collection for tag pages with permalink `/labels/:path`
- **Timezone**: Asia/Taipei
- **Plugins**: jekyll-feed, jekyll-seo-tag, jemoji, jekyll-redirect-from, jekyll-sitemap

### Tag Management System

- Use `site.tags` in templates to access all tags
- Create tag pages by adding files to `_labels/TAG_NAME.md`
- Use `ruby scripts/refresh_labels.rb` to batch create tag pages
- When removing tags, add `redirect_from:` config for SEO

### Multi-language Support

- Content categories: `tw`, `en`, `jp` for different languages
- RSS feed configured to include all language categories
- Primary language is Traditional Chinese (`tw`)

### Deployment

- Hosted on GitHub Pages
- Deploy by pushing to master branch on https://github.com/ascendbruce/toyroom.bruceli.net
- Uses GitHub Pages build process (no separate build step required)

## Development Notes

- Development server runs on port 4001 to avoid conflicts
- Use `_config-dev.yml` overlay for development-specific settings
- Jekyll-feed plugin excluded in development for faster regeneration
- Drafts are included in development server for preview

## Content

### Posts

- Front matter: follow this example: _posts/2025-10-04-body-fat-smart-scales-inbody-tanita-comparison.md
- Tags (a.k.a. labels):  Available tags can be found in _data/labels.yaml
- Main tags: Each article MUST fall into one (and only one) of following 4 main tags: #dev #productivity #商業理財 #life
- Normal tags: Can opitonally add normal labels
- Avoid using tags that didn't listed in _data/labels.yaml (a.k.a. hidden tags)

## Frequent Tasks

### Convert HTML to Markdown

1. When you start working on this task, first show me a message "CLAUDE.md Frequent Task identified: Convert HTML to Markdown"
2. Convert HTML content to Markdown equivalent (tool: https://codebeautify.org/html-to-markdown)
3. Format the Markdown content properly
4. Change file extension from `.html` to `.md`
5. Save images to `images/posts/` directory with appropriate naming
6. Git add your changes into stage

### Migrate a article from other source

migrate post from an online post

1. When you start working on this task, first show me a message "CLAUDE.md Frequent Task identified: Migrate article from an online page"
2. You may use https://freedium.cfd/URL (eg. https://freedium.cfd/https://the-original-url.com) to fetch from a live page
3. Save images to `images/posts/` directory with iso8601date-short-slug. If the post contains more than 2 images, then use a subfolder
4. Use Jekyll's `{% link %}` tag for internal image references. use image syntax or link syntax accordingly
5. Follow the date-based filename convention for posts
6. When creating posts, use the original publication date from the online article (if not given instruction)
7. make sure Front matter meets the standard
8. git stage relevant changes

origin: <URL>
save to: <FILENAME>
