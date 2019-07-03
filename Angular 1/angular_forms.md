# Forms in Angular

## Overview

forms in angular depend heavily on the 2-way binding of `ngModel`

## Basics

adding `novalidate` as an attribute to a `form` element will prevent the browser's native form validation from occuring

`ngModel` adds the following CSS classes to form elements to allow for styling based on the current state of the element:

- `ng-valid`: the model is valid
- `ng-invalid`: the model is invalid
- `ng-valid-[key]`: for each valid key added by $setValidity
- `ng-invalid-[key]`: for each invalid key added by $setValidity
- `ng-pristine`: the control hasn't been interacted with yet
- `ng-dirty`: the control has been interacted with
- `ng-touched`: the control has been blurred
- `ng-untouched`: the control hasn't been blurred
- `ng-pending`: any $asyncValidators are unfulfilled

the attribute `require` can be added to a form element to trigger the addtiton of the `ng-invalid` class if it is not filled out

the following example illustrates how a form can manage the state of it's components and display errors on actions such as submission (`formName.$submitted`) or blurring of a component (`formName.componentName.$touched`):

form template:
```html
<div ng-controller="ExampleController">
  <form name="form" class="css-form" novalidate>
    <label>Name:
      <input type="text" ng-model="user.name" name="uName" required="" />
    </label>
    <br />
    <div ng-show="form.$submitted || form.uName.$touched">
      <div ng-show="form.uName.$error.required">Tell us your name.</div>
    </div>

    <label>E-mail:
      <input type="email" ng-model="user.email" name="uEmail" required="" />
    </label>
    <br />
    <div ng-show="form.$submitted || form.uEmail.$touched">
      <span ng-show="form.uEmail.$error.required">Tell us your email.</span>
      <span ng-show="form.uEmail.$error.email">This is not a valid email.</span>
    </div>

    Gender:
    <label><input type="radio" ng-model="user.gender" value="male" />male</label>
    <label><input type="radio" ng-model="user.gender" value="female" />female</label>
    <br />
    <label>
    <input type="checkbox" ng-model="user.agree" name="userAgree" required="" />

    I agree:
    </label>
    <input ng-show="user.agree" type="text" ng-model="user.agreeSign" required="" />
    <br />
    <div ng-show="form.$submitted || form.userAgree.$touched">
      <div ng-show="!user.agree || !user.agreeSign">Please agree and sign.</div>
    </div>

    <input type="button" ng-click="reset(form)" value="Reset" />
    <input type="submit" ng-click="update(user)" value="Save" />
  </form>
  <pre>user = {{user | json}}</pre>
  <pre>master = {{master | json}}</pre>
</div>
```

form controller:
```js
angular.module('formExample', [])
.controller('ExampleController', ['$scope', function($scope) {
  $scope.master = {};

  $scope.update = function(user) {
    $scope.master = angular.copy(user);
  };

  $scope.reset = function(form) {
    if (form) {
      form.$setPristine();
      form.$setUntouched();
    }
    $scope.user = angular.copy($scope.master);
  };

  $scope.reset();
}]);
```

## Custom Events

additional behaviors can be specified to allow for different handling of updating 2-way bindings. For example, although models normally update on change, can instead have them update on blur using the following attribute and value:

`ng-model-options="{ updateOn: 'default blur' }"`

can also debounce the updating of form elements using the `ng-model-options` attribute:

`ng-model-options="{ debounce: 500 }"`

where `500` is the time between updates in ms. custom debouncing events can also be used for specific events, which allows for certain events to force an update, such as the blur event for example:

`ng-model-options="{ updateOn: 'default blur', debounce: { default: 500, blur: 0 } }"`

## Custom Validation

custom directives can have custom validation in the form of `$validators`:

