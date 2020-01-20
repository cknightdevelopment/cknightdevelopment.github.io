---
layout: post
title:  CoverT Day 1: Numeric Separators
date:   2020-01-20 00:00:00 -0700
categories: [CoverT]
tags: [CoverT, JavaScript]
---

Numeric separators allow adding underscores to numeric literals to make them more readable.

### Numeric Separators

Looks like you can add numeric separators anywhere in a string literal except as the first character, last character, right after a negative, or next to a decimal point.

```javascript
let huh = 1000000;
let oh_i_see = 1_000_000;
let oh_i_see_with_decimals = 1_000_000.00_00;

let nope1 = _100; // Error: _100 is not defined
let nope2 = -_1; // Error: _1 is not defined
let nope3 = 100_; // Error: Numeric separators are not allowed here
let nope4 = 100_.0; // Error: Numeric separators are not allowed here
```
