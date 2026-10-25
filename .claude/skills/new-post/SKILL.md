---
name: new-post
description: Use when Chris wants to turn writing (usually a Google Docs markdown export or pasted text) into a blog post for this site. Formats the source as-is, proposes tags, TL;DR and call-outs for approval, writes a draft, previews it, and publishes it to _posts when asked. Never changes Chris's words.
---

# New post

Turn Chris's writing into a post. **The content is Chris's and must not be AI-generated.** Your job is formatting, call-outs and the TL;DR, nothing else.

## Rules

- Never add, remove, reword, reorder or "improve" any sentence. That includes typos, grammar and punctuation in prose: point them out and let Chris fix them in the source, but don't change them yourself.
- The title is Chris's. Use the doc's title as written.
- A call-out wraps an existing passage verbatim. Never write new call-out text. Use the default title (Note, Tip, ...) unless Chris supplies one.
- The TL;DR is the one exception: you may draft it, but only as a proposal. Build it from Chris's own sentences where possible, and only use it once Chris has approved or rewritten it.
- When unsure whether a change touches content or only formatting, ask.

## 1. Get the source

Accept pasted text or a file path. From Google Docs, the best export is **File → Download → Markdown (.md)**.

Only fix what the export broke:

- Remove needless backslash escapes (`\-`, `\_`, `\#`, `\*`, `\.`, `\>`, `\[`), but keep any inside code.
- Replace smart quotes and dashes inside code with plain ASCII. Leave them in prose.
- Turn code that lost its formatting (monospace runs, pasted snippets) back into fenced blocks with the right language, or inline `code`. Don't change the code itself.
- Move the doc title into the `title` front matter instead of an `# H1`. Body headings start at `##`.
- Images: Docs exports embed them as base64 data URIs (often as reference links at the bottom). Decode each into `assets/images/posts/<slug>/<descriptive-name>.png` and link it as `/assets/images/posts/<slug>/...`. Ask Chris for alt text.
- Drop empty paragraphs, stray `&nbsp;` and trailing whitespace.

## 2. Propose, then wait

Find the tags already in use:

```sh
grep -h "^tags:" _posts/*.md _drafts/*.md
```

Then present a short proposal and wait for Chris's answers before writing anything:

- **Slug**: short, lowercase, hyphenated, from the title.
- **Tags**: reuse existing ones where they fit; flag any new tag.
- **TL;DR**: one or two sentences giving the takeaway, built from Chris's wording where possible.
- **Call-outs**: quote each passage you'd wrap, with its type (NOTE / TIP / IMPORTANT / WARNING / CAUTION). Use them sparingly: a few per post at most, and only for passages that are a real aside, gotcha or key point.
- **Code**: the language for each block.
- **Possible typos**: list any you noticed, with their location. Don't fix them.
- **Table of contents**: suggest `toc: true` if the post is long or has many `##` sections.
- **Date**: default to now in America/Chicago unless Chris gives one. When revising an already-published post, propose an `updated:` date instead of changing `date`.

## 3. Write the draft

Write `_drafts/<slug>.md` using the front matter in `CLAUDE.md` (include `date` so the preview URL is stable). Use `_drafts/example-post.md` as the syntax reference.

Before handing it over, diff the draft's prose against the source to confirm no words changed beyond the formatting fixes above.

Make sure `npm run dev` is running, then give Chris the URL: `http://localhost:4000/YYYY/MM/DD/<slug>/`. If browser tools are available, screenshot the page and check that call-outs, code blocks and images render properly.

Iterate until Chris is happy.

## 4. Publish (only when Chris says so)

1. Move `_drafts/<slug>.md` to `_posts/YYYY-MM-DD-<slug>.md`, matching the front matter date.
2. Run `npm run build` and make sure it succeeds.
3. Commit only if asked. Pushing to `master` makes the post live, so confirm before pushing.
