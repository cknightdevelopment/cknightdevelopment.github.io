---
layout: post
title:  "CoverT 30: Transform Origin"
date:   2020-03-10 02:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-transform-origin?file=style.css
---

The `transform-origin` CSS property sets the origin for an element's transformations. The transformation origin is the point around which a transformation is applied. 

The default is the center of the element, but it can be given a keyword or a value (e.g. percent, pixels, etc.)

#### Example

```html
<div class="my-box-container">
  <div class="my-box">
    <span></span>
  </div>
  <div class="my-box">
    <span>2</span>
  </div>
  <div class="my-box">
    <span>3</span>
  </div>
  <div class="my-box">
    <span>4</span>
  </div>
</div>
```

```css
.my-box-container {
  position: relative;
  margin-left: 150px;
  margin-top: 85px;
}

.my-box {
  width: 100px;
  height: 100px;
  border: 3px solid;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 40px;
  position: absolute;
}

.my-box:nth-of-type(1) {
  border-style: dashed;
}

.my-box:nth-of-type(2) {
  transform: rotate(135deg);
  transform-origin: bottom right;
}

.my-box:nth-of-type(3) {
  transform: rotate(135deg);
  transform-origin: top left;
}

.my-box:nth-of-type(4) {
  transform: rotate(135deg);
}
```

#### Result

<style>
.my-box-container {
  position: relative;
  margin-left: 150px;
  margin-top: 85px;
  height: 200px;
}

.my-box {
  width: 100px;
  height: 100px;
  border: 3px solid;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 40px;
  position: absolute;
}

.my-box:nth-of-type(1) {
  border-style: dashed;
}

.my-box:nth-of-type(2) {
  transform: rotate(135deg);
  transform-origin: bottom right;
}

.my-box:nth-of-type(3) {
  transform: rotate(135deg);
  transform-origin: top left;
}

.my-box:nth-of-type(4) {
  transform: rotate(135deg);
}
</style>

<div class="my-box-container">
  <div class="my-box">
    <span></span>
  </div>
  <div class="my-box">
    <span>2</span>
  </div>
  <div class="my-box">
    <span>3</span>
  </div>
  <div class="my-box">
    <span>4</span>
  </div>
</div>