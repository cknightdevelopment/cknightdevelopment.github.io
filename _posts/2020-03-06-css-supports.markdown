---
layout: post
title:  "CoverT Day 28: CSS @supports"
date:   2020-03-06 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-css-supports?file=style.css
---

The `@supports` CSS at-rule lets you specify declarations that depend on a browser's support for one or more specific CSS features. The rule may be placed at the top level of your code or nested inside any other conditional group at-rule.

#### Example

```html
<div class="my-test">Hello</div>
```

```css
@supports (display: flex) {
  .my-test {
    color: red;
  }
}

@supports (display: i-made-this-up) {
  .my-test {
    text-decoration: underline;
  }
}
```

#### Result

<style>
@supports (display: flex) {
  .my-test {
    color: red;
  }
}

@supports (display: i-made-this-up) {
  .my-test {
    text-decoration: underline;
  }
}
</style>

<div class="my-test">Hello</div>