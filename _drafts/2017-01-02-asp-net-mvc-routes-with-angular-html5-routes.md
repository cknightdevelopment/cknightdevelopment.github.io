---
layout: post
title:  Angular 2 HTML5 Routing with ASP.NET MVC - How do I get them to play nice together?
date:   2017-01-02 12:00:00 -0700
categories: [Angular2]
tags: [Angular2, .NET]
githubUrl: 
youtubeId:
---

Both ASP.NET MVC and Angular 2 have powerful routing functionality. However, getting them to play nicely together can sometimes be a struggle? This quickly becomes apparent when using the [Angular 2 router's `PathLocationStrategy`, its default HTML 5 style of routing](https://angular.io/docs/ts/latest/guide/router.html#!#browser-url-styles){:target="_blank"}, and trying to reconcile your client-side and server-side routes.


### The Problem

When using the `PathLocationStrategy` the router will compose a _natural URL_ instead of the traditional _hash URL_ that Angular 1 would compose. Here's the difference:

_Natural URL_:

* `http://yoursite.com/contact/list` 

_Hash URL_

* `http://yoursite.com/#/contact/list`

Back when using Angular 1 (or if you decide to use the Angular 2 `HashLocationStrategy` instead) your client-side routes wouldn't ever conflict with your server-side routes because of the existence of the `#` in the URL. But now with HTML5 Angular 2 no longer requires the `#` to be in the URL, so our server-side router gets confused. 

In our "Contact List" example above the ASP.NET MVC router would look for a `List` action method in a `Contact` controller. Is this what we want? Well ... maybe. We might want ASP.NET MVC to serve a specific Razor template, but we might want the Angular 2 router to be used to take us to a specific view. Or maybe something completely different. The point is that the server-side router doesn't know, so we have to tell it what we want it to do.

### The Solution

Our solution has to allow the ASP.NET MVC router handle server-side routes when appropriate, and allow the Angular 2 router to handle client-side routes when appropriate. So, we need something that can tell us which router should be used. This is a great scenario for ASP.NET MVC route constraints. Here is a simple route constraint named `ServerRouteConstraint` that inherits from `IRouteConstraint` interface that .NET provides. It simply takes in a predicate function in it's constructor will look at a `Uri` and return a `bool` that indicates if this route is a server-side route. It is very generic and allows us to define whatever rules we want for determining which routes are server-side and which routes are not.

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

With that route constraint class created we can now define a constraint within our route definitions. In the example below the typical `{controller}/{action}/{id}` uses an instance of this class where we say that if the request URL path starts with `/Settings/` we consider it to be a server-side route. If a URL came in with a path that started with something like `/Contacts/List`, the constraint would be false, meaning the next route definition would be tried. The next route definition is a catch-all route (`{*url}` basically matches anything) and will use whatever controller & action that we tell it to. This should be the view that you bootstrap your Angular 2 app from. This means that the ASP.NET MVC router is not trying to find some `List` action method in a `Contact` controller, but rather passes it on to the Angular router to route where it want to go.

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
                return url.PathAndQuery.StartsWith("/Settings/", 
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
}
```

The nice thing about this is that you can decide what the best way is for you to determine which routes are server-side routes. Maybe for your Angular 2 route setup all routes start with `/app/`. In that case your predicate you pass to `ServerRouteConstraint` could be something like this:

```csharp
url =>
{
    return !url.PathAndQuery.StartsWith("/app/", StringComparison.InvariantCultureIgnoreCase);
}
```

I have found that this setup has been the best way for me to accomplish having ASP.NET MVC routes and Angular 2 routes play nicely together. I'd welcome any feedback or questions you may have. Thanks!