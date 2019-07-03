# Angular 1 - Udemy

## Overview
angular has an MV* structure; it allows models and view to be bound to anything. Typically, `models` are bound to `views` by `controllers`

## HTML Aside 1 - Custom Attributes
custom attributes will be accepted by html, but the browser won't do anything with them. The can be retrieved via js, which is what angular does for its custom attributes.

The HTML 5 spec does view attributes proceeded by `data-` as valid.

Angular uses multiple custom attributes, all proceeded by `ng-`; angular will also allow `data-ng-` if you're a stickler for the HTML 5 spec

## Javascript Aside 1 - Dependency Inject
Passing an object to a function instead of creating the object WITHIN the function. This allows for the object to be created in any way, without the function having to construct it in one specifc way

```js
// BAD
var Person = function(first, last) {
    this.first = first;
    this.last = last;
}

function logPerson() {
    var john = new Person('John', 'Doe');
    console.log(john);
}

logPerson();

// GOOD
var Person = function(first, last) {
    this.first = first;
    this.last = last;
}

function logPerson(person) {
    console.log(person);
}

var john = new Person('John', 'Doe');
logPerson(john);
```

## Angular Services in General
angular services are given to a controller as dependencies; even if dependencies aren't explicitly provided, angular will convert the function argument into a string and parse the arguments it's taking to see if it requires any services. For example, the following will get the `$scope` even if though isn't explictly passed:

```js
angularApp.controller('mainController', function($scope) {
    // $scope will be the $scope angular service,
    // even though it isn't explicitly added as a
    // dependency
});
```

the angular `injector` can be used to breakdown function arguments if desired for some reason:

