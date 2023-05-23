---
layout: post
title:  "CoverT 25: radial-gradient"
date:   2020-03-03 09:00:00 -0700
categories: [CoverT]
tags: [CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-radial-gradient?file=style.css
---

`radial-gradient()` function can be used creates a circular (or ellipis) background image of color stops. There are a ton of options around the location of the origin, colors, etc.

### Code

```html
<div class="box"></div>
```

```css
.box {
  height: 500px;
  width: 500px;

  background-image: radial-gradient(
    circle at center,
    red,
    orange,
    yellow,
    green,
    blue,
    indigo,
    violet
  );
}
```

### Results

<style>
.box {
  height: 500px;
  width: 500px;

  background-image: radial-gradient(
    circle at center,
    red,
    orange,
    yellow,
    green,
    blue,
    indigo,
    violet
  );
}
</style>

<div class="box"></div>