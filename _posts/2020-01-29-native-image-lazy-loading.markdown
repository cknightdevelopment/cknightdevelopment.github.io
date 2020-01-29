---
layout: post
title:  "CoverT Day 8: Native Image Lazy Loading"
date:   2020-01-29 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, HTML]
stackblitzUrl: https://stackblitz.com/edit/covert-native-lazy-loading?file=index.html
---

Most modern browsers are now supporting native image lazy loading via HTML via the `loading="lazy"` attribute.

This will enable browsers to not have to fetch every image for the entire page at first load, but rather just fetch images as they need to display them (e.g. scroll near to the image). For more details you can [check out the web.dev site](https://web.dev/native-lazy-loading/){:target="_blank"}. This same technique can be used for videos (and likely more stuff in the future). 

### Code

```html
<img loading='lazy' src='https://placekitten.com/400/400' width='400' height='400' />
<img loading='lazy' src='https://placekitten.com/401/401' width='401' height='401' />
<img loading='lazy' src='https://placekitten.com/402/402' width='402' height='402' />
...
```

### Example in action
<img height="450px" src="/assets/images/native-lazy-loading-example.gif" alt="native lazy loading example" /> 
