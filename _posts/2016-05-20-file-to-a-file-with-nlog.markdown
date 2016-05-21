---
layout: post
title:  Logging To A File With NLog
date:   2016-05-20 14:00:00 -0700
categories: [NLog]
tags: [NLog, .NET]
---

NLog is an [open source](https://github.com/NLog/NLog) API for .NET that has rich logging functionality, making it easy to create and manage logs for your application. We will go through the process of configuring NLog to log exceptions to a file on the local file system.

### Overview

NLog lets you to combine messages and with contextual information (e.g. date/time, severity, thread, process, environment, etc.), format them according to your preference, and send them to one or more targets. These targets can include a file (covered in this post), Event Log, database, email, etc. There are a few simple steps to have NLog begin logging to a file:

1. Install the `NLog` and `NLog.Config` package into your project via NuGet in Visual Studio
2. Add a logging target to `NLog.config` (this file is added automatically when the NuGet packages are installed)
3. Add a logger to `NLog.config` that utilizes the target you created
4. Create a new `Logger` object and use the methods it provides

### Basic Example

For our simple example we are going to configure NLog to log exceptions to a file. We could just as easily configure it to do trace logging, log warning messages, etc.

#### Install NuGet Packages

The first thing we need to do is install the `NLog` and `NLog.Config` packages into our project via NuGet. This will add the NLog library to the project references, as well as the NLog.config (and the corresponding XML schema NLog.xsd) that is used to configure NLog. 

#### Configure Target and Logger

There are tons of configuration settings available to you, all of which can be found at the [NLog project site](http://nlog-project.org/). For our example we will add configuration settings that will have NLog write to a file on the local file system. Here is the XML to make to make this happen:

_Note: this is only showing the 'targets' and 'rules' nodes of the NLog.config_

```
<targets>
	<!-- local file target -->
	<target name="fileTarget"
            xsi:type="File"
            fileName="C:\logs\example.log"
            layout="
-------------- ${level} (${longdate}) --------------${newline}
${newline}
Call Site: ${callsite}${newline}
Exception Type: ${exception:format=Type}${newline}
Exception Message: ${exception:format=Message}${newline}
Stack Trace: ${exception:format=StackTrace}${newline}
Additional Info: ${message}${newline}" />
 </targets>
<rules>
	<!-- local file logger -->
	<logger level="Error" name="fileLogger" writeTo="fileTarget"/>
</rules>
```

The target we created is named `fileTarget`, has a target type of `File`, and will write to `C:\logs\example.log` according to the layout we provided. NLog properties are indicated in the layout by the `${property_name}` syntax. Again, refer to the [NLog project site]((http://nlog-project.org/)) for specifics on these settings.

The logger we created is named `fileLogger` and it will log messages that have the logging severity level of `Error` (NLog severity levels from least to greatest are `Trace`, `Debug`, `Info`, `Warn`, `Error`, and `Fatal`). Our logger will use the `fileTarget` that we added as it's target.

#### .NET Code

All we need to do now is write some .NET code that will use our configured target and logger. Create an instance of the `Logger` object provided by the NLog API and log an exception. Here is an example:

```
try
{
    int zero = 0;
    int result = 5 / zero;
}
catch (DivideByZeroException ex)
{
    Logger logger = LogManager.GetLogger("fileLogger");
    logger.Error(ex, "Whoops!");
}
```

If all went well the exception should have been logged to the location set in the NLog.config (`C:\logs\example.log` in our example) in the format we specified. It should look something like this:

```
-------------- Error (2016-05-20 12:28:58.6636) --------------

Call Site: NLogExample.Program.Main
Exception Type: System.DivideByZeroException
Exception Message: Attempted to divide by zero.
Stack Trace:    at NLogExample.Program.Main(String[] args) in c:\Users\Chris Knight\Desktop\NLogExample\NLogExample\Program.cs:line 17
Additional Info: Whoops!
```

### Final Thoughts

* One thing that may seem strange is that if NLog itself has an exception, the logging will fail passively, you are not notified, and the unhandled exception is swallowed. This can be changed by adding the following attributes to the main `nlog` node in the NLog.config: `throwExceptions="true" internalLogLevel="Error" internalLogFile="c:\path_to_file\internal_nlog_log.txt"`
* One common mistake when using NLog is attempting to log a file to a location that the application does not have permission to write to. Be sure that the read/write permissions are set properly for where you want files to be created and written to.
* NLog has features that allow for archiving of log files based on file size and/or number of log entries. This is done on a per target basis.