# Angular Services

## Overview
Services are utilized by controllers to add functionality to the DOM. Do not require the use of `$scope.apply`, as this is provided as a wrapper on angular services.

---
## $anchorScroll
scrolls to an element corresponding to the given `hash`, or to `$location.hash`if no arguments are given. Best way to use seems to be to call `$location.hash`with an argument of the `id` of an element on the page, and then invoke `$anchorScroll` with no arguments:

```js
var app = angular.module('anchorScrollExample', []);

app.controller('ScrollController', ['$scope', '$location', '$anchorScroll', function($scope, $location, $anchorScroll) {
    // calling this function will scroll the page
    // to '<element id>'
    $scope.scrollToBottom = function() {
        $location.hash('<element id>');
        $anchorScroll();
    };
}]);
```

can also set a global offset for `$anchorScroll` (the `app.run` syntax below means the offset will be applied everytime `$anchorScroll` is called)

```js
app.run(['$anchorScroll', function($anchorScroll) {
    // anytime $anchorScroll is called, add an extra 50px
    $anchorScroll.yOffset = 50;
}]);
```

note that changing `$location.hash` will automatically call `$anchorScroll`. `$anchorScroll` only needs to be explicitly called when `$location.hash` changes (the current value of `location.hash` can be retrieved by calling it with no arguments)

### Properties
- `yOffset` specifies a vertical scroll-offset. can be specified in various ways:
    - *number* a number of pixels
    - *function* a getter function called everytime `$anchorScroll` is called. Must return a number representing the desired offset (in pixels)
    - *jqLite/jQuery* a `jqLite`/`jQuery` element to specify the offset, which will be the distance from the top of the page to the bottom of the element (the element will only be taken into account while the `position` is `fixed`)

---
## $animate

---
## $animateCss

---
## $templateCache

---
## $compile
seen in custom directives (see in `udemy_notes.md`)

---
## $controller
responsible for instantiating controllers

---
## $document
a wrapper for the browser's `window.document` object

---
## $exceptionHandler

