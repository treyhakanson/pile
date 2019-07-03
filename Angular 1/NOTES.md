# Angular Best Practices

Best practices for Angular per John Papa's [course](https://app.pluralsight.com/player?course=angularjs-patterns-clean-code&author=john-papa&name=angularjs-patterns-clean-code-m2) on pluralsight 

## Separation of Concerns (SoC)

Separation of concerns involves isolating files into very small chunks that do one thing, and do it well. This allows for more reusability and ease of testing/finding and isolating bugs.

Angular is more or less built around the concept of separation of concerns

### The Rule of One

1 Component, 1 Role, 1 File

do one thing and do it well. For example, controllers should ONLY handle logic for a view, not handle things like logging and making api calls.

should break applications down into common (generic) modules for things like logging, and then also break down functionality (screens, flows, etc) into modules as well. All these modules are now resuable, and can be included into one large angular application.

## Application Structure

### General Principles

General application structure:

`/app` angular code
`/content` assets
`/vendor` 3rd-party code
`/test` tests

Better to sort large applications by feature instead of by type:

```
// by feature
app/
    dashboard/
    layout/
    people/
    ...

// by type
app/
    controllers/
    services/
    views/    
```

by feature lends better to modularity

### The LIFT Principle

(In order or importance)
*L* Locating code is easy
*I* Identify the code at a glance; looking at a filename should quickly explain what it does
*F* Flat; keep the application as flat as possible; only as deep as you need
*T* Try to no repeat yourself (session.html vs session-view.html since the extension implie's its a view)


## Modularity in Angular

Good to break an app into many modules such that they are more reusable as opposed to building one big monolithic application

### Defining Multiple Module Dependencies

each module can be an app, services, or widgets (custom directives)
modules often depend on other modules

modules are just contains for AngularJS components

module getter/setter:
```js
// setter
var setApp = angular.module('myModule', [/* dependencies */]);

// getter
var getApp = angular.module('myModule');
```

example of creating smaller modules and adding them as dependencies to a larger, overall module:
```js
// sub modules, each of which can
// utilize there own dependencies
angular.module('subModule1',, []);
angular.module('subModule2',, []);
angular.module('subModule3',, []);

// overall module
angular.module('wholeApp', [
    // Angular Modules
    ...,

    // 3rd Party Modules
    ...,

    // Custom Modules
    'subModule1',
    'subModule2',
    'subModule3'
]);
```

modules can be thought of as 3 categories:
- AngularJS Modules: provided by the angular framework
- 3rd Party Modules: vendor modules taken from outside the project
- Custom Modules: modules that are written in the project

when breaking modules into packages, good to keep the actual definition of the module in a separate file completely so it's easy to consume, can name it `myModule.module.js` so it's clear what it is

## Declaring Controllers without an App on the Global Namespace

don't want to pollute the global namespace, so can use an `IIFE` and an angular module getter:

```js
// NOTE: controller name is 'myController' and it 
// is a part of the 'myModule' module.

// IIFE prevents pollution of global namespace
(function() {
    
    // get the module, and immediately bind
    // a controller to it
    angular
        .module('myModule')
        .controller('myController', MyController);

    // can bind services to controller function like this
    // instead of passing an array to 'angularModule.controller's
    // second argument
    MyController.$inject = [/* inject services here */];

    // controller logic can come last if declared
    // as a function (due to hoisting)
    function MyController(/* place injected services here */) {
        // controller logic; a good structure for this
        // is to place all the parameters that are going 
        // to be exposed at the top of the file, and then
        // define them further down. This makes it easier
        // to get an idea of what the controller has on it
        // at a glance, and then quickly search and find any
        // item on it

        // quickly shows all values on the controller
        // (this is using 'Controller as' syntax; could
        // also have used '$scope' instead of 'this')

        // this is pretty common to avoid issues using 'this'
        // within function calls
        var vm = this;

        vm.someVar = 'foobar';
        vm.otherVar = false;
        vm.someFunc = someFunc;
        vm.otherFunc = otherFunc;

        Object.defineProperty(vm, 'getterProp', { get: getterProp });

        // definitions of the above values, which will
        // be hoisted
        function someFunc() {
            // some code
        }

        function otherFunc() {
            // some code
        }

        function getterProp() {
            // some code
        }

    }

}());
```

adding a watch with "Controller as" syntax:

```js
...
var vm = this;

vm.title = 'The Title';

$scope.$watch(function() {
    return vm.title;
}, function(newVal, oldVal) {
    // some code that runs on change of
    // the above value
});
```

can specify "Controller as" from the configuration of a route, and can also use the property `resolve` within `config` to bind variables to the controller. These will be received by specifying the name of the return value as a service on the controller:

```js
// example route
{
    url: '/some-path',
    config: {
        templateUrl: '/path/to/template.html',
        title: 'Some Title',
        controller: 'MyController',
        controllerAs: 'vm',
        resolve: {
            // 'someVal' will be available on 'MyController'
            // as a service that can be inject. 'someVal.prop' 
            // will be equal to 'value'. Keep in mind that
            // resolve can only be used when the 'Controller as'
            // is specified from the route. It will not work
            // if specified from the template. Can also inject
            // services (such as $q if it's an async call) into
            // these values
            someVal: function(/* injected services */) {
                return { prop: 'val' }
            }
        }
    }
}
```

can also use "resolveAlways" to add a resolved value to every route.
