---
layout: post
title:  Quartz.NET Listeners For Calendars, Triggers, and Jobs
date:   2016-08-18 01:00:00 -0700
categories: [.NET]
tags: [Quartz, .NET]
githubUrl: https://github.com/cknightdevelopment/KnightCodesExamples/tree/master/DotNet/Quartz.Listeners
youtubeId: gVh8vjDIhUY
---

One thing that can be really powerful when using Quartz.NET is executing some code whenever a particuar action takes place (think events). Quartz.NET has the concept of `listeners` to do just this! There are three types of listeners available: job listeners, trigger listeners, and scheduler listeners. These listeners can be used in many different scenarios such as logging, debugging issues, raising notifications, etc.

{% include alert.html 
    type="info" 
    text="This post assumes that you already have a basic working knowledge of Quartz.NET and Ninject." 
%}

### Overview

The goal of this post is to demonstrate how to create and wire up listeners to respond to Quartz.NET events. These are the steps we will take:

1. Create a scheduler listener
2. Create a trigger listener
3. Create a job listener
4. Add listeners to a scheduler

### Example

Creating listeners in Quartz.NET is very simple. All we need to do is inherit from the interface that Quartz.NET provides for the type of listener we want to create; `IJobListener`, `ITriggerListener`, or `ISchedulerListener`. Each of these interfaces contain method signatures named according to the type of event they listen for. We can implement these methods to execute some code whenever these events fire. The method names on the interfaces are pretty self explanatory, so I will not bother going over them. Here is an example where I am simply writing to the console:

#### Scheduler Listener

```c#
public void JobScheduled(ITrigger trigger)
{
    Console.WriteLine("{0} -- {1} -- JobScheduled() was called", Name, DateTime.Now);
}
 
public void JobUnscheduled(TriggerKey triggerKey)
{
    Console.WriteLine("{0} -- {1} -- JobUnscheduled() was called", Name, DateTime.Now);
}
 
public void TriggerFinalized(ITrigger trigger)
{
    Console.WriteLine("{0} -- {1} -- TriggerFinalized() was called", Name, DateTime.Now);
}
 
public void TriggerPaused(TriggerKey triggerKey)
{
    Console.WriteLine("{0} -- {1} -- TriggerPaused() was called", Name, DateTime.Now);
}
 
public void TriggersPaused(string triggerGroup)
{
    Console.WriteLine("{0} -- {1} -- TriggersPaused() was called", Name, DateTime.Now);
}
 
public void TriggerResumed(TriggerKey triggerKey)
{
    Console.WriteLine("{0} -- {1} -- TriggerResumed() was called", Name, DateTime.Now);
}
 
public void TriggersResumed(string triggerGroup)
{
    Console.WriteLine("{0} -- {1} -- TriggersResumed() was called", Name, DateTime.Now);
}
 
public void JobAdded(IJobDetail jobDetail)
{
    Console.WriteLine("{0} -- {1} -- JobAdded() was called", Name, DateTime.Now);
}
 
public void JobDeleted(JobKey jobKey)
{
    Console.WriteLine("{0} -- {1} -- JobDeleted() was called", Name, DateTime.Now);
}
 
public void JobPaused(JobKey jobKey)
{
    Console.WriteLine("{0} -- {1} -- JobPaused() was called", Name, DateTime.Now);
}
 
public void JobsPaused(string jobGroup)
{
    Console.WriteLine("{0} -- {1} -- JobsPaused() was called", Name, DateTime.Now);
}
 
public void JobResumed(JobKey jobKey)
{
    Console.WriteLine("{0} -- {1} -- JobResumed() was called", Name, DateTime.Now);
}
 
public void JobsResumed(string jobGroup)
{
    Console.WriteLine("{0} -- {1} -- JobsResumed() was called", Name, DateTime.Now);
}
 
public void SchedulerError(string msg, SchedulerException cause)
{
    Console.WriteLine("{0} -- {1} -- SchedulerError() was called", Name, DateTime.Now);
}
 
public void SchedulerInStandbyMode()
{
    Console.WriteLine("{0} -- {1} -- SchedulerInStandbyMode() was called", Name, DateTime.Now);
}
 
public void SchedulerStarted()
{
    Console.WriteLine("{0} -- {1} -- SchedulerStarted() was called", Name, DateTime.Now);
}
 
public void SchedulerStarting()
{
    Console.WriteLine("{0} -- {1} -- SchedulerStarting() was called", Name, DateTime.Now);
}
 
public void SchedulerShutdown()
{
    Console.WriteLine("{0} -- {1} -- SchedulerShutdown() was called", Name, DateTime.Now);
}
 
public void SchedulerShuttingdown()
{
    Console.WriteLine("{0} -- {1} -- SchedulerShuttingdown() was called", Name, DateTime.Now);
}
 
public void SchedulingDataCleared()
{
    Console.WriteLine("{0} -- {1} -- SchedulingDataCleared() was called", Name, DateTime.Now);
}
 
public string Name { get { return "SchedulerListener"; } }
```

