---
layout: post
title:  "CoverT 44: Look Like a Hacker From a Hollywood Movie"
date:   2020-05-22 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, Docker]
---

If you have ever seen a movie with hackers in it, their computer screens always seem really busy computing _stuff_. My screen never looks this way in the real world, but I thought it'd be fun to try and impress my fellow patrons at the coffee shop.

There is a [Docker image available on Docker Hub called "bcbcarl/hollywood"](https://hub.docker.com/r/bcbcarl/hollywood) that allows you to turn your terminal into a Hollywood style real time hacking scene. It is very simple to get running. First, just pull the Docker image using this command:

`docker pull bcbcarl/hollywood`

Once installed, run the image by executing this command:

`docker run --rm -it bcbcarl/hollywood`

Your terminal will now look like a Hollywood hacking scene! (don't worry, its not actually doing anything computational, it just looks like it is).

<img height="325px" src="/assets/images/hollywood-hacker.png" alt="hollywood hacker terminal screen" /> 