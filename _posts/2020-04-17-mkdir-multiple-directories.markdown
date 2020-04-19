---
layout: post
title:  "CoverT 39: mkdir multiple directories"
date:   2020-04-17 09:00:00 -0700
categories: [CoverT]
tags: [CoverT, Bash]
---

Learned something cool with regards to creating multiple directories with bash. There a million different options you can use to do different things, but I learned that if you run this command:

`mkdir lib{,64}`

It will create two directories; one named `lib` and one named `lib64`. Neato!