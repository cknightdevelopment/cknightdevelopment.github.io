---
layout: post
title:  "CoverT 2: Shift & Unshift"
date:   2020-01-21 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, JavaScript]
---

`shift()` & `unshift()` let you do stuff to arrays starting at the beginning.

Here is a little more detail:

- `shift()`: Removes an item from the beginning of an array and returns the array item that was removed.
- `unshift()`: Adds items to the beginning of an array and returns the new length of the array.

```javascript
let myArray = [1,2,3];
console.log(myArray.shift()); // 1
console.log(myArray); // [2, 3]

myArray = [1,2,3];
console.log(myArray.unshift(-2, -1, 0)); // 6
console.log(myArray); // [-2, -1, 0, 1, 2, 3]
```
