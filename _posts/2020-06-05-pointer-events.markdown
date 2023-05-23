---
layout: post
title:  "CoverT 46: pointer-events With Overrides"
date:   2020-06-05 09:00:00 -0700
categories: [CoverT]
tags: [CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-pointer-events?file=style.css
---

According to [MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/pointer-events){:target="_blank"}, the `pointer-events` CSS property sets under what circumstances (if any) a particular graphic element can become the target of pointer events. However, pointer events may target its descendant elements if those descendants have `pointer-events` set to some other value. In these circumstances, pointer events will trigger event listeners on the parent element as appropriate on their way to/from the descendant during the event capture/bubble phases.

This can be useful if you need some customization of under what conditions mouse events fire for an element.

#### Example

```html
<div class="my-container">
  <div>Nope!</div>
  <div>Override!</div>
</div>
```

```javascript
const divs = document.querySelectorAll('.my-container div');

divs.forEach(div => {
  div.addEventListener('mouseenter', function () {
    alert('mouseenter');
  });
});
```

```css
.my-container {
  pointer-events: none;
  width: 100px;
}

.my-container div {
  border: 1px solid black;
  padding: 10px;
  text-align: center;
  margin-bottom: 10px;
}

.my-container div:nth-of-type(2) {
  pointer-events: auto;
}
```

#### Result

<style>
.my-container {
  pointer-events: none;
  width: 100px;
}

.my-container div {
  border: 1px solid black;
  padding: 10px;
  text-align: center;
  margin-bottom: 10px;
}

.my-container div:nth-of-type(2) {
  pointer-events: auto;
}
</style>


<div class="my-container">
  <div>Nope!</div>
  <div>Override!</div>
</div>


<script>
const divs = document.querySelectorAll('.my-container div');

divs.forEach(div => {
  div.addEventListener('mouseenter', function () {
    alert('mouseenter');
  });
});
</script>
