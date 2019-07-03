/*
 * Iterators and generators provide a way of customizing the behavior of
 * `for ... of`  loops
 */

/*
 * A Javascript iterator simply provides a method of accessing elements in a
 * collection, while keeping track of current position. This is done when an
 * object provides a `next` method which returns the next item in the sequence.
 * `next` should return an object with properties `done` and `value`.
 */
function makeIterator(arr) {
   let nextIdx = 0;

   return {
      next: function() {
         if (nextIndex < arr.length) {
            return {
               value: arr[nextIdx++],
               done: false
            };
         } else {
            return {
               done: true
            };
         }
      }
   };
}

let it = makeIterator(["yo", "ya"]);
console.log(it.next().value); // 'yo'
console.log(it.next().value); // 'ya'
console.log(it.next().done); // true

/*
 * Generators are more powerful alternatives to iterators since they do not
 * require explicitly maintaining their state. A generator function works as a
 * factory for iterators
 */
function* idMaker() {
   let index = 0;
   while (true) {
      yield index++;
   }
}

let gen = idMaker();
console.log(gen.next().value); // 0
console.log(gen.next().value); // 1
console.log(gen.next().value); // 2
// ...

/*
 * Objects can be made into iterables by overriding the `@@iterator` method.
 * This is done by ensuring the object has a property with a Symbol.iterator
 * key.
 */
let myIterable = {};
myIterable[Symbol.iterator] = function*() {
   yield 1;
   yield 2;
   yield 3;
};

for (let x of myIterable) {
   console.log(value);
}

[...myIterable]; // [1, 2, 3]
