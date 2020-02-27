---
layout: post
title:  "CoverT Day 23: Default Border Color"
date:   2020-02-28 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-default-border-color?file=style.css
---

I used to think that the default color for borders was black, but now I know better...

The actual default border color is `currentColor`, basically whatever the element's `color` value is (inherited or otherwise).

### Code

```html
<div class="box">
  Default border color is currentColor
</div>
```

```css
.box {
  height: 160px;
  width: 160px;
  padding: 20px;
  color: blue;
  border: 5px solid;
}
```

### Results

<style>
.box {
  height: 160px;
  width: 160px;
  padding: 20px;
  color: blue;
  border: 5px solid;
}
</style>

<div class="box">
  Default border color is currentColor
</div>