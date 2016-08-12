---
layout: post
title:  Understanding Angular Directive Scopes
date:   2016-05-15 14:00:00 -0700
categories: [Angular]
tags: [Angular, JavaScript]
---

One of the most powerful features in Angular is the ability to create custom directives. They allow you to write more modularized code that can be re-used throughout your application. However, understanding how scope works within a custom directive can often be confusing and is by no means obvious. How does your directive access scope properties on a controller? How do you give a directive it's own scope? How can you isolate your directive's scope from the rest of your application? We will address these questions and more in this post. 

### Overview

I have found that there are 4 primary ways to configure a directive's scope, each of which can be useful in different scenarios. I am sure there are hybrids of these 4 configurations, but these will at least give you a solid foundation to start from. It is often helpful to give things memorable names when learning, so I will refer to these scope configurations as follows (each will be explained in more detail later):

1. [Moocher](#moocher)

   The directive does not have any scope of its own and just uses (mooches) the scope of the view that contains it. Everything in the controller's scope is accessible from the directive.

2. [Borrower](#borrower)

   The directive has a scope of it's own and it also inherits (borrows) the scope of the view that contains it. Everything in the controller's scope is accessible from the directive.

3. [Loner](#loner)

   The directive has its own isolated (loner) scope. The directive's scope does not inherit anything from the scope of the view that contains it. It is a lone ranger.

4. [Negotiator](#negotiator)

   The directive has it's own scope and shares (negotiates) the scope of the view that contains it. One-way and two-way data binding of scope properties can be configured, as well as function/expression bindings. Only the scope properties configured to be "shared" are accessible from the directive.
   
_NOTE: The examples below are using the angular "controller as" syntax (learn about it [here](https://johnpapa.net/angularjss-controller-as-and-the-vm-variable/)). If you don't know what that is just know that the controller scope on the views is referred to as `vm`, as in `vm.scopePropertyName`._
   
### Moocher
 
#### Controller

The `PersonCtrl` controller sets three properties on the `person` object defined on it's scope: `firstName`, `lastName`, and `speak`.

```js
angular.module("app")
    .controller("PersonCtrl", function () {
        var vm = this;
        vm.person = {
            firstName: "Cosmo",
            lastName: "Kramer",
            speak: function () {
                return `Hello, my name is ${vm.person.firstName} ${vm.person.lastName}.`;
            }
        };
    });
```

#### Directive

The `moocher` directive has no scope of it's own and will use the scope of the view that contains it (`PersonCtrl` in our example). This scope is the `scope` parameter passed to the `link()` function on the directive. You don't have to do anything with this scope if you don't want (you don't even need to define a `link()` function at all). However, if you want to add data or behaviors to the scope from the directive, you can do something like what we are doing with `msgFromDirective`. The controller and all instances of the directive will share the same scope and their data will be in sync.

```js
angular.module("app")
    .directive("moocher", function () {
       return {
           templateUrl: "examples/moocher/moocher.html",
           // optional: add properties to the scope
           link: function (scope, element, attrs) { 
               scope.vm.msgFromDirective = "Message from the 'person' directive!"
           }
       };
    });
```

#### Main View

All the properties put on the scope by the `PersonCtrl` controller and all the properties added to the scope in the `link()` function of the directive will be available to the main view.

```html
<h3>Controller</h3>
<div class="well well-sm">
    <div class="form-inline">
        <div class="form-group">
            <label for="firstName">First Name</label>
            <input type="text" name="firstName" id="firstName" ng-model="vm.person.firstName" />
        </div>
        <div class="form-group">
            <label for="lastName">Last Name</label>
            <input type="text" name="lastName" id="lastName" ng-model="vm.person.lastName" />
        </div>
    </div>

    <div>First Name: {% raw %}{{vm.person.firstName}}{% endraw %}</div>
    <div>Last Name: {% raw %}{{vm.person.lastName}}{% endraw %}</div>
    <div>{% raw %}{{vm.person.speak()}}{% endraw %}</div>
    <div>{% raw %}{{vm.msgFromDirective}}{% endraw %}</div>
</div>


<h3>Moocher #1</h3>
<div class="well well-sm">
    <moocher></moocher>
</div>
```

#### Moocher View

(same story as the main view above)

```html
<div>First Name: {% raw %}{{vm.person.firstName}}{% endraw %}</div>
<div>Last Name: {% raw %}{{vm.person.lastName}}{% endraw %}</div>
<div>{% raw %}{{vm.person.speak()}}{% endraw %}</div>
<div>{% raw %}{{vm.msgFromDirective}}{% endraw %}</div>
```

### Borrower

#### Controller

The `CarCtrl` controller sets three properties on the `car` object defined in it's scope: `make`, `model`, and `getInfo`.

```js
angular.module("app")
    .controller("CarCtrl", function () {
        var vm = this;
        vm.car = {
            make: "Ford",
            model: "Focus",
            getInfo: function () {
                return `I am a ${vm.car.model} made by ${vm.car.make}.`;
            }
        }
    });
```

#### Directive

The `borrower` directive has a scope of its own provided by `BorrowerCtrl` and also inherits from the scope of the view that contains it (`CarCtrl` is our example). _This is accomplished by the `scope` on the directive being set to `true`_. The `BorrowerCtrl` adds a `year` property to the `car` object on it's scope.

```js
angular.module("app")
    .directive("borrower", function () {
        return {
            templateUrl: "examples/borrower/borrower.html",
            scope: true
        };
    })
    .controller("BorrowerCtrl", function () {
        this.car = {
            year: 2016
        };
    });
```

#### Main View

The main view can access it's scope properties as usual, but cannot access the `year` property that the `borrower` directive added to it's own scope. The `{%raw%}{{vm.year}}{%endraw%}` will display nothing.

```html
<h3>From Controller</h3>

<div class="well well-sm">
    <div class="form-inline">
        <div class="form-group">
            <label for="make">Make</label>
            <input type="text" name="make" id="make" ng-model="vm.car.make" />
        </div>
        <div class="form-group">
            <label for="model">Model</label>
            <input type="text" name="model" id="model" ng-model="vm.car.model" />
        </div>
    </div>

    <div>Make: {% raw %}{{vm.car.make}}{% endraw %}</div>
    <div>Model: {% raw %}{{vm.car.model}}{% endraw %}</div>
    <div>{% raw %}{{vm.car.getInfo()}}{% endraw %}</div>
    <div>Year: {% raw %}{{vm.year}}{% endraw %}</div> <!-- cannot access the directives scope -->
</div>


<h3>Borrower #1</h3>
<div class="well well-sm">
    <borrower></borrower>
</div>

<h3>Borrower #2</h3>
<div class="well well-sm">
    <borrower></borrower>
</div>
```

#### Borrower View

The view for the `borrower` directive is able to access the `CarCtrl`'s scope properties via `vm`. The `BorrowerCtrl` scope to `borrowerVm`, which allows us to display the `year` property via `{% raw %}{{borrowerVm.car.year}}{% endraw %}`. Every instance of `borrower` will inherit the same scope from `CarCtrl`, but will get it's own scope from `BorrowerCtrl`. This mean that updates to `make` & `model` will effect the main view and all directive views, but changes to `year` will only effect that `BorrowerCtrl`'s scope & view.

```html
<div ng-controller="BorrowerCtrl as borrowerVm">
    <div class="form-inline">
        <div class="form-group">
            <label for="year">Year</label>
            <input type="text" name="year" id="year" ng-model="borrowerVm.car.year" />
        </div>
    </div>
    
    <div>Make: {% raw %}{{vm.car.make}}{% endraw %}</div>
    <div>Model: {% raw %}{{vm.car.model}}{% endraw %}</div>
    <div>{% raw %}{{vm.car.getInfo()}}{% endraw %}</div>
    <div>Year: {% raw %}{{borrowerVm.car.year}}{% endraw %}</div>
</div>
```

### Loner

This `StereoCtrl` controller sets three properties on the `stereo` object defined in it's scope: `min`, `max`, and `getInfo`.

#### Controller
```js
angular.module("app")
    .controller("StereoCtrl", function () {
        var vm = this;
        vm.stereo = {
            min: 0,
            max: 10,
            getInfo: function () {
                return `This stereo goes from ${vm.stereo.min} to ${vm.stereo.max}`;
            }
        }
    });
```

#### Directive

The `loner` directive does not inherit any scope, but has it's own totally isolated scope provided by the `LonerCtrl`. _This is accomplished by the `scope` on the directive being set to `{}`_. The `LonerCtrl` defines it's own `min` & `max` scope properties on it's own `stereo` object, which will override the one on `StereoCtrl`.

```js
angular.module("app")
    .directive("loner", function () {
        return {
            templateUrl: "examples/loner/loner.html",
            scope: {}
        }
    })
    .controller("LonerCtrl", function () {
        this.stereo = {
            min: 5,
            max: 11
        }
    });
```

#### Main View

Nothing special here, just basic model binding that we have already seen.

```html
<h3>From Controller</h3>

<div class="well well-sm">
    <div class="form-inline">
        <div class="form-group">
            <label for="min">Min</label>
            <input type="text" name="min" id="min" ng-model="vm.stereo.min" />
        </div>
        <div class="form-group">
            <label for="max">Max</label>
            <input type="text" name="max" id="max" ng-model="vm.stereo.max" />
        </div>
    </div>
    
    <div>Min: {% raw %}{{vm.stereo.min}}{% endraw %}</div>
    <div>Max: {% raw %}{{vm.stereo.max}}{% endraw %}</div>
    <div>Info: {% raw %}{{vm.stereo.getInfo()}}{% endraw %}</div>
</div>


<h3>Loner #1</h3>
<div class="well well-sm">
    <loner></loner>
</div>

<h3>Loner #2</h3>
<div class="well well-sm">
    <loner></loner>
</div>
```

#### Loner View

The `loner` directive view will use the scope provided by the `LonerCtrl`. It defines it's own `stereo` object with `min` & `max` scope properties with different values than the ones on `StereoCtrl`. Each instance of the `loner` directive will get its own isolated version of the `LonerCtrl`. This means that if you change the `min` or  `max` on a directive it will not effect any of the other instances of the directive.

```html
<div ng-controller="LonerCtrl as vm">
    <div class="form-inline">
        <div class="form-group">
            <label for="min">Min</label>
            <input type="text" name="min" id="min" ng-model="vm.stereo.min" />
        </div>
        <div class="form-group">
            <label for="max">Max</label>
            <input type="text" name="max" id="max" ng-model="vm.stereo.max" />
        </div>
    </div>
    
    <div>Min: {% raw %}{{vm.stereo.min}}{% endraw %}</div>
    <div>Max: {% raw %}{{vm.stereo.max}}{% endraw %}</div>
    <div>Info: {% raw %}{{vm.stereo.getInfo()}}{% endraw %}</div>
</div>
```

### Negotiator

#### Controller

The `IceCreamCtrl` controller sets three properties on the `iceCream` object in it's scope: `min`, `max`, and `getInfo`. An `alertText` function property is also set on the scope that will simply alert whatever text it receives in it's parameter.

```js
angular.module("app")
    .controller("IceCreamCtrl", function () {
        var vm = this;
        vm.iceCream = {
            flavor: "Vanilla",
            size: "Medium",
            getInfo: function () {
                return `I have a ${vm.iceCream.size} ${vm.iceCream.flavor} ice cream.`
            }
        };
        vm.alertText = function (text) {
            alert(text);
        }
    });
```

#### Directive

This is where things get fun! The `negotiator` directive has it's own scope, but _negotiates_ with the scope of the view that contains it (`IceCreamCtrl` in our example). A scope property named `flavaFlave` will be created and have a **one-way** binding with the property `flavor` that is passed to the instance of the directive (will make more sense when looking at the main view below). A scope property named `howBig` will be created and have a **two-way** binding with the property `size` that is passed to the instance of the directive. A scope function property named `getTheDeets` will be created and assigned to the property `getInfo` that is passed to the instance of the directive. Lastly, a scope function named `soundTheAlarm` will be created and assigned to the property `alertText` that is passed to the instance of the directive. The function will be passed isolated scope data from the directive's isolated scope (more on that later). Here is a simple way to remember the binding syntax:

* `@` = one-way
* `=` = two-way
* `&` = function/expression binding

```js
angular.module("app")
    .directive("negotiator", function () {
        return {
            templateUrl: "examples/negotiator/negotiator.html",
            link: function (scope) {
                // can add private members to the isolated scope here
                scope.message = "This is my message.";
            },
            scope: {
                // one way
                flavaFlave: "@flavor",
                // two way
                howBig: "=size", 
                // expression (function)
                getTheDeets: "&getInfo",
                // expression that takes isolated scope data
                soundTheAlarm: "&alertText"
            }
        }
    });
```

#### Main View

The only new stuff going on in this view is the `<negotiator>` elements at the bottom. Notice how we are setting attributes on the `<negotiator>` element that correspond to the scope bindings mentioned above in the directive section. That is how the `negotiator` directive binds it's scope properties. 

One important thing to see is the `vm.alert(blah)` we are setting to the `alert-text` attribute. What is that `blah` all about? It is the name of the property we are going to use in our call to `getInfo` from the directive's view. This will allow us to take data from our directive's isolated scope and use it as the parameter to the `getInfo` function on the controller's scope. 

```html
<h3>From Controller</h3>

<div class="well well-sm">
    <div class="form-inline">
        <div class="form-group">
            <label for="flavor">Flavor</label>
            <input type="text" name="flavor" id="flavor" ng-model="vm.iceCream.flavor" />
        </div>
        <div class="form-group">
            <label for="size">Size</label>
            <input type="text" name="size" id="size" ng-model="vm.iceCream.size" />
        </div>
    </div>
    
    <div>Flavor: {% raw %}{{vm.iceCream.flavor}}{% endraw %}</div>
    <div>Size: {% raw %}{{vm.iceCream.size}}{% endraw %}</div>
    <div>Info: {% raw %}{{vm.iceCream.getInfo()}}{% endraw %}</div>
</div>


<h3>Negotiator #1</h3>
<negotiator 
    flavor="{% raw %}{{vm.iceCream.flavor}}{% endraw %}"
    size="vm.iceCream.size"
    get-info="vm.iceCream.getInfo()"
    alert-text="vm.alertText(blah)">
</negotiator>

<h3>Negotiator #2</h3>
<negotiator 
    flavor="{% raw %}{{vm.iceCream.flavor}}{% endraw %}"
    size="vm.iceCream.size"
    get-info="vm.iceCream.getInfo()"
    alert-text="vm.alertText(blah)">
</negotiator>
```

#### Negotiator View

Most of what we see in this view is stuff we have seen before; binding to properties on the directive's scope. The one thing to point out is the `ng-click="soundTheAlarm({blah: message})"`. As we mentioned above, `blah` is the name of property we are using to allow us to pass in data from our directive's isolated scope as the parameter to the `alertText` method on the controller's scope.

```html
<div class="well well-sm">
    <div class="form-inline">
        <div class="form-group">
            <label for="flavaFlave">Flava Flave</label>
            <input type="text" name="flavaFlave" id="flavaFlave" ng-model="flavaFlave" />
        </div>
        <div class="form-group">
            <label for="howBig">How Big</label>
            <input type="text" name="howBig" id="howBig" ng-model="howBig" />
        </div>
        <div class="form-group">
            <label for="message">Message</label>
            <input type="text" name="message" id="message" ng-model="message" />
        </div>
        <div class="form-group">
            <button class="btn btn-primary" ng-click="soundTheAlarm({blah: message})">
                Sound The Alarm
            </button>
        </div>
    </div>

    <div>Flava Flave: {% raw %}{{flavaFlave}}{% endraw %}</div>
    <div>How Big: {% raw %}{{howBig}}{% endraw %}</div>
    <div>Info: {% raw %}{{getTheDeets()}}{% endraw %}</div>
</div>
```