---
layout: post
title:  "CoverT 14: Generator Basics"
date:   2020-02-17 09:00:00 -0700
categories: [CoverT]
tags: [JavaScript]
---

Generators can `yield` multiple values on-demand. They work great with iterables and allow for creating data streams with ease.

To create a generator, we need a special syntax construct: `function* funcName()`, called a _generator function_. There are a number of ways to "pull" values out of the generator function, including a `for in` loop or calling `next()` on the generator function return value.

#### Example

```javascript
function* myGenerator() {
  for (let i = 0; i < 3; i++) {
    console.log(`generator: ${i}`);
    yield i;
  }
}


let gen = myGenerator();
for (let i of gen) {
  console.log(`first for loop: ${i}`);
}
/*
generator: 0
first for loop: 0
generator: 1
first for loop: 1
generator: 2
first for loop: 2
*/


// generator results cannot be re-used, so this will print nothing
for (let i of gen) {
  console.log(`second for loop: ${i}`);
}


// alternative way to step through generator yields
let gen2 = myGenerator();
console.log(gen2.next());
console.log(gen2.next());
console.log(gen2.next());
console.log(gen2.next());
/*
generator: 0
{value: 0, done: false}
generator: 1
{value: 1, done: false}
generator: 2
{value: 2, done: false}
{value: undefined, done: true}
*/
```
