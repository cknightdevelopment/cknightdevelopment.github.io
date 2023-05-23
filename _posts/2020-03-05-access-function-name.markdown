---
layout: post
title:  "CoverT 27: Accessing a Function's Name"
date:   2020-03-05 09:00:00 -0700
categories: [CoverT]
tags: [JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-access-function-name?file=index.js
---

A `function` object's read-only `name` property indicates the `function`'s name as specified when it was created. If the function is anonymous it will be `''`.

```javascript
function myFunc1() {}
const myFunc2 = () => {};
const myFunc3 = function () {};
function receivesFunc(argFunc) {
  return argFunc.name;
}

console.log(myFunc1.name); // "myFunc1"
console.log(myFunc2.name); // "myFunc2"
console.log(myFunc3.name); // "myFunc3"
console.log(receivesFunc(myFunc1)) // "myFunc1"
console.log(receivesFunc(function myArgFunc() {})); // "myArgFunc"
console.log(receivesFunc(function () {})); // ""
console.log(receivesFunc(() => {})); // ""
```