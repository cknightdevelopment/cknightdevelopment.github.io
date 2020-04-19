---
layout: post
title:  "CoverT 29: Transform Order Matters"
date:   2020-03-09 02:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-transform-order-matters?file=style.css
---

When using `transform` in CSS with multiple transformation functions, the order of how they are listed matters!

The transformations will be applied in the order in which they are listed. This can lead to very different results than expected if you are not careful.

#### Example

```html
<div class="my-box-container">
  <div class="my-box">
    <span>1</span>
  </div>
  <div class="my-box">
    <span>2</span>
  </div>
  <div class="my-box">
    <span>3</span>
  </div>
</div>
```

```css
.my-box-container {
  position: relative;
  height: 350px;
}

.my-box {
  width: 175px;
  height: 175px;
  border: 5px solid;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 40px;
  position: absolute;
}

/* translated, then rotated */
.my-box:nth-of-type(1) {
  transform: translate(200px) rotate(75deg);
}

/* rotated, then translated */
.my-box:nth-of-type(2) {
  transform: rotate(75deg) translate(200px);
}

/* no transformation  */
.my-box:nth-of-type(3) {
  transform: none;
  border-style: dashed;
}
```

#### Result

<style>
.my-box-container {
  position: relative;
  height: 350px;
}

.my-box {
  width: 175px;
  height: 175px;
  border: 5px solid;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 40px;
  position: absolute;
}

/* translated, then rotated */
.my-box:nth-of-type(1) {
  transform: translate(200px) rotate(75deg);
}

/* rotated, then translated */
.my-box:nth-of-type(2) {
  transform: rotate(75deg) translate(200px);
}

/* no transformation  */
.my-box:nth-of-type(3) {
  transform: none;
  border-style: dashed;
}
</style>

<div class="my-box-container">
  <div class="my-box">
    <span>1</span>
  </div>
  <div class="my-box">
    <span>2</span>
  </div>
  <div class="my-box">
    <span>3</span>
  </div>
</div>