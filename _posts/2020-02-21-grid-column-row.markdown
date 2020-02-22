---
layout: post
title:  "CoverT Day 18: grid-column & grid-row"
date:   2020-02-21 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-grid-row-column?file=style.css
---

`grid-row` and `grid-column` properties are shorthand properties for specifying a grid item's size and location within a grid by specifying the inline-start and inline-end edge of its grid area.

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
  <span>13</span>
  <span>14</span>
  <span>15</span>
</div>
```

```css
#grid {
  display: grid;
  grid-template-columns: repeat(4, 50px);
}

#grid span {
  border: 1px solid black;
  padding: 5px;
  text-align: center;
}

#grid span:nth-of-type(3) {
  grid-column: 2 / 4;
  grid-row: 2 / 5;
  background: pink;
}
```

#### Result

<style>
  #grid {
  display: grid;
  grid-template-columns: repeat(4, 50px);
    }

    #grid span {
      border: 1px solid black;
      padding: 5px;
      text-align: center;
    }

    #grid span:nth-of-type(3) {
      grid-column: 2 / 4;
      grid-row: 2 / 5;
      background: pink;
    }
</style>

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
  <span>13</span>
  <span>14</span>
  <span>15</span>
</div>
