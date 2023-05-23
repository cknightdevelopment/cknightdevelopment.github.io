---
layout: post
title:  "CoverT 12: Tagged Template Literals"
date:   2020-02-13 09:00:00 -0700
categories: [CoverT]
tags: [JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-tagged-template-literals?file=index.js
---

Tagged template literals allow you to have more control over parsing the template literals to a string, by adding a custom tag to the template literals. 

Tags allow you to parse template literals with a function. The first argument of a tag function contains an array of string values. The remaining arguments are related to the expressions.

#### Example

```javascript
const book = 'Harry Potter';
const author = 'J.K. Rowling';

const value = myTag`${book} by ${author}`;
console.log(value); // "[[Harry Potter]] by [[J.K. Rowling]]"

function myTag(strings, ...data) {
  let result = '';

  strings.forEach((val, i) => {
    result += val;
    if (data[i]) {
      result += '[[' + data[i] + ']]';
    }
  });

  return result;
}

```
