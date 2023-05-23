---
layout: post
title:  "CoverT 11: Function Properties"
date:   2020-02-12 09:00:00 -0700
categories: [CoverT]
tags: [JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-function-properties?file=index.js
---

Functions are just objects in Javascript, which means that they can have properties just like any other object.

Having properties on a function can be useful if you want to make your function configurable, or if you want a static propery for your function. This can be a nice alternative to creating a class or a wrapper object to maintain properties.

#### Example

```javascript
sayHello.firstName = 'Chris';
console.log(sayHello()); // "Hello Chris"

function sayHello() {
  return `Hello ${sayHello.firstName}`;
}
```
