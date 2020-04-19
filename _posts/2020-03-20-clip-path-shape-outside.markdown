---
layout: post
title:  "CoverT 38: clip-path & shape-outside Magic"
date:   2020-03-20 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-clip-path-shape-outside?file=style.css
---

With the combination of the `clip-path` & `shape-outside` properties, you can clip an element and have other elements shape themselves appropriately around that element.

#### Example

```html
<div class="my-container">
	<div class="my-box"></div>
  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
</div>
```

```css
.my-box {
  height: 150px;
  width: 150px;
  float: left;
  background: orange;
  margin-right: 10px;

  /* check out https://bennettfeely.com/clippy/ */
  clip-path: ellipse(75% 75% at 0% 0%);
  shape-outside: ellipse(75% 75% at 0% 0%);
}
```

#### Result

<style>
.my-box {
  height: 150px;
  width: 150px;
  float: left;
  background: orange;
  margin-right: 10px;

  /* check out https://bennettfeely.com/clippy/ */
  clip-path: ellipse(75% 75% at 0% 0%);
  shape-outside: ellipse(75% 75% at 0% 0%);
}
</style>

<div class="my-container">
	<div class="my-box"></div>
  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
</div>
