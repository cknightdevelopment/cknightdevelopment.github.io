---
layout: post
title:  "CoverT 19: grid-template-areas"
date:   2020-02-24 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, CSS]
stackblitzUrl: https://stackblitz.com/edit/covert-grid-template-areas?file=style.css
---

The `grid-template-areas` property specifies named grid areas is CSS grids. These areas are not associated with any particular grid item, but can be referenced from the various grid-placement properties (e.g. `grid-area`)

#### Example

```html
<div id="grid">
 <header>header</header>
 <nav>nav</nav>
 <article>article</article>
 <aside>aside</aside>
 <footer>footer</footer>
</div>
```

```css
#grid {
  display: grid;
  height: 400px;
  grid-gap: 10px;
  grid-template-columns: 100px 1fr 100px;
  grid-template-rows: 75px 1fr 50px;
  grid-template-areas: 
    "myHeader myHeader myHeader"
    "myNav myArticle myAside"
    "myFooter myFooter myFooter";
}

#grid > * {
  border: 1px solid black;
  padding: 5px;
}

header {
  grid-area: myHeader;
}

nav {
  grid-area: myNav;
}

article {
  grid-area: myArticle;
}

aside {
  grid-area: myAside;
}

footer {
  grid-area: myFooter;
}

```

#### Result

<style>
 #grid {
  display: grid;
  height: 400px;
  grid-gap: 10px;
  grid-template-columns: 100px 1fr 100px;
  grid-template-rows: 75px 1fr 50px;
  grid-template-areas: 
    "myHeader myHeader myHeader"
    "myNav myArticle myAside"
    "myFooter myFooter myFooter";
}

#grid > * {
  border: 1px solid black;
  padding: 5px;
}

header {
  grid-area: myHeader;
}

nav {
  grid-area: myNav;
}

article {
  grid-area: myArticle;
}

aside {
  grid-area: myAside;
}

footer {
  grid-area: myFooter;
}
</style>

<div id="grid">
 <header>header</header>
 <nav>nav</nav>
 <article>article</article>
 <aside>aside</aside>
 <footer>footer</footer>
</div>
