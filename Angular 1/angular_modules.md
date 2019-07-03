# Angular Modules

## Overview
this list details common angular modules that require an external script to import

---
## $resource

### Overview
[link](https://code.angularjs.org/1.5.11/docs/api/ngResource/service/$resource)

`$resource` is a factory which creates a resource object that lets you interact with RESTful server-side data sources

keep in mind that starting in Angular 1.4, even resources declared with `$resource` must be same-origin. To use cross-origin services, need to interact with `$sce` and whitelist as needed.

by default, trailing slashes will be stripped from the calculated URLs. To avoid this behavior, include the following:

```js
// $resourceProvider is a service from the $resource module
app.config(['$resourceProvider', function($resourceProvider) {
    $resourceProvider.defaults.stripTrailingSlashes = false;
}]);
```

---
### Dependencies
- `$http`
- `$log`
- `$q`
- `$timeout`

---
### Usage
`$resource(url, [paramDefaults], [actions], options)`

- `url` (required)
    - type: `string`
    - a parameterized URL template with parameters prefixed by `:`. Port numbers will be respected; they're the exception to this behavior. Parameters will be taken from either `paramDefaults` or upon calling the resource. Params not given will collapse
- `paramDefaults` (optional)
    - type: `Object`
    - default values for `url` parameters. Will be overriden in invocations of the methods outlined in `actions`, if applicable. Keys are bound to the matching parameter in the URL template, and if excess they are bound as wuery strings
    - for example:
    ```js
    // URL template
    "/path/:verb"

    // params
    { verb: 'greet', greeting: 'hello' }

    // reuslt
    "/path/greet?greeting=hello"
    ```
    - if the parameter is prefixed with `@`, then the value for that parameter will be extracted from the corresponding property of the `data` object. `@` declared params will be ignored for `GET` methods, as they have no data property
    - example: `{ someProp: '@someProp' }` will be taken from `data.someProp`
- `actions` (optional)
    - hash with declaration of custom actions that should extend the default set of resource actions. Same as the format of `$http.config`:
    ```js
    { 
        action1: { method: ?, params: ?, isArray: ?, headers: ?, ... } },
        action2: { method: ?, params: ?, isArray: ?, headers: ?, ... } },
        ...
    }
    ```
        - `action` (`string`) represents the name of the method on the resource object that will corresponding to the action
        - `method` (`string`) case insensitive HTTP method
        - `params` (`object`) optional set of pre-bound parameters for the action. If any value is a function, it will be invoked everytime the action is called
        - many other parameters to use as needed
- `options` (required)
    - type: `object`
    - hash with custom settings that should extend the default `$resourceProvider` behavior
        - `stripTrailingSlashes` (`boolean`) if true, the the trailing slashes from any calculated URL will be stripped (true by default)
        - `cancellable` (`boolean`) if `true`, allows for the call to be canceled via `$cancelRequest` on the call's return value

---
### Returns
returns an `object` with methods for the default set of resource actions optionally extended with custom `actions`, as seen above

The default actions are:
```js
{ 'get':    {method:'GET'},
  'save':   {method:'POST'},
  'query':  {method:'GET', isArray:true},
  'remove': {method:'DELETE'},
  'delete': {method:'DELETE'} };
```

calling these methods invokes `$http` with the specified http method, destination, and parameters.

example call of a resource object; note that the `userId` param will look for an `id` prop in the data due to the `@` prefix, but because this is a get request it must be in the params (get requests have no data):
```js
var User = $resource('/user/:userId', {userId:'@id'});
var user = User.get({userId:123}, function() {
    user.abc = true;

    /**
        save, remove, and delete actions are available of the
        return object of the resource action so that CRUD operations
        can quickly be performed served side. For exmaple, this will
        attempt to save the altered user object to /user/123
    */
  user.$save();
});
```

invocation of action methods:
- HTTP GET "class" actions: `Resource.action([parameters], [success], [error])`
- non-GET "class" actions: `Resource.action([parameters], postData, [success], [error])`
- non-GET instance actions: `instance.$action([parameters], [success], [error])`

---
### Examples

#### Credit Card Resource
```js
// Define CreditCard class
var CreditCard = $resource('/user/:userId/card/:cardId',
 {userId:123, cardId:'@id'}, {
  charge: {method:'POST', params:{charge:true}}
 });

// We can retrieve a collection from the server
var cards = CreditCard.query(function() {
  // GET: /user/123/card
  // server returns: [ {id:456, number:'1234', name:'Smith'} ];

  var card = cards[0];
  // each item is an instance of CreditCard
  expect(card instanceof CreditCard).toEqual(true);
  card.name = "J. Smith";
  // non GET methods are mapped onto the instances
  card.$save();
  // POST: /user/123/card/456 {id:456, number:'1234', name:'J. Smith'}
  // server returns: {id:456, number:'1234', name: 'J. Smith'};

  // our custom method is mapped as well.
  card.$charge({amount:9.99});
  // POST: /user/123/card/456?amount=9.99&charge=true {id:456, number:'1234', name:'J. Smith'}
});

// we can create an instance as well
var newCard = new CreditCard({number:'0123'});
newCard.name = "Mike Smith";
newCard.$save();
// POST: /user/123/card {number:'0123', name:'Mike Smith'}
// server returns: {id:789, number:'0123', name: 'Mike Smith'};
expect(newCard.id).toEqual(789);
```

### Creating a Custom "PUT" Request
```js
var app = angular.module('app', ['ngResource', 'ngRoute']);

// Some APIs expect a PUT request in the format URL/object/ID
// Here we are creating an 'update' method
app.factory('Notes', ['$resource', function($resource) {
return $resource('/notes/:id', null,
    {
        'update': { method:'PUT' }
    });
}]);

// In our controller we get the ID from the URL using ngRoute and $routeParams
// We pass in $routeParams and our Notes factory along with $scope
app.controller('NotesCtrl', ['$scope', '$routeParams', 'Notes',
                                   function($scope, $routeParams, Notes) {
// First get a note object from the factory
var note = Notes.get({ id:$routeParams.id });
$id = note.id;

// Now call update passing in the ID first then the object you are updating
Notes.update({ id:$id }, note);

// This will PUT /notes/ID with the note object in the request payload
}]);
```

---
## $route

provides routing and deeplinking services in angular js applications

### Directives

`ngView`

### Provider

`routeProvider`

### Services

`route`
`routeParams`

### Methods

`reload()` forces the current route to reload, reinstantiating the controller and generating a new scope

`updateParams(newParams)` causes the route service to update it's parameters with those specified in `newParams`. Will match the url template and then fill out as query strings

### $routeProvider

Configure routes using the method `when(path, route)` 

`path` is a url template, with a few key features:

- `:name` is used to define a route parameter
- `:name?` is used to define an optional route paramter
- operators such as `*` and escaping are also allowed, giving way to complex schemas like below:

`/color/:color/largecode/:largecode*\/edit` 

will match 

`/color/brown/largecode/code/with/slashes/edit` 

and extract:

- `color: brown`
- `largecode: code/with/slashes`

which can both be found on the `routeParams` service

`route` contains all the information about what should occur upon matching a given url template, and comes with the following properties:

- `controller` name of a registered controller to be used, or a controller function
- `controllerAs` name of the controller to be published under the scope
- `template` string/function representing the template to be rendered
- `templateUrl` path to the html template to be used for the controller
  - required to use *one* of `template` or `templateUrl`
- `resolve` an optional map of variables to bind to the controller upon routing. Can involve promises. Will override existing variables on the controller's scope with the same name. Retrieved as a service by the controller. The map object has the following structue:
  - *key - string* name of the dependency to be injected into the controller
  - *factory - {string|Function}* string is an alias for a service; if a function, then it is injected and the return value is treated as the dependency.
- `resolveAs` the name under which the resolve map will be available on the scope of the route. If omitted, defaults to $resolve.
- `redirectTo` value to update $location path with and trigger route redirection
- `caseInsensitiveMatch` if set to `false`, will ignore case when attempting to match route

`otherwise(params)` is used when no other route is matched (404)

can also set `caseInsensitiveMatch` globally (a a property of `$routeProvider`) to ignore case on all routes





