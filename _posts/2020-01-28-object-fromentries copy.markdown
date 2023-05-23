---
layout: post
title:  "CoverT 7: Object.fromEntries()"
date:   2020-01-28 09:00:00 -0700
categories: [CoverT]
tags: [JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-fromentries?file=index.js
---

The `Object.fromEntries()` method transforms a list of key-value pairs into an object. A common use case would be creating an object from a manipulated result of `Object.entries()`.

This allows you to work with an object's properties & values using the various array functions (e.g. `map()`, `filter()`, etc.)


```javascript
const myObj = { ap: 123, sam: 321, z: 999 };
const entries = Object.entries(myObj);

console.log(entries); // [['ap',123],['sam',321],['z',999]]
console.log(Object.fromEntries(entries)); // {ap: 123, sam: 321, z: 999}
console.log(
  Object.fromEntries(entries
    .filter(x => !x[0].startsWith('z'))
    .map(x => [`${x[0]}ple`, x[1]]))
); // {apple: 123, sample: 321}

```
