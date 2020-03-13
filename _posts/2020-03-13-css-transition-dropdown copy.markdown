---
layout: post
title:  "CoverT Day 33: Infinite Animation"
date:   2020-03-13 02:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-animation-infinite?file=style.css
---

There are a ton of things you can do with CSS animations. If you need something to _run_ infinitely, it allows for that easily.

#### Example

```html
<div class="my-container">
  <div class="my-box"></div>
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
  width: 50px;
  height: 50px;
  animation: diagonal infinite 3s alternate linear;
}

@keyframes diagonal {
  0% {
    top: 0;
    left: 0;
  }

  100% {
    top: calc(100% - 50px);
    left: calc(100% - 50px);
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
  width: 50px;
  height: 50px;
  animation: diagonal infinite 3s alternate linear;
}

@keyframes diagonal {
  0% {
    top: 0;
    left: 0;
  }

  100% {
    top: calc(100% - 50px);
    left: calc(100% - 50px);
  }
}
</style>

<div class="my-container">
  <div class="my-box"></div>
</div>
