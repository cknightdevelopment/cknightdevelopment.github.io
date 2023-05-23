---
layout: post
title:  "CoverT 32: CSS Transition Dropdown"
date:   2020-03-12 02:00:00 -0700
categories: [CoverT]
tags: [CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-css-transition-dropdown?file=style.css
---

You don't _need_ JavaScript to create a dropdown effect, you can accomplish the same thing using CSS `transition`.

{% include syntax-highlighting-warning.html %}

#### Example

```html
<ul>
  <li>
    Parent
    <ul>
      <li>Child 1</li>
      <li>Child 2</li>
      <li>Child 3</li>
    </ul>
  </li>
</ul>
```

```css
:root {
  --border-size: 3px;
}

ul {
  list-style: none;
  margin: 0;
  padding: 0;
  display: inline-block;
}

ul > li {
  display: inline-block;
  position: relative;
  width: 100px;
  text-align: center;
  padding: 5px;
  border: var(--border-size) solid;
  cursor: pointer;
}

li > ul {
  position: absolute;
  top: calc(100% + var(--border-size));
  left: calc(var(--border-size) * -1);
  transform: scale(1,0);
  transform-origin: top;
  transition: all ease-in 200ms 50ms;
}

li:hover > ul {
  transform: scale(1,1);
}

ul > li li {
  border-top: none;
}
```

#### Result

<style>
.my-container {
  height: 200px;
}

:root {
  --border-size: 3px;
}

.my-container ul {
  list-style: none;
  margin: 0;
  padding: 0;
  display: inline-block;
}

.my-container ul > li {
  display: inline-block;
  position: relative;
  width: 100px;
  text-align: center;
  padding: 5px;
  border: var(--border-size) solid;
  cursor: pointer;
}

.my-container li > ul {
  position: absolute;
  top: calc(100% + var(--border-size));
  left: calc(var(--border-size) * -1);
  transform: scale(1,0);
  transform-origin: top;
  transition: all ease-in 200ms 50ms;
}

.my-container li:hover > ul {
  transform: scale(1,1);
}

.my-container ul > li li {
  border-top: none;
}

</style>

<div class="my-container">
  <ul>
    <li>
      Parent
      <ul>
        <li>Child 1</li>
        <li>Child 2</li>
        <li>Child 3</li>
      </ul>
    </li>
  </ul>
</div>