---
layout: post
title:  "CoverT 45: Fun With console"
date:   2020-05-29 09:00:00 -0700
categories: [CoverT]
tags: [JavaScript]
---

I recently learned that the JavaScript console has some pretty neat features that I wasn't aware of. I found [this video](https://www.youtube.com/watch?v=L8CDt1J3DAw){:target="_blank"} to be really helpful. Among the top of the list are `assert`, `table`, `group`, and `"%c"` for custom styling.

Copy this code and execute it in your browser's console:

```javascript
// assert
console.assert(true, 'will not show');
console.assert(false, 'will show as error in console');

// table
console.table({ name: 'John', age: 20 });
console.table([{ name: 'John', age: 20 }, { name: 'Sue', age: 22 }]);

// group
console.group('My Open Group');
console.log('a');
console.log('b');
console.log('c');
console.groupEnd();

console.groupCollapsed('My Collapsed Group');
console.log('d');
console.log('e');
console.log('f');
console.groupEnd();

// "%c" for custom styling
console.log('%cHere is my text', 'background-color: purple;color:yellow;text-transform:uppercase;padding: 5px;');
```

It will look something like this:

<img height="325px" src="/assets/images/fun-with-console.png" alt="hollywood hacker terminal screen" /> 