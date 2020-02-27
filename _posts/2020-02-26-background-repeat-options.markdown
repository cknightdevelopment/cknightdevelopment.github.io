---
layout: post
title:  "CoverT Day 21: background-repeat Options"
date:   2020-02-26 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-background-repeat?file=style.css
---

The `background-repeat` property sets how background images are repeated. There are several options, each offering a slightly different result.

Here are a few useful options according to [Mozilla...](https://developer.mozilla.org/en-US/docs/Web/CSS/background-repeat){:target="_blank"}

- `repeat`: The image is repeated as much as needed to cover the whole background image painting area. **The last image will be clipped if it doesn't fit.**
- `no-repeat`: The image is **not repeated**
- `space`: The image is repeated as much as possible **without clipping**. The first and last images are pinned to either side of the element, and **whitespace is distributed evenly between the images.**
- `round`: As the allowed space increases in size, **the repeated images will stretch (leaving no gaps) until there is room for another one to be added. When the next image is added, all of the current ones compress to allow room.**

### Code

```html
<h3>Repeat (default)</h3>
<div class="my-container"></div>

<h3>No Repeat</h3>
<div class="my-container no-repeat"></div>

<h3>Space</h3>
<div class="my-container space"></div>

<h3>Round</h3>
<div class="my-container round"></div>
```

```css
.my-container {
  height: 300px;
  width: 300px;
  border: 1px solid black;
  background-image: url('dot.png');
  background-color: grey;
}

.no-repeat {
  background-repeat: no-repeat;
}

.space {
  background-repeat: space;
}

.round {
  background-repeat: round;
}
```

### Results

<style>
.my-container {
  height: 300px;
  width: 300px;
  border: 1px solid black;
  background-image: url('/assets/images/dot.png');
  background-color: grey;
}

.no-repeat {
  background-repeat: no-repeat;
}

.space {
  background-repeat: space;
}

.round {
  background-repeat: round;
}
</style>

#### Repeat (default)
<div class="my-container"></div>

#### No Repeat
<div class="my-container no-repeat"></div>

#### Space
<div class="my-container space"></div>

#### Round
<div class="my-container round"></div>