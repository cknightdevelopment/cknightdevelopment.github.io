---
layout: post
title:  Angular 2 Routes with ASP.NET MVC - How do I get them to play nice together?
date:   2017-01-04 20:00:00 -0700
categories: [Angular2]
tags: [Angular2, Routing, .NET]
githubUrl: https://github.com/cknightdevelopment/KnightCodesExamples/tree/master/DotNet/Angular2RoutesWithMvc
youtubeId: https://youtu.be/4keNnVxOh_M
---

Angular 2 and ASP.NET MVC both have powerful routing functionality. However, getting them to play nicely together can sometimes be a struggle. This quickly becomes apparent when using the [Angular 2 router's `PathLocationStrategy`, its default HTML 5 style of routing](https://angular.io/docs/ts/latest/guide/router.html#!#browser-url-styles){:target="_blank"}, and trying to reconcile your client-side and server-side routes.

### Overview

When using the `PathLocationStrategy` in Angular 2 the router composes a _natural URL_ instead of the traditional _hash URL_ that Angular 1 composes. As an example, here is the difference between the two types of URLs for a "Contact List" page:

_Natural URL_:

* `http://yoursite.com/contact/list` 

_Hash URL_

* `http://yoursite.com/#/contact/list`

### The Problem

Back when using Angular 1 (or if you instead decide to use the Angular 2 `HashLocationStrategy`) your client-side routes wouldn't ever conflict with your server-side routes because of the existence of the `#` in the URL. But now with the natural URL that Angular 2 composes, our server-side routes and client-side routes can be in conflict. 

In our "Contact List" example above the ASP.NET MVC router would look for a `List` action method on a `Contact` controller. Is this what we want? Well... maybe. We might in fact want ASP.NET MVC to serve a specific Razor template, although we might have intended for the Angular 2 router to be used instead to take us to a specific component view. Or maybe something completely different. The point is that the server-side router doesn't know, so we have to tell it what we want.

### The Solution

Our solution has to allow the ASP.NET MVC router to handle server-side routes, and allow the Angular 2 router to handle client-side routes when appropriate. So, we need something that can tell the router which kind of route it is. 

This is a great scenario for an ASP.NET MVC route constraint. All we need to do is create a class that inherits from the `IRouteConstraint` interface that .NET provides. Below is a simple route constraint named `ServerRouteConstraint` that receives a delegate in its constructor of type `Func<Uri, bool>`. It will look at a `Uri` and return a `bool` indicating if the URL is for a server-side route or not. The routing pipeline in ASP.NET MVC will call the `Match()` function for us, which just calls the delegate that we passed into the constructor. This class is left generic intentionally to allow for us to define whatever logic we want. 

```csharp
public class ServerRouteConstraint : IRouteConstraint
{
    private readonly Func<Uri, bool> _predicate;

    public ServerRouteConstraint(Func<Uri, bool> predicate)
    {
        this._predicate = predicate;
    }

    public bool Match(HttpContextBase httpContext, Route route, string parameterName, 
        RouteValueDictionary values, RouteDirection routeDirection)
    {
        return this._predicate(httpContext.Request.Url);
    }
}
```

We can now add a constraint to our route definition(s). In the example below we have the typical `{controller}/{action}/{id}` default route using an instance of `ServerRouteConstraint`. Our implementation says that if the request URL path starts with `/Settings` we will consider it to be a server-side route. If a request URL came in with a path that started with `/Contacts/List`, the constraint would be false and the next route definition would be tried. 

The next route definition named "angular" is a catch-all route (`{*url}` matches anything) and will use whatever default controller & action we tell it to. This should be set to the view where you bootstrap your Angular 2 app. What this means is that the ASP.NET MVC router will not try to find a `List` action method on a `Contact` controller, but rather it will end up passing it on to the Angular router.

{% include alert.html 
    type="info" 
    text="Be sure to add the catch-all angular route definition after all of your other route definitions!" 
%}

```csharp
public static void RegisterRoutes(RouteCollection routes)
{
    routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

    routes.MapMvcAttributeRoutes();

    routes.MapRoute(
        name: "default",
        url: "{controller}/{action}/{id}",
        defaults: new {controller = "Home", action = "Index", id = UrlParameter.Optional},
        // Set a constraint to only use this for routes identified as server-side routes
        constraints: new
        {
            serverRoute = new ServerRouteConstraint(url =>
            {
                return url.PathAndQuery.StartsWith("/Settings", 
                    StringComparison.InvariantCultureIgnoreCase);
            })
        });

    // This is a catch-all for when no other routes matched. Let the Angular 2 router take care of it
    routes.MapRoute(
        name: "angular",
        url: "{*url}",
        defaults: new { controller = "Home", action = "Index" } // The view that bootstraps Angular 2
    );
}
```

The nice thing about the `ServerRouteConstraint` is that you can implement whatever logic you want to determine if a URL is for a server-side route. Maybe for your Angular 2 route setup all your routes start with `/app`. In that case the delegate you pass to `ServerRouteConstraint` could be something like this:

```csharp
url =>
{
    return !url.PathAndQuery.StartsWith("/app", StringComparison.InvariantCultureIgnoreCase);
}
```

This setup has been the best way for me to accomplish having my Angular 2 routes and my ASP.NET MVC routes play nicely together. I'd welcome any feedback, suggestions, or questions you may have. Thanks!