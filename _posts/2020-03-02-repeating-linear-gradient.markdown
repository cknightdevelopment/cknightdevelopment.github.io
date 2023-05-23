---
layout: post
title:  "CoverT 24: repeating-linear-gradient"
date:   2020-03-02 09:00:00 -0700
categories: [CoverT]
tags: [CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-repeating-linear-gradient?file=style.css
---

The `repeating-linear-gradient()` function creates an image consisting of repeating linear gradients. It takes the exact same arguments as the more common `linear-gradient()`, but it repeats the color stops infinitely in all directions to cover its entire container.

### Code

```html
<div class="box"></div>
```

```css
.box {
  height: 300px;
  width: 300px;

  background-image: repeating-linear-gradient(
    red 0, 10px,
    yellow 10px, 20px,
    green 20px, 30px,
    blue 30px, 40px,
    indigo 40px, 50px,
    purple 50px,
    purple 60px
  );
}
```

### Results

<style>
.box {
  height: 300px;
  width: 300px;

  background-image: repeating-linear-gradient(
    red 0, 10px,
    yellow 10px, 20px,
    green 20px, 30px,
    blue 30px, 40px,
    indigo 40px, 50px,
    purple 50px,
    purple 60px
  );
}
</style>

<div class="box"></div>