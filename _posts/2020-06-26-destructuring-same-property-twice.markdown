---
layout: post
title:  "CoverT 49: Destructuring the Same Property Multiple Times"
date:   2020-06-26 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-destructure-same-property-twice?file=index.js
---

When performing object destructuring you can destructure the same property multiple times. This can be really useful if you want to snag a full object and then snag individual properties too.

```javascript
function getData() {
  return {
    name: 'Chris',
    job: {
      position: 'Developer',
      company: 'Acme Inc'
    }
  };
}

const {
  name: a,
  job: b,
  job: {
    position: c,
    company: d
  }
} = getData();

console.log(a); // 'Chris'
console.log(b); // { position: 'Developer', company: 'Acme Inc' }
console.log(c); // 'Developer'
console.log(d); // 'Acme Inc'
```