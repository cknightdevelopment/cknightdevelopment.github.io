---
layout: post
title:  "CoverT 36: !important Doesn't Work With Animations"
date:   2020-03-18 02:00:00 -0700
categories: [CoverT]
tags: [CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-animation-not-important?file=style.css
---

Using `!important` with an animation style does not work **at all**. It's not only _un_-important; it totally ignores the style altogether.

#### Example

```html
<div class="my-box">
  <span>same color</span>
</div>
```

```css
.my-box {
  width: 200px;
  height: 200px;
  display: flex;
  justify-content: center;
  align-items: center;
  background: yellow;

  animation-name: notImportant;
  animation-duration: 5s;
  animation-timing-function: linear;
  animation-direction: alternate;
  animation-iteration-count: infinite;
}

@keyframes notImportant {
  to {
    background: green;
    font-size: 30px;
    color: red !important;
  }
}
```

#### Result

<style>
.my-box {
  width: 200px;
  height: 200px;
  display: flex;
  justify-content: center;
  align-items: center;
  background: yellow;

  animation-name: notImportant;
  animation-duration: 5s;
  animation-timing-function: linear;
  animation-direction: alternate;
  animation-iteration-count: infinite;
}

@keyframes notImportant {
  to {
    background: green;
    font-size: 30px;
    color: red !important;
  }
}
</style>

<div class="my-box">
  <span>same color</span>
</div>