```html
<form name="form" class="css-form" novalidate>
  <div>
    <label>
    Size (integer 0 - 10):
    <input type="number" ng-model="size" name="size"
           min="0" max="10" integer />{{size}}</label><br />
    <span ng-show="form.size.$error.integer">The value is not a valid integer!</span>
    <span ng-show="form.size.$error.min || form.size.$error.max">
      The value must be in range 0 to 10!</span>
  </div>

  <div>
    <label>
    Username:
    <input type="text" ng-model="name" name="name" username />{{name}}</label><br />
    <span ng-show="form.name.$pending.username">Checking if this name is available...</span>
    <span ng-show="form.name.$error.username">This username is already taken!</span>
  </div>

</form>
```

```js
var app = angular.module('form-example1', []);

var INTEGER_REGEXP = /^-?\d+$/;
app.directive('integer', function() {
  return {
    require: 'ngModel',
    link: function(scope, elm, attrs, ctrl) {
      ctrl.$validators.integer = function(modelValue, viewValue) {
        if (ctrl.$isEmpty(modelValue)) {
          // consider empty models to be valid
          return true;
        }

        if (INTEGER_REGEXP.test(viewValue)) {
          // it is valid
          return true;
        }

        // it is invalid
        return false;
      };
    }
  };
});

app.directive('username', function($q, $timeout) {
  return {
    require: 'ngModel',
    link: function(scope, elm, attrs, ctrl) {
      var usernames = ['Jim', 'John', 'Jill', 'Jackie'];

      ctrl.$asyncValidators.username = function(modelValue, viewValue) {

        if (ctrl.$isEmpty(modelValue)) {
          // consider empty model valid
          return $q.resolve();
        }

        var def = $q.defer();

        $timeout(function() {
          // Mock a delayed response
          if (usernames.indexOf(modelValue) === -1) {
            // The username is available
            def.resolve();
          } else {
            def.reject();
          }

        }, 2000);

        return def.promise;
      };
    }
  };
});
```

## Modifying Built-In Validators

```html
<form name="form" class="css-form" novalidate>
  <div>
    <label>
      Overwritten Email:
      <input type="email" ng-model="myEmail" overwrite-email name="overwrittenEmail" />
    </label>
    <span ng-show="form.overwrittenEmail.$error.email">This email format is invalid!</span><br>
    Model: {{myEmail}}
    </div>
</form>
```

```js
var app = angular.module('form-example-modify-validators', []);

app.directive('overwriteEmail', function() {
  var EMAIL_REGEXP = /^[a-z0-9!#$%&'*+/=?^_`{|}~.-]+@example\.com$/i;

  return {
    require: '?ngModel',
    link: function(scope, elm, attrs, ctrl) {
      // only apply the validator if ngModel is present and AngularJS has added the email validator
      if (ctrl && ctrl.$validators.email) {

        // this will overwrite the default AngularJS email validator
        ctrl.$validators.email = function(modelValue) {
          return ctrl.$isEmpty(modelValue) || EMAIL_REGEXP.test(modelValue);
        };
      }
    }
  };
});
```

## Implementing Custom Form Controls

```html
<div contentEditable="true" ng-model="content" title="Click to edit">Some</div>
<pre>model = {{content}}</pre>

<style type="text/css">
  div[contentEditable] {
    cursor: pointer;
    background-color: #D0D0D0;
  }
</style>
```

```js
angular.module('form-example2', []).directive('contenteditable', function() {
  return {
    require: 'ngModel',
    link: function(scope, elm, attrs, ctrl) {
      // view -> model
      elm.on('blur', function() {
        ctrl.$setViewValue(elm.html());
      });

      // model -> view
      ctrl.$render = function() {
        elm.html(ctrl.$viewValue);
      };

      // load init value from DOM
      ctrl.$setViewValue(elm.html());
    }
  };
});
```

## Submission

using the `ngSubmit` directive without `action`, `data-action`, or `x-action` will prevent default behavior automatically. Be wary of double submission, which can occur by combining `ng-submit` and `ng-click` or a similar directive.
