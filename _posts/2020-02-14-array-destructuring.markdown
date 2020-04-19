---
layout: post
title:  "CoverT 13: Array Destructuring"
date:   2020-02-14 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-array-destructuring?file=index.js
---

The destructuring assignment syntax is an expression that makes it possible to unpack values from arrays into distinct variables.

There are a number of useful alterations you can make to the left-hand expression to grab the data in the way you need it (e.g. default values, skip array items, get remaining items, etc.)

#### Example

```javascript
const myArray = [1,2,3];

const [a,b,c,d,e=99] = myArray;
console.log(a); // 1
console.log(b); // 2
console.log(c); // 3
console.log(d); // undefined
console.log(e); // 99

// assigning the rest of an array to a variable
const [h,...i] = myArray;
console.log(h); // 1
console.log(i); // [2,3]

// ignoring some returned values
const [f,,g] = myArray;
console.log(f); // 1
console.log(g); // 3

// swap variables, without destructuring assignment this requires a temporary variable
let y = 1;
let z = 3;
[y, z] = [z, y];
console.log(y); // 3
console.log(z); // 1
```
