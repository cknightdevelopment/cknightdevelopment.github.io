---
layout: post
title:  "CoverT 15: Number Precision"
date:   2020-02-18 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-number-precision?file=index.js
---

JavaScript does not define different types of numbers (e.g. integers, long, etc.). JavaScript numbers are always stored as double precision floating point numbers, following the international IEEE 754 standard.

Integers are accurate up to 15 digits. The maximum number of decimals is 17, but floating point arithmetic will not always be 100% accurate. This can lead to some _kooky_ results, so beware!

#### Example

```javascript
console.log(.1 + .2 == .3); // false
console.log(.1 + .2); // 0.30000000000000004

console.log(9999999999999999 == 10000000000000000); // true
console.log(9999999999999999); // 10000000000000000
console.log(999999999999999); // 999999999999999
```
