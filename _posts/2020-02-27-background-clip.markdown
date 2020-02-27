---
layout: post
title:  "CoverT Day 22: background-clip"
date:   2020-02-27 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-background-clip?file=style.css
---

The `background-clip` property sets what area an element's background color extends to.

- `border-box`: Extends to the outside edge of the border, but underneath the border in z-ordering.
- `padding-box`: Extends to the outside edge of the padding and no background is drawn beneath the border.
- `content-box`: Painted within the content box only.

### Code

```html
<h4>Border Box (default)</h4>
<div class="my-box border-box"></div>

<h4>Padding Box</h4>
<div class="my-box padding-box"></div>

<h4>Content Box</h4>
<div class="my-box content-box"></div>
```

```css
.my-box {
  height: 100px;
  width: 100px;
  border: 10px dashed black;
  background-color: pink;
  padding: 20px;
  margin-bottom: 20px;
}

.border-box {
  background-clip: border-box;
}

.padding-box {
  background-clip: padding-box;
}

.content-box {
  background-clip: content-box
}
```

### Results

<style>
.my-box {
  height: 100px;
  width: 100px;
  border: 10px dashed black;
  background-color: pink;
  padding: 20px;
  margin-bottom: 20px;
}

.border-box {
  background-clip: border-box;
}

.padding-box {
  background-clip: padding-box;
}

.content-box {
  background-clip: content-box
}
</style>

#### Border Box (default)
<div class="my-box border-box"></div>

#### Padding Box
<div class="my-box padding-box"></div>

#### Content Box
<div class="my-box content-box"></div>