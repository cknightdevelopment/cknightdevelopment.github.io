---
layout: post
title:  "CoverT 37: CSS filter"
date:   2020-03-19 09:00:00 -0700
categories: [CoverT]
tags: [CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-css-filter?file=style.css
---

The `filter` property can be used to apply a ton of different graphical effects to an element. Filters are commonly used to adjust the rendering of images, backgrounds, etc.

#### Example

```html
<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
```

```css
img.my-img {
  margin: 5px;
}

img.my-img:nth-child(2) {
  filter: contrast(200%);
}

img.my-img:nth-child(3) {
  filter: grayscale(80%);
}

img.my-img:nth-child(4) {
  filter: hue-rotate(120deg);
}

img.my-img:nth-child(5) {
  filter: sepia(80%);
}

img.my-img:nth-child(6) {
  filter: blur(2px);
}
```

#### Result

<style>
img.my-img {
  margin: 5px;
}

img.my-img:nth-child(2) {
  filter: contrast(200%);
}

img.my-img:nth-child(3) {
  filter: grayscale(80%);
}

img.my-img:nth-child(4) {
  filter: hue-rotate(120deg);
}

img.my-img:nth-child(5) {
  filter: sepia(80%);
}

img.my-img:nth-child(6) {
  filter: blur(2px);
}
</style>

<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
<img class="my-img" src="https://i.picsum.photos/id/10/300/200.jpg" />
