---
layout: post
title:  "CoverT Day 9: delete vs. undefined"
date:   2020-02-10 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, JavaScript]
stackblitzUrl: https://stackblitz.com/edit/covert-delete-vs-undefined?file=index.js
---

Using the `delete` keyword on a property and setting a property to `undefined` is **NOT** the same thing! Which one should I use? As always, it depends...

Below is some code to demonstrate scenarios where using `delete` vs. `undefined` causes different side effects. Some note worthy items are:

- Setting a property to `undefined` does not _remove_ the property from the object. Using `hasOwnProperty()`, `in`, or a `for in` loop will still have it.
- Deleting a property that _overrides_ an inherited property will cause the protoype property to be used
- `delete` doesn't effect a non-overriden prototype property

### Code

```javascript
// setting property to undefined does not "remove" the property from the object
let obj = { deleteMe: 1, undefineMe: 2 };
delete obj.deleteMe
obj.undefineMe = undefined;
console.log(obj.hasOwnProperty('deleteMe')); // false
console.log('deleteMe' in obj); // false
console.log(obj.hasOwnProperty('undefineMe')); // true
console.log('undefineMe' in obj); // true

// deleting an override property, will cause the property on the prototype to be used
let extendedObj1 = Object.create({ z: 'fromPrototype' });
extendedObj1.z = 'override';
console.log(extendedObj1.z); // 'override'
extendedObj1.z = undefined;
console.log(extendedObj1.z); // undefined
delete extendedObj1.z;
console.log(extendedObj1.z); // 'fromPrototype'

// delete doesn't effect a property on the prototype
let extendedObj2 = Object.create({ z: 'fromPrototype' });
delete extendedObj2.z;
console.log(extendedObj2.z); // 'fromPrototype'
```
