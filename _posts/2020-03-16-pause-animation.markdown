---
layout: post
title:  "CoverT Day 34: Pause Animation"
date:   2020-03-16 02:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-pause-animation?file=style.css
---

CSS animations can be paused using `animation-play-state: paused`

#### Example

```html
<div class="my-container">
  <div class="my-box">Hover over me</div>
</div>
```

```css
* {
  box-sizing: border-box;
}

.my-container {
  position: relative;
  height: 300px;
  border: 10px solid;
}

.my-box {
  position: absolute;
  padding: 10px;
  border: 2px solid;
  width: 100px;
  height: 100px;
  animation-name: diagonal;
  animation-duration: 2s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

/* pause animation on hover */
.my-box:hover {
  animation-play-state: paused;
  background: grey;
  cursor: pointer;
}

@keyframes diagonal {
  from {
    top: 0;
  }

  to {
    top: calc(100% - 100px);
  }
}
```

#### Result

<style>
.my-container {
  position: relative;
  height: 300px;
  border: 10px solid;
}

.my-box {
  position: absolute;
  padding: 10px;
  border: 2px solid;
  width: 100px;
  height: 100px;
  animation-name: diagonal;
  animation-duration: 2s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

/* pause animation on hover */
.my-box:hover {
  animation-play-state: paused;
  background: grey;
  cursor: pointer;
}

@keyframes diagonal {
  from {
    top: 0;
  }

  to {
    top: calc(100% - 100px);
  }
}
</style>

<div class="my-container">
  <div class="my-box">Hover over me</div>
</div>
