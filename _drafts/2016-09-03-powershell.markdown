---
layout: post
title:  Build Visual Studio Solutions and Projects With PowerShell
date:   2016-09-03 12:00:00 -0700
categories: [Miscellaneous]
tags: [PowerShell]
---

As we all know Visual Studio is an amazing IDE. It’s crazy powerful, has an enormous feature set, and makes developers lives better. However, one area where using Visual Studio can sometimes be a drag is when you just want to do a quick build of your solution or project. Depending on how large your code base is and what your build steps look like, it can take up to several minutes to complete or Visual Studio may even crash on you. **This gets old really quick**, especially if the whole IDE doesn’t need to be open with all its bells and whistles to do what you are wanting to accomplish. For example, I often want to do a build after pulling from GitHub just to make sure everything is okay before pushing my local commits. Some very simple PowerShell can help us out here!

### Overview

Visual Studio's build functionality is built (pun intended) on top of `MSBuild.exe` ([see the documentation](https://msdn.microsoft.com/en-us/library/ms164311.aspx)), which it calls out to with various parameters to get it's work done. This same executable is added to your system file path when Visual Studio is installed, so you can make use it in PowerShell to perform your own builds. We can create a simple PowerShell function to build a solution or project using `MSBuild.exe` and even perform NuGet package restores.

### Install NuGet CLI

Go ahead and install the NuGet CLI (command line interface). See the 'Installing' section of the [NuGet documentation](https://docs.nuget.org/consume/command-line-reference) for instructions on how to get it set up. It is really easy and there are a number of different ways to do it.

### Setup & Understand the PowerShell Function

Now let's grab a look at the PowerShell function:

```powershell
function buildVS
{
    param
    (
        [parameter(Mandatory=$true)]
        [String] $path,

        [parameter(Mandatory=$false)]
        [bool] $nuget = $true,
        
        [parameter(Mandatory=$false)]
        [bool] $clean = $true
    )
    process
    {
        if ($nuget) {
            Write-Host "Restoring NuGet packages" -foregroundcolor green
            nuget restore "$($path)"
        }

        if ($clean) {
            Write-Host "Cleaning $($path)" -foregroundcolor green
            & "$($msBuildExe)" "$($path)" /t:Clean /m
        }

        Write-Host "Building $($path)" -foregroundcolor green
        & "$($msBuildExe)" "$($path)" /t:Build /m
    }
}
``` 

Pretty simple right? You provide `buildVS` with a file path to a Visual Studio solution or project file, and optionally tell it to restore the NuGet packages and/or clean the solution/project before performing the build (both are `true` by default). But how do you use it? Easy! Just add it to your PowerShell profile. 

If you do not already have a PowerShell profile follow these steps:

1. Open a PowerShell console
2. Run `$PROFILE`
3. Create the file echoed back by the `$PROFILE` command
4. Paste the `buildVS` function (above) into this new file
5. Run `. $PROFILE` to load the profile (or just close and re-open the PowerShell console)

### Use the PowerShell Function

Now you should be able to use the function in your PowerShell console from anywhere. Here are a few examples of calling the function:

```powershell
# nuget restore, clean solution, and build solution
buildVS .\path\to\solution.sln

# clean solution and build solution
buildVS .\path\to\solution.sln $false $true

# build solution
buildVS -path .\path\to\solution.sln -nuget $false -clean $false

# nuget restore and build solution
buildVS -path .\path\to\solution.sln -clean $false

# etc.
```

When you run the function you will see a bunch of output from `MSBuild.exe`, and if any errors are encountered they will be in red. At the end of the build step there will be a summary with any warnings or errors that occurred during the build.

I use this function throughout my work day and it makes me much more productive. I no longer need to open Visual Studio, wait for my solution to load, clean, build, etc. I just execute the `buildVS` function and I am done. 