#### Job Listener

```c#
class GlobalJobListener : IJobListener
{
    public void JobToBeExecuted(IJobExecutionContext context)
    {
        Console.WriteLine("{0} -- {1} -- Job ({2}) is about to be executed", Name, DateTime.Now, context.JobDetail.Key);
    }
 
    public void JobWasExecuted(IJobExecutionContext context, JobExecutionException jobException)
    {
        Console.WriteLine("{0} -- {1} -- Job ({2}) was executed", Name, DateTime.Now, context.JobDetail.Key);
    }
 
    public void JobExecutionVetoed(IJobExecutionContext context)
    {
        Console.WriteLine("{0} -- {1} -- Job ({2}) was vetoed", Name, DateTime.Now, context.JobDetail.Key);
    }
 
    public string Name { get { return "GlobalJobListener"; } }
}
```

#### Trigger Listener

```c#
class GlobalTriggerListener : ITriggerListener
{
    public void TriggerFired(ITrigger trigger, IJobExecutionContext context)
    {
        Console.WriteLine("{0} -- {1} -- Trigger ({2}) was fired", Name, DateTime.Now, trigger.Key);
    }
 
    /*
     * NOTE: the return of this method determines if the job execution should be vetoed or not, so be sure to
     * return true unless you really want to veto the job. Here we have dummy code just to make it random.
     */
    public bool VetoJobExecution(ITrigger trigger, IJobExecutionContext context)
    {
        var doVeto = new Random().Next(1, 10) > 5;
        if (doVeto)
        {
            Console.WriteLine("{0} -- {1} -- Trigger ({2}) is going to veto the job ({3})", Name, DateTime.Now, trigger.Key, context.JobDetail.Key);
        }
        return doVeto;
    }
 
    public void TriggerMisfired(ITrigger trigger)
    {
        Console.WriteLine("{0} -- {1} -- Trigger ({2}) was misfired", Name, DateTime.Now, trigger.Key);
    }
 
    public void TriggerComplete(ITrigger trigger, IJobExecutionContext context, SchedulerInstruction triggerInstructionCode)
    {
        Console.WriteLine("{0} -- {1} -- Trigger ({2}) completed", Name, DateTime.Now, trigger.Key);
    }
 
    public string Name
    {
        get { return "GlobalTriggerListener"; }
    }
}
```

#### Add Listeners to Scheduler

The last step is to add the listeners we have made to the scheduler. We add them via the scheduler's listener manager:

```c#
var scheduler = new StdSchedulerFactory().GetScheduler();
 
// add scheduler listener
scheduler.ListenerManager.AddSchedulerListener(new SchedulerListener());
 
// add global job listener
scheduler.ListenerManager.AddJobListener(new GlobalJobListener(), GroupMatcher<JobKey>.AnyGroup());
 
// add global trigger listener
scheduler.ListenerManager.AddTriggerListener(new GlobalTriggerListener(), GroupMatcher<TriggerKey>.AnyGroup());
```

We now have listeners for our scheduler, jobs, and triggers!

### Final Thoughts
* The job and trigger listeners in our example are global, which means they listen to all jobs via `GroupMatcher<JobKey>.AnyGroup()` and all triggers via `GroupMatcher<TriggerKey>.AnyGroup()`. Quartz.NET has various ways to narrow the scope of which jobs and triggers to listened to. For example, instead of using the `AnyGroup()` method we could use `GroupContains()`, `GroupEndsWith()`, etc.
* The `ITriggerListener` has a method named `VetoJobExecution()` that returns a `bool`. This method determines if the job execution should be vetoed or not, **so be sure to return true unless we really want to veto the job. Do not throw a `NotImplementedException` in this method either, as this will result in an unhandled exception and the job being cancelled!**