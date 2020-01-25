---
layout: post
title:  "CoverT Day 5: Filling An Array"
date:   2020-01-24 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, JavaScript]
---

Filling an array with N number of values can be a little _kooky_ sometimes. Here are a few ways to do it and some things to watch out for.

Using the constructor for an `Array` has some side effects that feel strange when when you encounter them. For a great explanation, see this post titled ["Here’s Why Mapping a Constructed Array in JavaScript Doesn’t Work"](https://itnext.io/heres-why-mapping-a-constructed-array-doesn-t-work-in-javascript-f1195138615a){:target="_blank"}. Below is some example code highlighting a few details:

```javascript
const array = new Array(3);

console.log(array.length); // 3
console.log(array.map((x, i) => ++i)); // [undefined, undefined, undefined]
console.log([...array].map((x, i) => i + 1)); // [1,2,3]
console.log(array); // [undefined,undefined,undefined]

// watch out!... "fill()" mutates the array it operates on
console.log(array.fill('hello')); // ['hello','hello','hello']
console.log(array); // ['hello','hello','hello']
```
