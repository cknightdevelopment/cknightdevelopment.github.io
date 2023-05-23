---
layout: post
title:  "CoverT 48: Object Rest Destructuring"
date:   2020-06-19 09:00:00 -0700
categories: [CoverT]
tags: [JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-object-rest?file=index.js
---

Object destructuing is great! Found a clean way to _pick_ some specific properties from an object, and then assign the rest of the properties to another object.

```javascript
const myObj = { a: 1, b: 2, c:3, d: 4 };
const {
  a: first,
  c: third,
  ...theRest
} = myObj;

console.log(first); // 1
console.log(third); // 3
console.log(theRest); // { b: 2, d: 4 }
```