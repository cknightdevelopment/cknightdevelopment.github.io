---
layout: post
title:  "CoverT 16: Grid Template Columns and Rows"
date:   2020-02-19 09:00:00 -0700
categories: [CoverT]
tags: [CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-grid-template-row-column?file=style.css
---

`grid-template-columns` and `grid-template-rows` are awesome CSS properties for defining the size & number of grid columns and rows.

They can take a ton of different values (e.g. length, percentage, fr, repeat, minmax, etc.), and make it really easy to control the width and height of your grid columns and rows.

#### Example

```html
<div id="grid">
  <span>1</span>
  <span>2</span>
  <span>3</span>
  <span>4</span>
  <span>5</span>
  <span>6</span>
  <span>7</span>
  <span>8</span>
  <span>9</span>
  <span>10</span>
  <span>11</span>
  <span>12</span>
</div>
```

```css
#grid {
  display: grid;
  grid-template-columns: 150px repeat(2, 50px) 300px;
  grid-template-rows: 40px repeat(2, 100px);
}

#grid span {
  border: 1px solid black;
  padding: 5px;
  text-align: center;
}
```

<style>
#grid {
  display: grid;
  grid-template-columns: 150px repeat(2, 50px) 300px;
  grid-template-rows: 40px repeat(2, 100px);
}

#grid span {
  border: 1px solid black;
  padding: 5px;
  text-align: center;
}
</style>

#### Result

<div id="grid">
  <span>1</span>
  <span>2</span>
  <span>3</span>
  <span>4</span>
  <span>5</span>
  <span>6</span>
  <span>7</span>
  <span>8</span>
  <span>9</span>
  <span>10</span>
  <span>11</span>
  <span>12</span>
</div>
