---
layout: post
title:  Dependency Injection for Quartz.NET
date:   2016-08-15 01:00:00 -0700
categories: [.NET]
tags: [Quartz, .NET]
githubUrl: https://github.com/cknightdevelopment/KnightCodesExamples/tree/master/DotNet/Quartz.Ninject
youtubeId: RlW4vUsoxEY
---

Quartz.NET is a full-featured, [open source](https://github.com/quartznet/quartznet){:target="_blank"} job scheduling system that can be used from the smallest apps to large scale enterprise systems (stole this from the their home page). However, one common pain point when using Quartz.NET is configuring dependency injection (DI) for their jobs. 

<div class="alert alert-info" role="alert">
<strong>NOTE:</strong> This post assumes that you already have a basic working knowledge of Quartz.NET and Ninject.
</div>

### Overview

The goal of this post will be to show an easy way to get Ninject DI configured for jobs in Quartz.NET. There are a few steps:

1. Add Ninject to your project via NuGet
2. Update existing Quartz.NET jobs to receive their dependencies via their constructor
3. Create a job factory that will utilize Ninject to perform DI whenever Quartz.NET needs an instance of a job
4. Setup the Ninject bindings
5. Use Ninject to create your scheduler

### Example

The first thing we need to do is add the Ninject package to our project via NuGet. Once that is in place we will update our job(s) to receive their dependencies through their constructor. In our example we will create a job named `DogJob` that takes a dependency on `IDog`. 

```c#
class DogJob : IJob
{
    private readonly IDog _dog;
 
    // DogJob has a dependency on IDog
    public DogJob(IDog dog)
    {
        _dog = dog;
    }
 
    public void Execute(IJobExecutionContext context)
    {
        Console.WriteLine("---{0}---", context.FireTimeUtc.Value.ToLocalTime());
        _dog.Bark();
        _dog.ChaseMailman(8);
    }
}
 
interface IDog
{
    void Bark();
    void ChaseMailman(int speed);
}
 
class GoldenRetriever : IDog
{
    public void Bark()
    {
        Console.WriteLine("Bark!");
    }
 
    public void ChaseMailman(int speed)
    {
        Console.WriteLine(speed >= 5 ? "Caught the mailman!" : "Couldn't catch the mailman, maybe next time.");
    }
}
```

Next, we need to create a job factory for Quartz.NET to use whenever it needs an instance of a job (e.g. when a job is fired). This job factory will take care of the dependency injection that the job requires by using Ninject. We will set up the actual Ninject bindings in the next step, but in this step we will just create the job factory that will make use of those bindings when instantiating the jobs. 

Create a job factory called `NinjectJobFactory` that inherits from the default Quartz.NET job factory `SimpleJobFactory`. This new job factory is going to take an `IKernel` (a super-factory from Ninject for binding stuff) in its constructor, and override the default `NewJob()` method provided by `SimpleJobFactory`. Our implementation of `NewJob()` is going to use the provided IKernel to create an instance of the job type requested and provide whatever dependencies it needs:

```c#
class NinjectJobFactory : SimpleJobFactory
{
    readonly IKernel _kernel;
 
    public NinjectJobFactory(IKernel kernel)
    {
        this._kernel = kernel;
    }
 
    public override IJob NewJob(TriggerFiredBundle bundle, IScheduler scheduler)
    {
        try
        {
            // this will inject dependencies that the job requires
            return (IJob) this._kernel.Get(bundle.JobDetail.JobType); 
        }
        catch (Exception e)
        {
            throw new SchedulerException(string.Format("Problem while instantiating job '{0}' from the NinjectJobFactory.", bundle.JobDetail.Key), e);
        }
    }
}
```

Now that we have the job factory created we need to initialize a Ninject kernel and our bindings. Before we add our application specific bindings we need to add a binding that will create a Quartz.NET scheduler. We can do this using `ToMethod()` from Ninject. 

The scheduler will use the new `NinjectJobFactory` we made to create instances of our jobs when Quartz.NET asks for them. Once this binding is added we can add all of the bindings that our job's require. For our `DogJob` example, we need to create a binding that will give an instance of `GoldenRetriever` whenever `IDog` is asked for:

```c#
static IKernel InitializeNinjectKernel()
{
    var kernel = new StandardKernel();
 
    // setup Quartz scheduler that uses our NinjectJobFactory
    kernel.Bind<IScheduler>().ToMethod(x =>
    {
        var sched = new StdSchedulerFactory().GetScheduler();
        sched.JobFactory = new NinjectJobFactory(kernel);
        return sched;
    });
 
    // add our bindings as we normally would (these are the bindings that our jobs require)
    kernel.Bind<IDog>().To<GoldenRetriever>();
    // etc.
 
    return kernel;
}
```

The last step is to call `InitializeNinjectKernel()` to initialize the kernel, and then create the scheduler by using this kernel. This will give us a scheduler that uses our custom job factory, which will provide the DI our jobs need. From this point you can configure your jobs, triggers, etc. as you normally would.

```c#
static void Main(string[] args)
{
    // initialize kernel and create the scheduler
    var kernel = InitializeNinjectKernel();
    var scheduler = kernel.Get<IScheduler>();
 
    // Below this line should be whatever code you are using today to schedule jobs, triggers, etc. and start the scheduler. This is just here for context
 
    // add jobs and start scheduler
    scheduler.ScheduleJob(
        JobBuilder.Create<DogJob>().Build(), 
        TriggerBuilder.Create().WithSimpleSchedule(s => s.WithIntervalInSeconds(2).RepeatForever()).Build());
 
    // start scheduler
    scheduler.Start();
}
```

This is all you need to have dependency injection via Ninject in your Quartz.NET application!

### Final Thoughts
* This is by no means the only way to add DI for Quartz.NET jobs, and obviously there are many different DI frameworks you can use besides Ninject. However, one reason I like this implementation is that it requires minimal additions to existing code and keeps the DI code largely separate from everything else.
* One thing that you are going to want to keep in mind is the scope in which you are having Ninject provide dependencies for your jobs. Do you need a separate instance of the dependency each time the job is fired (I would recommend using `InCallScope()` in this scenario, which requires the `Ninject.Extensions.NamedScope` package from NuGet)? Do you need the same instance of the dependency each time the job is called? Can different jobs share the same instance of a dependency? Do the dependencies need to be thread aware? Here is a break down of the various [scopes that Ninject provides](https://github.com/ninject/ninject/wiki/Object-Scopes){:target="_blank"}.