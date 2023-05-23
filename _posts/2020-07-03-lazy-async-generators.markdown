---
layout: post
title:  "CoverT 50: Lazy Async Generators"
date:   2020-07-03 09:00:00 -0700
categories: [CoverT]
tags: [JavaScript]
---

Aysnc generators were recently added to JavaScript. They can allow for cool things like lazy async looping.


#### Example

```javascript
const obj = {
  numbers: [1,2,3],
  getSquare(val) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        console.log(`After one second timeout for ${val}`)
        resolve(val * val);
      }, 1000);
      console.log(`Inside promise for ${val}`);
    });
  },
  async *[Symbol.asyncIterator]() {
    for (const num of this.numbers) {
      const result = await this.getSquare(num);
      console.log(`Promise resolved for ${num}, result is ${result}`);
      yield result;
    }
  }
};

(async function() {
  for await (let result of obj) {
    console.log(result);
  }
})();

/*
Inside promise for 1
After one second timeout for 1
Promise resolved for 1, result is 1
1
Inside promise for 2
After one second timeout for 2
Promise resolved for 2, result is 4
4
Inside promise for 3
After one second timeout for 3
Promise resolved for 3, result is 9
9
*/
```
