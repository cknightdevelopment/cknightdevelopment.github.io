---
layout: post
title:  "CoverT Day 31: Different Transition Each Direction"
date:   2020-03-11 02:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-transform-origin?file=style.css
---

The `transition` property can be set for selectors in such a way that the visual effect is different when the _active_ selector is switched.

It feels like a different effect is happening when switching _directions_.

#### Example

```html
<div class="my-box">
  Hover over me!
</div>
```

```css
.my-box {
  font-size: 15px;
  border: 5px solid;
  text-align: center;
  transition: 
    all /* property */
    ease-in /* timing function */
    1s /* duration */
    50ms /* delay */;
}

.my-box:hover {
  font-size: 20px;
  color: green;
  border-color: red;
  padding: 20px;

  transition: 
    all /* property */
    steps(5, end) /* timing function */
    2s /* duration */
    50ms /* delay */;
}
```

#### Result

<style>
.my-box {
  font-size: 15px;
  border: 5px solid;
  text-align: center;
  transition: 
    all /* property */
    ease-in /* timing function */
    1s /* duration */
    50ms /* delay */;
}

.my-box:hover {
  font-size: 20px;
  color: green;
  border-color: red;
  padding: 20px;

  transition: 
    all /* property */
    steps(5, end) /* timing function */
    2s /* duration */
    50ms /* delay */;
}
</style>

<div class="my-box">
  Hover over me!
</div>