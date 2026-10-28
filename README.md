# knightcodes.com

Jekyll blog styled with Tailwind CSS, deployed to GitHub Pages by `.github/workflows/pages.yml` on every push to `master`.

## Setup

Requires Ruby (see `.ruby-version`) and Node.

```sh
bundle install
npm install
```

## Develop

```sh
npm run dev
```

Serves the site at http://localhost:4000 with live reload, and rebuilds the CSS on change.

## Write a post

See `_drafts/example-post.md` for every supported feature: tags, TL;DR, date/time, call-outs and code blocks. Drafts show up in `npm run dev` but are never published.

To publish, add `_posts/YYYY-MM-DD-slug.md`:

```markdown
---
layout: post
title: My Post
subtitle: Optional line under the title
date: 2026-10-25 14:30 -0500   # time is optional
tags: [javascript, css]
tldr: One-line summary.        # optional
updated: 2026-11-02            # optional
toc: true                      # optional
---

> [!TIP]
> Call-outs use GitHub alert syntax: NOTE, TIP, IMPORTANT, WARNING, CAUTION.
```

The home page has tag filters and full-text search. Search reads `search.json`, which is generated at build time.

Call-outs are rendered by `_plugins/callouts.rb`. Code colors come from `_css/syntax.css`, generated with `bundle exec rougify style github.dark`.

Styles live in `_css/main.css`. The Tailwind CLI compiles them to `assets/css/main.css`, which is git-ignored.
