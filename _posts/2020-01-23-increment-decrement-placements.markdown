---
layout: post
title:  "CoverT 4: Increment & Decrement Placements"
date:   2020-01-23 09:00:00 -0700
categories: [CoverT]
tags: [JavaScript]
---

The increment (`++`) and decrement (`--`) operators behave differently depending on where they are placed.

- If used postfix (after), then it increments/decrements and returns the value **BEFORE** incrementing/decrementing
- If used prefix (before), then it increments/decrements and returns the value **AFTER** incrementing/decrementing

```javascript
let i = 0;
console.log(i++); // 0
console.log(i); // 1

let k = 0;
console.log(++k); // 1
console.log(k); // 1

let m = 0;
console.log(m--); // 0
console.log(m); // -1

let w = 0;
console.log(--w); // -1
console.log(w); // -1
```
