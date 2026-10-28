---
layout: post
title: Example Post
subtitle: A tour of everything a post can do
date: 2026-10-25 14:30 -0500
tags: [javascript, meta]
updated: 2026-10-26
toc: true
tldr: Every formatting feature this blog supports, in one place. Copy from here when writing a new post.
---

Drafts in `_drafts/` show up with `npm run dev` but are never published. To publish, move the file to `_posts/YYYY-MM-DD-slug.md`.

## Links

Links look like [this one to the Jekyll docs](https://jekyllrb.com/docs/) inside a sentence. Links to other sites get a small arrow; links within this site, like [the About page](/about/), don't. They work in lists too:

- [Tailwind CSS](https://tailwindcss.com)
- [MDN Web Docs](https://developer.mozilla.org)

## Front matter

- `title`: shown at the top and in the post list.
- `subtitle`: optional line under the title. Also shown in the post list (instead of the TL;DR) and used as the description in search results and link previews.
- `date`: include a time (`2026-10-25 14:30 -0500`) to show it, or leave it off to show only the date.
- `tags`: one or more, e.g. `[javascript, css]`. They link to the home page filter.
- `tldr`: optional summary, shown in a box at the top and in the post list. Markdown works.
- `updated`: optional date the post was last revised, shown next to the date.
- `toc: true`: optional table of contents built from `##` and `###` headings. Use it for long posts.

Reading time is calculated automatically. Hover any heading to get a `#` link to that section.

## Quotes

A blockquote, with an optional `<cite>` line for who said it:

> "Quote text goes here."
>
> <cite>Someone Famous</cite>

## Call-outs

> [!NOTE]
> Useful information the reader should notice.

> [!TIP]
> A helpful suggestion. Supports **markdown** and `inline code`.

> [!IMPORTANT] Custom title
> Put text after the type to replace the default title.

> [!WARNING]
> Something that needs attention.

> [!CAUTION]
> Something risky.

## Code

### Fenced blocks

Fence code with a language for syntax coloring. Hover a block to copy it.

```js
const greet = (name) => `Hello, ${name}!`;
console.log(greet("world"));
```

```sh
npm run dev
```
