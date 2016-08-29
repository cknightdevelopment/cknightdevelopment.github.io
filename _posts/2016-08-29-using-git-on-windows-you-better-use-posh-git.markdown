---
layout: post
title:  Using Git On Windows? You Better Use posh-git!
date:   2016-08-29 01:00:00 -0700
categories: [posh-git]
tags: [PowerShell, posh-git, .NET]
githubUrl: 
youtubeId: PNNinzeFv-4
---

Now-a-days Windows developers increasingly need to get their hands dirty using the terminal (gasp!). Whether we're executing some weird JavaScript build, spinning up a server in the cloud, calling npm, etc., the command line is becoming a more prominent part of our daily development lives. What are we to do when we are so used to the "Visual Studio-lization" of everything from our coding editing, to our source control, to our builds, etc.. Never fear! Behind all those fancy GUIs are a rich and powerful set of CLIs that are really not all that scary, and can actually make our development process _faster_. One area that you may, dare I say it, become a lover of the terminal is with source control. This is particularly true if you are using Git. Introducing [posh-git](https://github.com/dahlbyk/posh-git){:target="_blank"}!

### Overview

Posh-git is not a new kind of terminal or some extra application we need to worry about running, but rather an enhancement to the existing PowerShell experience when interacting with a Git respository. Think of it as how `TypeScript` relates to `JavaScript`; its a super-set. According to the posh-git documentation it is simply:

> A set of PowerShell scripts which provide Git/PowerShell integration

That is quite modest! Here are a few BIG wins that it gives us:

- Super easy "installation" and configuration (it just works)
- Useful information concerning the state of your Git branch, files, upstream and downstream changes, etc.
- Tab completion for common Git commands

The best way to appreciate it's benefits is to just set it up and start using it, so let's go!

### Installation & Setup

To "install" posh-git simply clone the respository from GitHub:

```
git clone https://github.com/dahlbyk/posh-git.git
```

It is now on our machine, TA-DA! Now we just need our PowerShell profile to load it when we start a PowerShell terminal, which could not be easier. Simply `cd` into the directory where we cloned posh-git and run `.\install.ps1`. This script will add a call to our PowerShell profile to load posh-git (it will create a profile for you if one does not already exist). 

One thing I had to do was comment out a line from posh-git's example profile that tries to start an ssh agent. I am not exactly sure what this is used for, but it was causing errors for me and commenting it out didn't effect the functionality at all. Simply comment out the last line of the `profile.example.ps1` file by pre-pending it with a `#` (this file is located where we cloned posh-git):

```powershell
... the rest of the file ...

#Start-SshAgent -Quiet
``` 

You will need to run `. $PROFILE` in PowerShell (or just close and re-open the PowerShell terminal) to have the changes take effect.

_NOTE: posh-git will now be loaded whenever you open a PowerShell terminal, so you're all set up for the future._

### Using posh-git

I didn't feel like typing all this out and adding a bunch of screenshots, so... just watch the video at the top. It provides a nice overview of the functionality and compares the PowerShell/Git developer experience before and after using posh-git. 