`angular.injector().annotate(<function name>)` (will return an array of the names of a function's args)

## The Scope Service
found in the `$sope` property (all angular js services start with a `$`)

scope is what ties the data in the js controller to the html view

anything bound to `$scope` in a controller will be added to the context available in the html. 

For example:

`$scope.name = 'Trey' // in the controller` 

can be accessed from the html by:

`{{ name }} <!-- In the HTML -->`

notice how `<controller name>.name` nor `$scope.name` needs to be called

## The Timeout Service

```js
$timeout(function() {
    // do something
}, numMilliseconds);
```

changing `$scope` within timeout will cause the block to rerender

## Directives
an instruction to AngularJS to manipulate a piece of the DOM

### Common Directives
- `ng-if` takes a js expression, and only renders the component if the statement evaluates to true
- `ng-show` similar to `ng-if`, except will still render the component, and just not display it (by adding `ng-hide` as a class, which is just `display:none`)
- `ng-hide` is the inverse of `ng-show`
- `ng-class` takes an object of css classes (the keys) to add based on expressions (the values)
    - example:
    - `ng-class="{ 'blue': foo === bar }"` if `foo` is equal to `bar` (both variables on `$scope`), then add the class `blue` to the component
- `ng-repeat` works like a `for in` loop, iterating over an array variable
    - example:
    - `<li ng-repeat="foo in foos">{{ foo.bar }}</li>` iterates over array `foos` and creates an `li` with text `foos[index].bar` for each index
- `ng-click` takes a function, and triggers it on click (the function is called within `ng-click`, so it's `foobar()` *NOT* `foobar`)
- `ng-cloak` will hide an element in the DOM untils it's variables load
    - example:
    - `<div ng-cloak>{{ foobar }}</div>` will not show until `foobar` has loaded (prevents the user from seeing `{{ foobar }}` instead of its actually value on load)

### $http
for requesting data the angular way

Methods:
- `.get`
- `.post`
- `.delete`
- `.put`
- `.success` takes a function with 1 arg `result` that will run on success
- `error` take a function with 2 args, `data` and `status`, that will run on error

syntax is similar to `axios`:

```js
$http.get('/endpoint')
    .success(function(result) {
        $scope.foobar = result    
    })
    .error(function(data, status) {
        // do something
    });
```



## Angular Context
works very similar to React; Angular binds "watchers" to objects in the DOM, and fires events on actions occuring. It will then automatically update anything connected to what changes.

watchers basically work like reducers; any time an event is fired, the digest cycle runs and sends every watcher associated with the object changing the new value

`$appply` can be used to change the scope _outside_ of the scope of angular services; for example, instead of using the `$timeout` service, `$scope.$apply`can be used with `setTimeout`

```js
// using angular services
$timeout(function() {
    $scope.foo = 'bar'
}, 3000);

// without angular services
setTimeout(function() {
    $scope.$apply(function() {
        $scope.foo = 'bar';
    });
}, 3000);
```

## Javascript and HTML Aside 3 - Single Page Apps and Hashes
can navigate to an `id` on a page using a `hashe`. For example, appending `#id` to the url will bounce the page to the `id` element. This event can be monitored in js using the `hashchange` event. Setting the hash to an element that doesn't exist will still trigger the `hashchange` event, but the page just won't move; can check this hash's value and run some logic accordingly:

```js
window.addEventListener('hashchange', function() {
    if (window.location.hash === 'foobar') {
        // do something
    };
});
```

could even set the hash to something like a file path:

`#/some/fake/path/`

## Single Page Applications in Angular

### Routing
import `angular-router` and add `ngRoute` to the app's dependecies to make routing functionality available

```js
myApp.config(function($routeProvider) {
    
    $routeProvider
        .when('<path>', {
            templateUrl: 'pages/<some file>.html',
            controller: '<controller name>'
        })
        // query scrings can be accessed from a controller
        // by injecting $routeParams and getting a property
        // whose name is the same as <query string>
        .when('<another path>/:<query string>', {
            templateUrl: 'pages/<another file>.html',
            controller: '<another controller name>'
        });

});
```

use the `ng-view` directive to insert an HTML chunk into a page upon routing

angular router navigates using `hashes`

every controller has a clean `$scope`

### Javascript and Angular Aside - Singletons and Services
a singleton is the one and only copy of an object (only one copy is possible). All angular js services are implemented as singletons

`$scope` is the one exception to this rule since a new instance is created for each controller

### Custom Services
create a new service with `app.service`:

```js
app.service('<service name>', function() {
    // some code
});
```

keep in mind that custom services are made into singletons by angular, and are injected into controllers in the same way as any other service.

*QUESTION:* do custom services require the use of `$scope.apply` or does the service creation process handle this? For example, would using a `setTimeout` inside a custom service work straight up or would it require a `$scope.apply` wrapper?

can use a custom service to pass data bewteen controllers by changing a variable on the service; this works because the service is a singleton, so the value will persist between controllers.

can monitor a value on `$scope` using `$watch`:
```js
$scope.$watch('name', function() {
    // do something when $scope.name changes
});
```

Can use a custom service to mimic the functionality of redux, since it's a singleton, so it's values will be the same across any controller accessing it

## Javascript and Angular Aside 2 - Variable Names and Normalization
Angular will normalize properties on a custom tag from kebab-case in HTML to camelCase in js:

HTML:
```html
<custom-component my-property='something'>
```

Javascript:
```js
var myProperty // equals something
```

## Creating Custom Directives
create a new directive using `app.directive`. The name of the directive will be normalized between the HTML and js

```js
app.directive('customDirective', function() {
    return {
        restrict: 'AECM', // restricts how the directive can be called (AE by default)
        template: '<html string to use as the component template structure>',
        replace: true, // defaults to false, which will show the normalize directive name in the html. setting to true will replace the custom directive tag with the actual html
    };
});
```

```html
<!-- Respected by Default -->
<!-- E: Element -->
<custom-directive></custom-directive> 
<!-- A: Attribute -->
<div search-result></div>

<!-- NOT respected by default -->
<!-- C: Class -->
<div class="search-result"></div>
<!-- M: Comment -->
<!-- directive: search-result -->

```

setting replace to `true` will replace either of the tags show below. The deault of `false` will place the template code _within_ the tag

can also reference a template from a file (praise the lord). Just use `templateUrl` instead of `template`:

`templateUrl: 'path/to/directive.html'`

## Two-Way Bindings - Scope and Obtuse Symbols

a directive (custom or otherwise) will have access to anything available on the scope of the parent controller. 

This can be dangerous because there can be accidental manipulations of the controller's scope from a child directive. 

Can do what's called "isolating the scope" by adding a `scope` key with a value of `{}` to the return of the directive to prevent this behavior (this will override the default scope of the directive, which is the parent controlle's scope)

can pass parts of the parent controller's scope by using *obtuse symbols*; in the following example, the custom direction is `myDirective` and the value we want from the controller's scope is `foo.bar`:

in the instance of the directive
```html
<my-directive foo-bar="{{ foo.bar }}"></my-directive>>
```

in the definiteing of the custom directive
```js
return {
    ...
    scope: {
        // note that normalization occurs
        fooBar: '@' // the @ symbol means the value of foo.bar is text

        // alternatively, can also change the name of the variable for
        // use in the directive
        otherFoobar: '@fooBar'
    },
    ...    
}
```

in the template of the directive
```html
<!-- with first scope definition -->
{{ fooBar }}

<!-- with second scope definition -->
{{ otherFoobar }}
```

in summary, to pass a variable _safely_ and _explicitly_ from the controller's scope to a child directive:

1. attach variable to controller scope  
2. define custom attribute on the instance of the custom directive, and set its value using the desired value from the controller's scope
3. define a scope property on the custom directive's definition, and add the normalized name of the custom attribute as a key, and set the value equal to the obtuse symbol that corresponds to the data type of the value (the type of hole that is being poked):
    - `@` text
    - `=` object (*DON'T* interpolate object in the directive instance; aka drop the handlebars)
    - `&` functions (also don't interpolate)
4. use the value from the directive's scope within its associated template

it's best to _not_ try to change the controller's scope from a custom directive

two way function binding example:

in the controller:
```js
$scope.person = {
    first: 'John',
    last: 'Doe'
}

$scope.getFullName = function(person) {
    return person.first + ' ' + person.last;
};
```

in the directive instance:
```html
<!-- 
    getFullName is the name of the method, and person is the 
    name of the parameter that will be mapped to when calling
    the function from the directive template (has no connection
    with the person value on the scope, it's just a placeholder)
-->
<my-directive person-object="person" full-name-function="getFullName(person)"></my-directive>
```

in the directive definition:
```js
scope: {
    personObject: '=',
    fullNameFunction: '&'
}
```

in the directive template:
```html
<!-- 
    requires an object map that tells angular what to
    use as each of the arguments to the function; so
    in this case, use "personObject" from the directive's
    scope as the value of the "person" argument as set forth
    by the binding in the directive instance
 -->
{{ fullNameFunction({ person: personObject }) }}
```

## Compilation in Angular
*compilers* covert code to a lower-level language, the the *linker* generates a file the computer will actually interact with.

Angular doesn't _really_ do either of these

custom directives compile once, and then run pre/post link for each instance, each time with a different scope. The structure of compilation is as follows, and adding this property in the definition of a custom directive will allow changes to be enacted at any time in the process:

```js
// this will only run once
compile: function(elem, attrs) {
    // compile defines the html template to be used by 
    // pre and post link, and ultimately what will be 
    // rendered on the screen. Can make descisions here 
    // and propagate them across all instances

    // "elem" is a standard js node, and can be change
    // on the fly as desired
    return {
        // these will run for each instance

        // pre link will run and link up any nested directives. 
        // This will run all the way down the chain, and then
        // post link will run back up the chain
        // ANGULAR MAKES PRE LINK ACCESSIBLE BUT SAYS IT IS
        // NOT SAFE TO USE. USE POST LINK INSTEAD. (it's safe
        // to return an object from "compile" without "pre" 
        // defined)
        pre: function(scope, elements, attrs) {
            // can change the scope, html, etc. as
            // each individual instance is being rendered
        },

        // post link is "safer" than pre link, because at
        // this point the entire chain of directives is
        // known
        post: function(scope, elements, attrs) {
            // can change the scope, html, etc. as
            // each individual instance is being rendered
        }   
    }
}
```

can also skip the compile part (since it'll almost never ne needed) and just include a definition for `post`:

```js
link: function(scope, elements, attrs) {
    // postlink code
}
```

keep in mind that any code in `link` or `post` needs to be optimized for performance to avoid slowing down the page

## Transclusion
including one document inside another; to place a copy of one document at a particular point inside another

transclusion in angular js typically refers to child elements added to an instance of a custom directive; by default, since the custom directive will be replaced the html specified in the associated template, the children will not be shown. With transclusion, this is possible:

the directive definition:
```js
// must tell the directive to allo transclusiong
...
transclude: true // false by default
...
```

the directive instance:
```html
<my-directive>
    Some additional text
</my-directive>
```

the directive template:
```html
...
<!-- the children will be nested in this tage -->
<ng-transclude></ng-transclude>

<!-- or can nest content into a custom element -->
<span ng-transclude></span>
...
```

## Bonus Lecture - 3

### Nested Controllers
controllers can be nested, and form a scope chain just like normal js. For example, if a child is looking for a variable and can't find it on it's own scope, it will work it's way up to scope chain through parent scopes to attempt to find it.

can also reference a parent scope's variables from a child's interpolation using `$parent`; alternatively, could also use `Controller as` syntax to make things a little cleaner.

with `Controller as` syntax, can bind variable to `this` and just ditch `$scope` altogether. This syntax still allows for two-way binding, just as `$scope` does. Only functionality lost is custom watchers (`$scope.$watch`).