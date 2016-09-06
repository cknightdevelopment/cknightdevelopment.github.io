---
layout: post
title:  Build Solutions and Projects With PowerShell
date:   2016-09-05 12:00:00 -0700
categories: [Miscellaneous]
tags: [PowerShell, Visual Studio]
---

As we all know Visual Studio is an amazing IDE. It’s crazy powerful, has an enormous feature set, and makes developers lives better. However, one area where using Visual Studio can sometimes be a drag is when you just want to do a quick build of your solution or project. Depending on how large your code base is and what your build steps look like, it can take up to several minutes to complete or Visual Studio may even crash on you. **This gets old really quick**, especially if the whole IDE doesn’t need to be open with all its bells and whistles to do what you are wanting to accomplish. For example, I often want to do a build after pulling from GitHub just to make sure everything is okay before pushing my local commits. Some very simple PowerShell can help us out here!

### Overview

Visual Studio's build functionality is built (pun intended) on top of `MSBuild.exe` ([see the documentation](https://msdn.microsoft.com/en-us/library/ms164311.aspx){:target="_blank"}), which it calls out to with various parameters to get it's work done. We can use this same executable in PowerShell to perform your own builds. We will create a simple PowerShell function to build a solution or project using `MSBuild.exe` and even perform NuGet package restores.

### Install NuGet CLI

Go ahead and install the NuGet CLI (command line interface). See the 'Installing' section of the [NuGet documentation](https://docs.nuget.org/consume/command-line-reference){:target="_blank"} for instructions on how to get it set up. It is really easy and there are a number of different ways to do it.

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
        $msBuildExe = 'C:\Program Files (x86)\MSBuild\14.0\Bin\msbuild.exe'

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

Pretty simple right? We declare a variable named `$msBuildExe` and set it equal to the full file path of where Visual Studio installs the `MSBuild.exe` (by default). The `buildVS` function takes three parameters:

- `path` = relative file path to a Visual Studio solution or project file
- `nuget` = restore NuGet packages (optional, default is true)
- `clean` = clean the solution/project before performing the build (optional, default is true)

But how do you call it? First, add the `buildVS` function to your PowerShell profile. If you do not already have a PowerShell profile then follow these steps:

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

When you execute the function you will see a bunch of output from `MSBuild.exe`, and if any errors are encountered they will be in red. At the end of the build step there will be a summary with any warnings or errors that occurred during the build.

I use this function throughout my work day and it makes me much more productive. I no longer need to open Visual Studio, wait for my solution to load, clean, build, etc. I just execute the `buildVS` function and I am done. 