# Angular 1 Notes

## Overview
Angular is used to create responsive websites that use `directives` to bind javascript functionality (`Controllers`) to the html

## Structure
public angular variables are prefixed with `$`, and private angular variables are prefixed with `$$`. Do not prefix custom variables with these (to avoid collisions)

## Modules
Modules are simple to create:

`var app = angular.module('<module name>', ['<dependencies>'])`

modules are added to a page by attaching `ng-app` to the html tag:

`<html ng-app="<module name>">`

the module itself will be found in something like an `app.js` file which will need to be included on the page

## Expressions
can drop js expressions directly into the html to be evaluated:

```
<p>
    I am {{ 10 + 11 }}
</p>
<!-- Evaluates too... -->
<p>
    I am 21
</p>
```

## Controllers
creating a controller:

```
app.controller('<Controller Name>', function() {
    this.<property> = <some value>
})
```

it's important to note that `<Controller Name>` should always be Pascal case and contain the word `Controller`

controllers are attached to html via directives:

```
<!-- alias is optionally, and the syntax on aliases is camelcase -->
<div ng-controller="<Controller Name> as <alias>">
    <!-- Can then use expressions to pull things off the controller -->
    {{ <alias>.<property> }}
</div>
```

full example:
```
// app.js
<!-- index.html -->
<div ng-controller="StoreController as store">
    {{ store.product.name }}
    {{ store.product.price }}
</div>
```

## Interpolation
`{{ }}` handlebar syntax is for interpolation; when passing full objects around, it is undesirable to attempt to interpolate them and insert them directly into the html. Therefore, the handlebars are dropped when dealing with entire objects (also note that functions are objects)

*QUESTION:* what about nested objects? example:
```js
var obj = {
    foo: {
        bar: 'foobar'
    }
}
```

```html
<!-- This -->
<div foobar="{{ foo.bar }}"></div>
<!-- Or this? Or something else entirely? -->
<div foobar="foo.bar"></div>
```

## Services, Providers, and Factories

### Overview

All of these are different methods of creating services in AngularJS. Basically factories and services do the same thing, just in different ways, whereas providers are for use in configuration of a module.

see more [here](https://tylermcginnis.com/angularjs-factory-vs-service-vs-provider/)

### Factories

A Factory creates an object, binds properties to it, and then returns the same object. Passing this service to a controller will all for it's properties to be added to the controller via the factory:

```js
app.controller('myFactoryCtrl', function ($scope, myFactory) {
  $scope.artist = myFactory.getArtist();
});

app.factory('myFactory', function () {
  var _artist = '';
  var service = {};

  service.getArtist = function () {
    return _artist;
  }

  return service;
});
```

### Services

When you’re using Service, it’s instantiated with the ‘new’ keyword. Because of that, you’ll add properties to ‘this’ and the service will return ‘this’. When you pass the service into your controller, those properties on ‘this’ will now be available on that controller through your service.

```js
app.controller('myServiceCtrl', function ($scope, myService) {
  $scope.artist = myService.getArtist();
});

app.service('myService', function () {
  var _artist = '';
  this.getArtist = function () {
    return _artist;
  }
});
```

### Providers

Providers are the only service you can pass into your .config() function. Use a provider when you want to provide module-wide configuration for your service object before making it available.

```js
app.controller('myProviderCtrl', function ($scope, myProvider) {
  $scope.artist = myProvider.getArtist();
  $scope.data.thingFromConfig = myProvider.thingOnConfig;
});

app.provider('myProvider', function () {
  this._artist = '';
  this.thingFromConfig = '';

  //Only the properties on the object returned from $get are available in the controller.
  this.$get = function () {
    var that = this;
    return {
      getArtist: function () {
        return that._artist;
      },
      thingonConfig: that.thingFromConfig
    }
  }
});

app.config(function (myProviderProvider) {
  myProviderProvider.thingFromConfig = 'This was set in config()';
});
```

## angular properties and methods

`copy(source, [destination])` creates a deep copy of `source`, which should be either an object or an array