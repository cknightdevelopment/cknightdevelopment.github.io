---
layout: post
title:  XML Configuration for Quartz.NET
date:   2016-08-15 01:00:00 -0700
categories: [.NET]
tags: [Quartz, .NET]
githubUrl: https://github.com/cknightdevelopment/KnightCodesExamples/tree/master/DotNet/Quartz.XmlConfiguration
youtubeId: fJlg-T6WpSM
---

Quartz.NET jobs, triggers, and schedules can be configured in several different ways. One great way to configure these items is in an XML file. Fortunately, Quartz.NET provides an XML schema definition file that can be utilized to assist us in creating an XML file to configure these items according to their specifications.

{% include alert.html 
    type="info" 
    text="This post assumes that you already have a basic working knowledge of Quartz.NET and Ninject." 
%}

### Overview

There are a just three steps to get this working:

1. Add a configuration section in the configuration file (e.g. `app.config`) to setup the scheduler, thread pool, and instruct Quartz.NET to read the job & trigger settings from an XML file 
2. Reference the XML schema file that Quartz.NET provides in Visual Studio (optional)
3. Create an XML file to hold the job & trigger configurations
4. Instantiate a Quartz.NET scheduler and start it

### Example

_The following content assumes you have a job called `ExampleJob`. Something like this will do:_

```c#
class ExampleJob : IJob
{
    public void Execute(IJobExecutionContext context)
    {
        Console.WriteLine("--> {0} - {1} - Executing the example job", 
            DateTime.Now, Thread.CurrentThread.Name);
    }
}
```

The first thing we need to do is add a section to our configuration file (e.g. `app.config`) to hold the Quartz.NET settings. Here we can tell Quartz.NET how to create our scheduler, the number of threads we want it to use, etc., and important for our purposes, that we want it to read our job & trigger settings from an XML file.

Add a `section` node to the `configSections` node of our configuration file with the following settings:

```xml
...
<configSections>
    <section name="quartz" type="System.Configuration.NameValueSectionHandler, System, Version=1.0.5000.0,Culture=neutral, PublicKeyToken=b77a5c561934e089" />
</configSections>
...
```

Once this is in place we can add the Quartz.NET settings as a child of the main `configuration` node of the configuration file:

```xml
...
<quartz>
    <add key="quartz.scheduler.instanceName" value="XmlConfiguredInstance" />
    <add key="quartz.threadPool.type" value="Quartz.Simpl.SimpleThreadPool, Quartz" />
    <add key="quartz.threadPool.threadCount" value="5" />
    <add key="quartz.threadPool.threadPriority" value="Normal" />
    <add key="quartz.plugin.xml.type" value="Quartz.Plugin.Xml.XMLSchedulingDataProcessorPlugin, Quartz" />
    <add key="quartz.plugin.xml.fileNames" value="~/quartzJobsAndTriggers.xml" />
  </quartz>
...
```

According to the settings above Quartz.NET will be looking for an XML file named `quartzJobsAndTriggers.xml` in the same directory as where the `Quartz.dll` will be put when we compile (e.g. in the `bin\Debug` folder). Create an XML file with this name and put it anywhere in the project. In the `Properties` for the file set the `Copy to Output Directory` setting to `Copy always`. This will put a copy where it needs to be when we compile:

<img id="file-properties" src="/assets/images/file-properties.png" alt="File properties" /> 

When we added Quartz.NET via NuGet it should have added a file named `job_scheduling_data_2_0.xsd` to our project. This is an XML schema file that can help us in crafting our XML file. We want to add this schema to Visual Studio's list of schemas, so that we can benefit from Intellisense. Open the `quartzJobsAndTriggers.xml` we just created and go to the `XML > Schemas...` tab. In the dialog that pops up click the `Add` button and browse to the `job_scheduling_data_2_0.xsd` in the project:

<img id="add-schema" src="/assets/images/add-schema.png" alt="Add schema" /> 

Now we can add our job & trigger settings to the XML file. There are a lot of different settings we can add, but this will suffice for adding the `ExampleJob` (mentioned earlier) and having it fire every second.

**NOTE:** The value of the `job-type` node must match our namespace and assembly name. The format is `<job-type>NamespaceOfJob.NameOfJob, NameOfAssembly</job-type>`

```xml
<?xml version="1.0" encoding="utf-8" ?>
<job-scheduling-data xmlns="http://quartznet.sourceforge.net/JobSchedulingData" version="2.0">
    <schedule>
        <job>
            <name>MyJob</name>
            <group>MyJobGroup</group>
            <description>My example job</description>
            <job-type>Quartz.XmlConfiguration.ExampleJob, Quartz.XmlConfiguration</job-type>
        </job>
        <trigger>
            <cron>
                <name>MyTrigger</name>
                <group>MyTriggerGroup</group>
                <job-name>MyJob</job-name>
                <job-group>MyJobGroup</job-group>
                <misfire-instruction>DoNothing</misfire-instruction>
                <cron-expression>0/1 * * * * ?</cron-expression>
            </cron>
        </trigger>
    </schedule>
</job-scheduling-data>
```

Lastly, we need to instantiate a scheduler and start it. The settings we put in the configuration file tell Quartz.NET to read the job & trigger settings from our XML file, so there is no need to add anything besides this:

```c#
var scheduler = new StdSchedulerFactory().GetScheduler();
scheduler.Start();
```


### Final Thoughts
* Keep in mind that this is just one basic example of using XML configuration. The XML schema allows for doing LOTS of powerful things, such as creating `IDirectoryScanner` jobs, setting misfire instructions, etc.
* Just because we have Quartz.NET reading the job & trigger settings from an XML file, that does not mean that we are restricted from adding them via code too. We can have a hybrid of both if we want.