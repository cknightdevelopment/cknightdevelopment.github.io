---
layout: post
title:  Jekyll with GitHub Pages on Windows
date:   2016-04-22 11:00:00 -0700
categories: [Jekyll]
tags: [Jekyll, GitHub]
---

### Overview

Here is some overview of how to do it.

### GitHub Setup

**1. Create the GitHub repository**

Create a new repository in GitHub with the naming pattern of `YOURGITHUBUSERNAME.github.io` (e.g. if your GitHub username is `coder123`, then you would name the repository `coder123.github.io`). _Your repository name must use this naming pattern!_

I would highly recommend creating this repository in the GitHub website. This enables you to set up some useful things right from the get go. You can set the repository as public or private, initialize the repository with a README file, add a license, and best of all add the default Jekyll `.gitignore` file. Here is an example:

![GitHub Jekyll repo creation][github-jekyll-repo-creation]

You can do this from the command line if you want to, but I think using the website is easier in this scenario.

**2. Add a Gemfile to the repository**

Create a new file named `Gemfile` (no file extension) in the `master` branch of your repository and add the following content:

```
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
```

**3. Clone your repository from GitHub to local machine**

Do this however you want (e.g. command line, GitHub for Windows, etc.)

### Local Setup

**1. Install a version of Ruby that is 2.0.0 > and <= Ruby 2.2.4**

Check to see if you already have a version of Ruby in this range installed by running `ruby -v`. If you already do then you can move on to the next step. If you do not (or if Ruby is not installed at all), install Ruby by downloading and running the [Ruby Installer](http://rubyinstaller.org/downloads/). _At the time of this writing there is an issue with some Jekyll dependencies and Ruby v2.3.0. This will be fixed in the future_. During installation make sure to select the option to 'Add Ruby exectuables to your path'. When installation has finished you will need to close and re-open your command line.

**2. Install the Ruby Development Kit**

Go to the [Ruby Installer](http://rubyinstaller.org/downloads/) page and download the Development Kit. Be sure to download the version that is for  Ruby 2.0.0 or higher and matches the bit version (32/64 bit) that you have for Ruby, and then follow these [installation instructions](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit#installation-instructions).

**3. Install Bundler**

Run `gem install bundler` from anywhere.

**4. Install Jekyll (and it's dependencies) using Bundler**

Go to the root directory of your repository (where the `Gemfile` is) and run `bundle install`. This will install Jekyll and other dependencies using the GitHub Pages gem.

**5. Generate Jekyll site  (only if you are creating a new site)**

_Only do this if you are creating a new site_. Run `bundle exec jekyll new . --force` from the root directory of your repository. This will create a Jekyll template site for you.

**6. Build and run Jekyll site locally**

Build your Jekyll site locally by running `bundle exec jekyll serve` from the root directory of your repository. Wait a few seconds and it should say something like 'Server running... press ctrl-c to stop.'. Open up a browser and go to `http://localhost:4000` to see your Jekyll site running locally. Hooray!

A nice added benefit is that Jekyll will watch for any file changes while it serves your site locally, and will automatically update the files it serves (you will still need to refresh the page). Pretty cool!

**7. _"Deploy"_ site to GitHub**

This part is easy! To _"Deploy"_ your site changes to GitHub all you have to do is make a commit to the `master` branch of your repository. GitHub takes care of the rest!

**8. See your Jekyll site hosted from GitHub**

Open a browser and go to `https://YOURGITHUBUSERNAME.github.io`

### Extra Credit


[github-jekyll-repo-creation]: /assets/images/github-create-jekyll-repo.jpg