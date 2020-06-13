---
layout: post
title:  "CoverT 47: padStart() Cycle"
date:   2020-06-12 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-pointer-events?file=style.css
---

The `padStart()` function pads from the start of a string with another string, until the resulting string reaches the desired length. One fun (or possibly unexpected) result is when the string you are padding with has to start a new "cycle" in order to reach the given length.

#### Example

```javascript
console.log('999'.padStart(10, '123')); // '1231231999'
```