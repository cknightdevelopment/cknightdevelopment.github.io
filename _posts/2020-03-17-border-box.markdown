---
layout: post
title:  "CoverT Day 35: Box Sizing Border Box"
date:   2020-03-17 02:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-box-sizing?file=style.css
---

The `box-sizing` property defines how the width and height of an element are calculated.

- `content-box`	(default): The width and height properties (and min/max properties) includes only the content. Border and padding are NOT included
- `border-box`:	The width and height properties (and min/max properties) includes content, padding and border

#### Example

```html
<div class="my-box">
  <span>content box</span>
</div>
<div class="my-box border-box">
  <span>border-box</span>
</div>
```

```css
.my-box {
  border: 10px solid;
  padding: 10px;
  width: 200px;
  height: 200px;
  background-color: yellow;
  display: flex;
  justify-content: center;
  align-items: center;
}

.border-box {
  box-sizing: border-box;
}
```

#### Result

<style>
.my-box {
  border: 10px solid;
  padding: 10px;
  width: 200px;
  height: 200px;
  background-color: yellow;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 10px;
  box-sizing: content-box;
}

.border-box {
  box-sizing: border-box;
}
</style>

<div class="my-box">
  <span>content box</span>
</div>
<div class="my-box border-box">
  <span>border-box</span>
</div>

