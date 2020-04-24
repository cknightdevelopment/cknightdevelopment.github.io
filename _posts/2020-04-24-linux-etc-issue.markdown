---
layout: post
title:  "CoverT 40: View Distribution & Version of Linux"
date:   2020-04-24 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, Bash]
---

As I was learning how to use Docker more fully, I came across a useful little command for seeing what distribution/version of Linux a container may be using. 

`cat /etc/issue`

Running this command will print out something like this:

```
Ubuntu 18.04.4 LTS \n \l
```

It seems to be a pretty standard convention (as far as I can tell) across Linux distributions. This can be particularly helpful if you need to know what distribution/version of Linux a Docker container is running. You can execute this command against a running container by doing this:

`docker exec name_or_id_of_container cat /etc/issue`