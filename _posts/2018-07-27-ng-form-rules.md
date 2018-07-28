---
layout: post
title:  ng-form-rules - Simple, powerful, and customizable rule engine library for Angular reactive forms
date:   2018-07-27 00:00:00 -0700
categories: [Angular]
tags: [Angular, ng-form-rules]
githubUrl: https://github.com/cknightdevelopment/ng-form-rules
youtubeId: eL3Gp1cGBJQ
---

`ng-form-rules` makes working with Angular reactive forms easier by providing a simple, powerful, and customizable rule engine library. You simply describe your data structure, rules, and logic, and we will create a form that hooks it all together for you.

### Why?

Working with Angular reactive forms is great... until it sucks. As web developers, we work with forms all day long and anything we can do to make this easier will have a huge impact. We care about things like the sturcture of the form, if a control is valid, if a control is editable, reacting to changes in the form, etc. `ng-form-rules` was built to make all these things simpler and more powerful. 

### What?

#### What does `ng-form-rules` do?

* Generate Angular reactive form controls (`FormGroup`, `FormArray`, and `FormControl`) based upon model setting configurations
    * Model settings have a collection of properties that have tests & rules dictating whether they are valid and/or editable
    * Model settings won't clutter your model classes and can be re-used as much as you'd like
* Rules can be as simple or complex as you want; you have full control
    * Rules can react to changes in other properties in the form, whether at the same level, nested, in an array item, or at a parent's level
    * Rules can be synchronous or asynchronous
    * All of the rules in your model settings will automatically be integrated seamlessly into your form
* You are never blocked! The form controls we generate are no different than what you already use in Angular. You can manipulate them, add controls, add validators from outside `ng-form-rules`, etc.

#### What does `ng-form-rules` **NOT** do?

* Anything to do with styling, display, etc.
* Provide a library of validation methods (e.g. MaxLength, Required, etc.)

### "Show me the money!" (examples)

Watch our ["Let's Build a Registration Form" video](https://www.youtube.com/watch?v=eL3Gp1cGBJQ){:target="_blank"} for a great walkthrough of several key features of the library.

#### [White belt](https://stackblitz.com/edit/ngfr-getting-started?file=src%2Fapp%2Fapp.component.ts){:target="_blank"}

Form with one control having a simple validation rule.

#### [Yellow belt](https://stackblitz.com/edit/ngfr-rule-group?file=src%2Fapp%2Fapp.component.ts){:target="_blank"}

Form with one control having more complex validation rules.

#### [Blue belt](https://stackblitz.com/edit/ngfr-rule?file=src%2Fapp%2Fapp.component.ts){:target="_blank"}

Form with controls having synchronous and asynchronous validation rules.

#### [Brown belt](https://stackblitz.com/edit/ngfr-dependency-properties?file=src%2Fapp%2Fapp.component.ts){:target="_blank"}

Form with several types of controls (simple, group, array, etc.) with validation rules that listen for value changes in different areas of the form.

#### [Black belt](https://stackblitz.com/edit/ngfr-registration-form?file=src%2Fapp%2Fapp.component.ts){:target="_blank"}

Registration form utilizing many (but not all) of the common features of `ng-form-rules`.

### Resources

* [README / Getting Started](https://github.com/cknightdevelopment/ng-form-rules){:target="_blank"}
* [Documentation](https://github.com/cknightdevelopment/ng-form-rules/wiki){:target="_blank"}
* [All examples](https://github.com/cknightdevelopment/ng-form-rules/wiki/examples){:target="_blank"}
* [Gitter](https://gitter.im/ng-form-rules/Lobby){:target="_blank"}
* [Twitter](https://twitter.com/ngFormRules){:target="_blank"}
* [License](https://github.com/cknightdevelopment/ng-form-rules/blob/master/LICENSE){:target="_blank"}