---
## $filter
[link](https://docs.angularjs.org/api/ng/service/$filter)

filters are used for formatting data displayed to the user. Can be used in templates, services, or controllers.

template syntax:
```html
{{ express | filter_name[:parameter_value] ... }}
```

js syntax:
```js
// name is the name of the filter to utlizer;
// this returns a function to be called on the
// value attempting to be manipulated; it's a
// decorator
$filter(name)
```

### Built-in Filters

#### filter
selects a subset of items from an array

in html:
`{{ filter_expression | filter : expression : comparator : anyPropertyKey}}`

in js:
`$filter('filter')(array, expression, comparator, anyPropertyKey)`

parameters:
- `array` the source array
- `expression` the predicate used form selecting items from the array. Can be a `string`, `object`, or `function`. `function` filters adhere to the following format, and are used to create arbitrary filters: `function(value, index, array)`
- `comparator` defaults to false, and is used to determine if the expected value vs the accepted value should be considered a match. Can be a `function` or a `boolean`. 
- `anyPropertyKey` The special property name that matches against any property. By default $.

example:
```html
<div ng-init="friends = [{name:'John', phone:'555-1276'},
                         {name:'Mary', phone:'800-BIG-MARY'},
                         {name:'Mike', phone:'555-4321'},
                         {name:'Adam', phone:'555-5678'},
                         {name:'Julie', phone:'555-8765'},
                         {name:'Juliette', phone:'555-5678'}]"></div>

<label>Search: <input ng-model="searchText"></label>
<table id="searchTextResults">
  <tr><th>Name</th><th>Phone</th></tr>
  <tr ng-repeat="friend in friends | filter:searchText">
    <td>{{friend.name}}</td>
    <td>{{friend.phone}}</td>
  </tr>
</table>
<hr>
<label>Any: <input ng-model="search.$"></label> <br>
<label>Name only <input ng-model="search.name"></label><br>
<label>Phone only <input ng-model="search.phone"></label><br>
<label>Equality <input type="checkbox" ng-model="strict"></label><br>
<table id="searchObjResults">
  <tr><th>Name</th><th>Phone</th></tr>
  <tr ng-repeat="friendObj in friends | filter:search:strict">
    <td>{{friendObj.name}}</td>
    <td>{{friendObj.phone}}</td>
  </tr>
</table>
```

#### currency 
formats a number as a currency; if no currency symbol is provided, defaults to whatever the current locale would most likely be using.

html:
`{{ currency_expression | currency : symbol : fractionSize}}`

js:
`$filter('currency')(amount, symbol, fractionSize)`

params:
- `amount` input to filter
- `symbol` currency symbol to use; defaults to current locale
- `fractionSize` number of decimal places to round to; defaults to current locale

#### number
formats a number as text

html:
`{{ number_expression | number : fractionSize}}`

js:
`$filter('number')(number, fractionSize)`

params:
- `number` number to format
- `fractionSize` Number of decimal places to round the number to. If this is not provided then the fraction size is computed from the current locale's number formatting pattern. In the case of the default locale, it will be 3.

#### date
formats a given date (`date` object, time is ms, etc.) to a `string` based on the format given:

see [here](https://docs.angularjs.org/api/ng/filter/date) for a list of date formats.

html:
`{{ date_expression | date : format : timezone}}`

js:
`$filter('date')(date, format, timezone)`

params
- `date` date to format
- `format` format to display the date in; defaults to `mediumDate` format
- `timezone` the timezone to be used for formatting

#### json
Allows you to convert a JavaScript object into JSON string; mainly for debugging

html:
`{{ json_expression | json : spacing}}`

js:
`$filter('json')(object, spacing)`

#### lowercase
converts to lowercase

html:
`{{ lowercase_expression | lowercase }}`

js:
`$filter('lowercase')()`

#### uppercase
converts to uppercase

html:
`{{ uppercase_expression | uppercase }}`

js:
`$filter('uppercase')()`

#### limitTo
Creates a new array or string containing only a specified number of elements. The elements are taken from either the beginning or the end of the source array, string or number, as specified by the value and sign (positive or negative) of limit. Other array-like objects are also supported (e.g. array subclasses, NodeLists, jqLite/jQuery collections etc). If a number is used as input, it is converted to a string.

html:
`{{ limitTo_expression | limitTo : limit : begin}}`

js:
`$filter('limitTo')(input, limit, begin)`

params:
- `input` Array/array-like, string or number to be limited.
- `limit` The length of the returned array or string. If the limit number is positive, limit number of items from the beginning of the source array/string are copied. If the number is negative, limit number of items from the end of the source array/string are copied. The limit will be trimmed if it exceeds array.length. If limit is undefined, the input will be returned unchanged.
- `begin` index at which to begin limitation. As a negative index, begin indicates an offset from the end of input. Defaults to 0.

#### orderBy
Returns an array containing the items from the specified collection, ordered by a comparator function based on the values computed using the expression predicate.

html:
`{{ orderBy_expression | orderBy : expression : reverse : comparator}}`

js:
`$filter('orderBy')(collection, expression, reverse, comparator)`

params:
- `collection` The collection (array or array-like object) to sort.
- `expression` A predicate (or list of predicates) to be used by the comparator to determine the order of elements.
- `reverse` If `true`, reverse the sorting order.
- `comparator` The comparator function used to determine the relative order of value pairs. If omitted, the built-in comparator will be used.

---
## $httpParamSerializer

---
## $httpParamSerializerJQlike

---
## $http
[link](https://docs.angularjs.org/api/ng/service/$http)

Works via the browser's native `XMLHttpRequest` module or via `JSONP`. `JSONP` is "JSON with Padding" and is used to make requests from domains other than the client. `XMLHttpRequest` can only make same-domain requests.

Unit tests for the `$http` service can be done with the `$httpBackend` mock.

`$http` is built upon deferred/promise libraries from the `$q` service.

structure:
```js
$http({
    url: '/example-endpoint'
    method: 'GET'
}).then(function successCallback(response) {
    // invoked on a successful request
}, function errorCallback(response) {
    // invoked if the request encounters an error
});
```

`response` structure:
- *data* – {string|Object} – The response body transformed with the transform functions.
- *status* – {number} – HTTP status code of the response.
- *headers* – {function([headerName])} – Header getter function.
- *config* – {Object} – The configuration object that was used to generate the request.
- *statusText* – {string} – HTTP status text of the response.

A response status code between 200 and 299 is considered a success status and will result in the success callback being called. Any response status code outside of that range is considered an error status and will result in the error callback being called.

shortcut methods are also available if desired:
```js
$http.get('/example-url', config).then(successCallback, errorCallback);
$http.post('/example-url', data, config).then(successCallback, errorCallback);
```

list of shortcut methods:
- `$http.get`
- `$http.head`
- `$http.post`
- `$http.put`
- `$http.delete`
- `$http.jsonp`
- `$http.patch`

when writing unit tests with `$http`, must use `$httpBackend` and invoke `flush` after each call:

```js
$httpBackend.expectGET(...);
$http.get(...);
$httpBackend.flush();
```

*IMPORTANT*
jsonp requests are used for cross-origin requests, as they are not `XMLHttpRequest`s, which are only for same-origin requests. In order to make a cross origin request, the url must be declared via `$sce`. Can do this explicitly by calling `$sce.trustAsResourceUrl(url)` or can set the whitelist earlier in the application using: `$sceDelegateProvider.resourceUrlWhitelist`. Must also specify the name of the callback to be used by the jsonp request: `$http.jsonp('example-url', {jsonpCallbackParam: 'callback'})`

_You can no longer use the JSON_CALLBACK string as a placeholder for specifying where the callback parameter value should go._

---
## $xhrFactory
used to make custom `XMLHttpRequest` objects

---
## $httpBackend
used to make mock calls for unit testing

---
## $interpolate
interpolates strings with markup. Useful for unit testing

---
## $interval
angular wrapper for `window.setInterval`

---
## $jsonpCallbacks

---
## $location

---
## $log
safer than `console.log`.

methods:
- `log`
- `info`
- `warn`
- `error`
- `debug`

---
## $parse
converts an angular expression into a function

exmaple:
```js
var getter = $parse('user.name');
var setter = getter.assign;
var context = {user:{name:'AngularJS'}};
var locals = {user:{name:'local'}};

expect(getter(context)).toEqual('AngularJS');
setter(context, 'newValue');
expect(context.user.name).toEqual('newValue');
expect(getter(context, locals)).toEqual('local');
```

---
## $q
helps you run functions asynchronously (is angular's promise library)

example of using `$q`:

```js
// for the purpose of this example let's assume that variables `$q` and
// okToGreet` are available in the current lexical scope (they could have been
// injected or passed in).

function asyncGreet(name) {
  // perform some asynchronous operation, resolve or reject the promise when
  // appropriate.
  return $q(function(resolve, reject) {
    // will wait 1s and then resolve/reject the promise, thus
    // running the corresponding function in the 'then' method
    // of the promise below
    setTimeout(function() {
      if (okToGreet(name)) {
        // will run the success function of the promise
        resolve('Hello, ' + name + '!');
      } else {
        // will run the failure function of the promise
        reject('Greeting ' + name + ' is not allowed.');
      }
    }, 1000);
  });
}

var promise = asyncGreet('Robin Hood');

// naming the methods for clarity
promise.then(function success(greeting) {
  alert('Success: ' + greeting);
}, function failure(reason) {
  alert('Failed: ' + reason);
});
```

note that not all of the ES6 promise calls are available on the `$q` API, and that the promise will NOT be implicitly rejected if an exception is thrown in the constructor as in ES6 promises.

can also take a different approach using the `defer` syntax; this allows for updates to be issued while the promise is in the process of being resolved/rejected:

```js
// for the purpose of this example let's assume that variables `$q` and
// okToGreet`are available in the current lexical scope (they could have 
// been injected or passed in).

function asyncGreet(name) {
  // create the 'deferred' interface
  var deferred = $q.defer();

  setTimeout(function() {
    // runs the update callback of then 'then' method on the promise (3rd
    // argument). 'notify' can be called an unlimited number of times before
    // the resolution/rejection of the promise
    deferred.notify('About to greet ' + name + '.');

    if (okToGreet(name)) {
      // resolve
      deferred.resolve('Hello, ' + name + '!');
    } else {
      // reject
      deferred.reject('Greeting ' + name + ' is not allowed.');
    }
  }, 1000);

  // must return the 'deferred' interface's promise so it can be handled
  return deferred.promise;
}

var promise = asyncGreet('Robin Hood');

// naming the methods for clarity
promise.then(function success(greeting) {
  alert('Success: ' + greeting);
}, function failure(reason) {
  alert('Failed: ' + reason);
}, function onUpdate(update) {
  alert('Got notification: ' + update);
});
```

`then` also returns a promise so that it can be chained with other methods, such as `catch` and `finally`:

`catch` is shorthand for `then(null, errorCallback)`
`finally` is executed once the promise is fulfilled, regardless of whether or not is was resolved or rejected. It can also handle the `notify` callback (`finally(callback, notifyCallback)`)

thus, promises can be chained as follows to achieve similar results as above.

can also create entirely new promises, whose values can be manipulations of the previous promise's result:

```js
// promiseB will be resolved immediately after promiseA is resolved and its
// value will be the result of promiseA incremented by 1

promiseB = promiseA.then(function(result) {
  return result + 1;
});
```

Testing promises is simply, but does involve some quirks:

```js
it('should simulate promise', inject(function($q, $rootScope) {
  var deferred = $q.defer();
  var promise = deferred.promise;
  var resolvedValue;

  promise.then(function(value) { resolvedValue = value; });
  expect(resolvedValue).toBeUndefined();

  // Simulate resolving of promise
  deferred.resolve(123);
  // Note that the 'then' function does not get called synchronously.
  // This is because we want the promise API to always be async, whether or not
  // it got called synchronously or asynchronously.
  expect(resolvedValue).toBeUndefined();

  // Propagate promise resolution to 'then' functions using $apply().
  $rootScope.$apply();
  expect(resolvedValue).toEqual(123);
}));
```


---
## $rootElement
represents the root of the angular application (where `ngApp` was declared)

---
## $rootScope
scope of the root element

---
## $sceDelegate
[link](https://code.angularjs.org/1.5.11/docs/api/ng/service/$sceDelegate)

a service used by `$sce` to provide Strict Contextual Escaping (SCE) services to AngularJS.

use this to set the resource whitelist/blacklist:

```js
angular.module('myApp', []).config(function($sceDelegateProvider) {
  $sceDelegateProvider.resourceUrlWhitelist([
    // Allow same origin resource loads.
    'self',
    // Allow loading from our assets domain.  Notice the difference between * and **.
    'http://srv*.assets.example.com/**'
  ]);

  // The blacklist overrides the whitelist so the open redirect here is blocked.
  $sceDelegateProvider.resourceUrlBlacklist([
    'http://myapp.example.com/clickThru**'
  ]);
});
```

---
## $sce
[link](https://code.angularjs.org/1.5.11/docs/api/ng/service/$sce)

stands for "Strict Context Escaping". SCE is a mode in which AngularJS requires bindings in certain contexts to result in a value that is marked as safe to use for that context.

Angular ships with SCE enabled by default as of version 1.2

SCE assists in writing code in a way that is a) secure by default and b) makes auditing for security vulnerabilities such as XSS, clickjacking, etc. a lot easier.

---
## $templateRequest

---
## $timeout
angular wrapper for `window.setTimeout`

---
## $window
a reference to the browser's `window` object; the standard `window` object is generally available, but creates issues with testing because it's a global variable
