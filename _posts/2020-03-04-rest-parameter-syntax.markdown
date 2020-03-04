---
layout: post
title:  "CoverT Day 26: Rest Parameter Syntax"
date:   2020-03-04 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-rest-parameter-syntax?file=index.js
---

The rest parameter syntax allows for representing an indefinite number of arguments as an array.

```javascript
function myFunc(...myArgs) {
  console.log(myArgs);
}

myFunc('a', 123, true); // ["a", 123, true]
```