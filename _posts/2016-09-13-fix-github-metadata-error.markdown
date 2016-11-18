---
layout: post
title:  Jekyll with GitHub Pages - Fix the "GitHub Metadata No GitHub API authentication could be found" Error
date:   2016-09-13 12:00:00 -0700
categories: [Miscellaneous]
tags: [Jekyll, GitHub Pages]
githubUrl: 
youtubeId: 1bQqkyvH5ps
---

Jekyll with GitHub pages is an awesome way to build a developer blog or project site ([find out how](http://knightcodes.com/miscellaneous/2016/04/25/jekyll-on-windows.html){:target="_blank"}). However, one day after updating my local environment with the latest GitHub Pages gems ([as GitHub tells us to do](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/#keeping-your-site-up-to-date-with-the-github-pages-gem){:target="_blank"}), I started to get errors about GitHub Metadata and GitHub API authentication anytime I made edits while serving the site locally. WTF?!?! This post will tell you how to fix it.

### Overview

Here is the full error that I was getting in the console:

```
Regenerating: 1 file(s) changed at 2016-09-13 13:10:58    GitHub Metadata: No GitHub API authentication could be found. Some fields may be missing or have incorrect data.
...error:
    Error: SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed
    Error: Run jekyll build --trace for more information.
```

Initially the site would generate and be served successfully, but if I made any edits I would get the error in my terminal and my edits wouldn't be served. This means every time I made a change and wanted to see what it looked like, I would have to terminate the Jekyll process and have it regenerate the site all over again. So annoying!

### Fix It!

Alas, after much searching I found a fix. Just follow these steps:

1. Create a personal access token in GitHub. This takes just a second, see [GitHub's documentation](https://help.github.com/articles/creating-an-access-token-for-command-line-use/){:target="_blank"}. When picking the scope(s) that you want to grant to the token, just select the `repo` checkbox.
2. Add a new system environment variable on your machine named `JEKYLL_GITHUB_TOKEN` and set the value equal to the personal access token you generated.
3. [Go here](https://curl.haxx.se/ca/cacert.pem){:target="_blank"}, copy all the text in the page, and save it as a file named `cacert.pem` somewhere on your local machine.
4. Add a new system environment variable on your machine  named `SSL_CERT_FILE` and set the value equal to the full file path of where you saved the `cacert.pem` file.
5. **RESTART YOUR MACHINE** (this is **not** optional)

Once your machine has restarted the error should not happen anymore and you'll be on your merry way to making edits while the Jekyll site is being served.