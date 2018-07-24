---
layout: post
title:  ng-form-rules - Simple, powerful, and customizable rule engine library for Angular reactive forms
date:   2018-07-23 00:00:00 -0700
categories: [Angular]
tags: [Angular, ng-form-rules]
githubUrl: https://github.com/cknightdevelopment/ng-form-rules
youtubeId: 
---

`ng-form-rules` makes working with Angular reactive forms easier by providing a simple, powerful, and customizable rule engine library. You simply describe your data structure, rules, and logic, and we will create a form that hooks it all together for you.

### Why?

Working with Angular reactive forms is great... until it sucks. As web developers, we work with forms all day long and anything we can do to make this easier has a huge impact. We care about things like the sturcture of the form, if a control is valid, if a control is editable, reacting to changes in the form, etc. `ng-form-rules` was built to make all these things easier and to offer more control over how they work. 

### What?

#### What does `ng-form-rules` do?

* Create model settings with rules dictating whether properties are valid and/or editable
    * Rules can be as simple or complex as you want; you have full control
    * Rules can react to changes in other properties, whether at the same level, nested, in an array item, or at a parent's level
    * Synchronous and asynchronous rules are allowed
* Generate Angular form controls (`FormGroup`, `FormArray`, and `FormControl`) based upon your model settings to use within your templates
    * All of the rules in your model settings will automatically be attached to the form.
* You are never blocked! The form controls we generate are no different than what you already use in Angular. You can manipulate them, add controls, add validators from outside `ng-form-rules`, etc.

#### What does `ng-form-rules` **NOT** do?

* Anything with styling, display, etc.
* Provide a library of validation methods (e.g. MaxLength, Required, etc.)

### "Show me the money!" (examples)

#### [White belt](https://stackblitz.com/edit/ngfr-getting-started?file=src%2Fapp%2Fapp.component.ts){:target="_blank"}

Form with one control having a simple validation rule.

#### [Yellow belt](https://stackblitz.com/edit/ngfr-rule-group?file=src%2Fapp%2Fapp.component.ts){:target="_blank"}

Form with one control having more complex validation rules.

#### [Blue belt](https://stackblitz.com/edit/ngfr-rule?file=src%2Fapp%2Fapp.component.ts){:target="_blank"}

Form with controls having synchronous and asynchronous validation rules.

#### [Black belt](https://stackblitz.com/edit/ngfr-dependency-properties?file=src%2Fapp%2Fapp.component.ts){:target="_blank"}

Form with several types of controls (simple, group, array, etc.) with validation rules that listen for value changes in different areas of the form.

### Resources

* [README / Getting Started](https://github.com/cknightdevelopment/ng-form-rules){:target="_blank"}
* [Documentation](https://github.com/cknightdevelopment/ng-form-rules/wiki){:target="_blank"}
* [All examples](https://github.com/cknightdevelopment/ng-form-rules/wiki/examples){:target="_blank"}
* [Gitter](https://gitter.im/ng-form-rules/Lobby){:target="_blank"}
* [Twitter](https://twitter.com/ngFormRules){:target="_blank"}
* [License](https://github.com/cknightdevelopment/ng-form-rules/blob/master/LICENSE){:target="_blank"}
