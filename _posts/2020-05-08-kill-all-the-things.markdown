---
layout: post
title:  "CoverT 42: Kill All the Things"
date:   2020-05-08 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, Docker, Bash]
---

When using Docker I get pretty tired of having to remove containers, kill processes, etc. one at a time. I found an easy way to kill/remove multiple things in one command.

Let's say I want to remove all the containers that have exited. I can view them all before deleting (to be safe) by running this command:

`docker ps -f  "status=exited"`

That will output something like this :

```
CONTAINER ID        IMAGE             ...
217dfdbfd2eb        incrementor1      ...  
b1c9313087b4        incrementor2      ...
acab023c8206        incrementor3      ...
```

Looks good. These are the container I want to remove. Now I can run the same command with the `-q` option, put it inside a `$()`, and use it as the parameter for our container remove command:

`docker container rm $(docker ps -f  "status=exited" -q)`

Voila! All the exited containers are now removed! You can use whatever filters you want for the _selector_ inside your `$()`, and you can kill/remove all the things you want.