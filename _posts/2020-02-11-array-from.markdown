---
layout: post
title:  "CoverT Day 10: Array.from()"
date:   2020-02-11 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-array-from?file=index.js
---

The `Array.from()` method creates a new shallow-copied Array instance from an array-like **or** iterable object.

This can be really useful when you want to convert a `Map` or `Set` to an `Array`, or as an alternative way to turn a `string` into an `Array` (e.g. instead of using something like `"MyString".split("")`)

```javascript
// array-like object
console.log(Array.from('hello')); // ["h","e","l","l","o"]

// using an optional mapper function
console.log(Array.from([1,2,3], x => x * 10)); // [10,20,30]

// iterable objects (Map & Set)
console.log(Array.from(new Set([1,2,3]))); // [1,2,3]
console.log(Array.from(new Map([[1,1.1],[2,2.2],[3,3.3]]))); // [[1,1.1],[2,2.2],[3,3.3]]
```
