# Go

Go is dead simple, and is meant to be easily learnable in a few hours. Its a simple language.

## Variables and Inferred Typing

```go
// types will be inferred like in Swift if initialized but not specified
var (
  name, location string = "Trey", "Columbus"
  age int = 22
)
```

inside of a function, can you `:=` in place of a variable assignment. Type will be inferred:

```go
var a = "value"
// is equivalent too...
a := "value"
```

constants are declared like variables, but with the `const` keyword.

import packages using `import "PackageName"`

a file's package is defined at the top of the file, before imports, using `package PackageName`

use `go get` to get Go packages and install them to the workspace (`$HOME/go` by default, unless the `$GOPATH` has been changed)

all declared variables must be used; replace variable name with `_` to ignore.

## Functions

signature is a little different than normal:

```go
// will assume all variables preceeding a type have that type
func addAlert(x, y int, msg string) int {
    fmt.Printf("%s: %d", msg, x + y)
}
```

Can return multiple values as well, and deconstruct upon invoking. Keep in mind that the return value is not an object, so all values have to be deconstructed. If a value is not desired, replace with `_`. Example:

```go
func returnThings() (string, string) {
    a := "hello"
    b := "world"
    return a, b
}

func main() {
    a, b := returnThings()
}
```

can name the return parameters to return variables of the same name from within the function without explicitly returning them

```go
func magic() (ala, kazam string) {
    ala := "abra"
    kazam := "kadabra"
    return // will return `ala` and `kazam`
}
```

the above is often recommended against as it can be confusing

variadic parameters are also accepted:

```go
func sum(nums ...int) int {
  sum := 0
  for _, num := range nums { // first arg is index, which isn't used, hence `_`
    sum += num
  }
  return sum
}
```

Go supports anonymous functions and closures:

```go
func buildIncrementer() func() int {
  i := 0
  return func() int {
    i += 1
    return i
  }
}

func main() {
  inc1 := buildIncrementer()
  inc2 := buildIncrementer()

  fmt.Println(inc1()) // 1
  fmt.Println(inc1()) // 2
  fmt.Println(inc2()) // 1 (separate closure value)
}
```

## Structs

No classes, but structs are available (no inheritance). Keep in mind that struct values will automatically have getters and setters, but that only properties with capitalized (exported) values will be publicly available outside of the package

```go
type Animal struct {
    Name, Size string
    Age        int
}

func main() {
    dog := Animal{Name: "Travis", Size: "Medium", Age: 2}
}
```

Go passes by value by default, so struct instances are immutable in functions. This can be changed using pointers:

```go
func mutate(obj *Object) { ... }

func main() {
    obj := &Object{ ... }
    mutate(obj)
}
```

Instead of inheritance, one should utilize composition for shared fields:

```go
type Animal struct {
  Name, Size string
}

type Dog struct {
  Animal
  Fur string
}

func main() {
  // can construct by setting values directly, or using a literal
  dog1 := Dog{}
  dog1.Name = "Rufus"
  dog1.Size = "Small"
  dog1.Fur = "Short"

  dog2 := Dog{
    Animal: Animal{Name: "Dingus", Size: "Large"},
    Fur: "Long"
  }

  // notice the syntax is not `<dog_name>.Animal.Name`
  fmt.Println(dog1.Name)
  fmt.Println(dog2.Name)
}
```

Can also use implicit composition, binding all methods from the child interface directly to the implementing interface:

```go
package main

import (
	"log"
	"os"
)

type Job struct {
	Command string
	*log.Logger
}

func main() {
	job := &Job{"demo", log.New(os.Stderr, "Job: ", log.Ldate)}
  // if `Job` was defined with `Logger *log.Logger`, would have to call
  // `job.Logger.Print` here (note the * because `log.New` returns a reference)
	job.Print("starting now...")
}
```

Since Go passes structs by value, it is often going to be desired to use references in composition so that large structs are not copied when passed into functions. Example:

### Struct Methods

Go uses slightly odd syntax to add instance methods to a struct:

```go
type User struct {
	FirstName, LastName string
}

// this is an instance method. The signature is as follows:
func (varName structT) funcName(args) returnT {
  // varName is available and represents the instance the method is
  // being called upon
}

// real example:
func (u User) Greeting() string {
	return fmt.Sprintf("Dear %s %s", u.FirstName, u.LastName)
}
```

Note that because methods do not need to be declared in the struct, they can be declared anywhere in the package.

Also, a method can be defined on *any* type you define in the package. You can not define a method on a type from another package or a basic type (what is essentially a swift extension).

methods can be added on types that are not owned by the package via an alias:

```go
import (
    "fmt"
    "strings"
)

type String2 string

func (s String2) Uppercase() string {
  return strings.ToUpper(string(s))
}

func main() {
  str2 := String2("foobar")
  fmt.Println(str2.Uppercase()) // outputs "FOOBAR"
}
```

Often it is best to bind methods to pointers (`*MyType`) rather than values (`MyType`) so that large values are no copied in method bodies. Binding to pointers also allows for mutating instance methods.

## Interfaces

Interfaces work as expected, although they are a bit strange since structs don't directly implement them. Rather, any struct that happens to have all the methods defined by an interface essentially implements that interface. So in the following example, `User` effectively "implements" `Namer`:

```go
type User struct {
	FirstName, LastName string
}

func (u *User) Name() string {
	return fmt.Sprintf("%s %s", u.FirstName, u.LastName)
}

type Namer interface {
	Name() string
}
```

Interfaces can however implement other interfaces:

```go
type Reader interface {
	Read(b []byte) (n int, err error)
}

type Writer interface {
	Write(b []byte) (n int, err error)
}

type ReadWriter interface {
	Reader
	Writer
}
```

An `error` in Go is anything that implements the error interface:

```go
type error interface {
    Error() string
}
```

## Control Flow

If statements in Go always require braces.

If statements allow for a similar structure to swift's `if-let` (this is called a "short statement", and is just that; it is a single statement that will be executed before evaluating the condition. `for` loops allow for the same structure in Go):

```go
// attempting to type cast `err` to type `MyErrorType`, and then check if the
// cast was successful and that the result has a specific property
if myError, ok := err.(MyErrorType); ok && myError.code == 1 {
  // do something
}
```

There are only `for` loops in Go. A while loop can be created by either leaving out the pre and post conditions of the loop, or by using the shorthand:

```go
for ; x < 10; {
  // do something
  x++
}

for x < 10 {
  // do something
  x++
}
```

In addition, an infinite loop (normally `while true`), is as follows:

```go
for {
  // do something infinitely
}
```

`switch` statements are similar to in `swift`; each case breaks by default unless explicitly told otherwise with the `fallthrough` keyword.

## Pointers

Syntax:

```go
package main

import "fmt"

// `v` is a pointer to an integer
func byRef(v *int) {
  *v = 0 // dereference the pointer, and change its value
}

func main() {
  v := 5
  fmt.Println("Initial value:", v) // 5
  byRef(&v) // `&v` gets the memory location (reference) of `v`
  fmt.Println("Final value:", v) // 0
}
```

## Types

Basic Types:

```
bool
string
```

Numeric types:

```
uint        either 32 or 64 bits
int         same size as uint
uintptr     an unsigned integer large enough to store the uninterpreted bits of
            a pointer value
uint8       the set of all unsigned  8-bit integers (0 to 255)
uint16      the set of all unsigned 16-bit integers (0 to 65535)
uint32      the set of all unsigned 32-bit integers (0 to 4294967295)
uint64      the set of all unsigned 64-bit integers (0 to 18446744073709551615)

int8        the set of all signed  8-bit integers (-128 to 127)
int16       the set of all signed 16-bit integers (-32768 to 32767)
int32       the set of all signed 32-bit integers (-2147483648 to 2147483647)
int64       the set of all signed 64-bit integers
            (-9223372036854775808 to 9223372036854775807)

float32     the set of all IEEE-754 32-bit floating-point numbers
float64     the set of all IEEE-754 64-bit floating-point numbers

complex64   the set of all complex numbers with float32 real and imaginary parts
complex128  the set of all complex numbers with float64 real and imaginary parts

byte        alias for uint8
rune        alias for int32 (represents a Unicode code point)
```

## Type Assertions

can attempt to perform a type conversion to a specific interface, and then perform logic if successful. A type conversion will return a tuple, where the first value is the coerced value and the second is a boolean that represents whether or not the conversion was successful:

```go
// attempting to convert a to a map of string keys and interface (arbitrary) values
b, ok := a.(map[string]interface{})
```

Go allows for initializing the default value of a type with the `new` keyword. This will return a pointer to the newly initialized value. `new` will return the same value as an empty literal for a struct as well; if a constructor is provided, the default value can be changed. Example usage:

```go
x := new(int) // `x` is a pointer
```

## Collections

### Arrays

Arrays are declared in the form `[n]T` where `n` is the number of elements and `T` is the type of the elements:

```go
var arr [10]int // an array of 10 integers
```

As in java and many other languages, simple arrays cannot be resized.

To set the entries of the array on initialization, use literal syntax:

```go
a := [2]string{"hello", "world"} // explicit number of elements
b := [...]string{"hello", "world"} // implicit number of elements
```

Use the `%q` verb with `Printf` to print each quoted value.

### Slices

Slices are a wrapper over the usual Go arrays. Slices hold references to the underlying Go arrays.

Most array programming is done with slices rather than arrays since they do not require a specific length. They are initialized with `[]T`. Notice that a number of elements is not provided within the `[]`.

Slices allow for pythonic subsetting:

```go
arr := []int{1, 2, 3, 4, 5, 6}

arr[1:3] // from 1 -> 3 - 1; so {2, 3}
arr[:3] // implies 0 -> 3 - 1; so {1, 2, 3}
arr[2:] // implies 2 -> end; so {2, 3, 4, 5, 6}
```

Can initialize a slice to a specific number of elements using `make`:

```go
a := make([]string, 4) // `a` is a slice with 4 elements
```

`append` function is available to add elements to a slice. It's a little odd because it returns a new value rather than editing in-place:

```go
a := []string{}

// appends 2 elements to `a` (`append` is variadic)
a = append(a, "foobar", "barfoo")

// something similar to the js spread operator is also available; this will
// concatenate the elements of `b` onto those of `a`
b := []string{"hello", "world"}
a = append(a, b...) // `a` is now {"foobar", "barfoo", "hello", "world"}
```

Check the length (number of set elements) of slices with the `len` function, and the capacity (total number of spaces allotted to the underlying array) with `cap`.

The zero value of a slice is `nil`, which has a length and capacity of 0.

`range` can be used on maps and arrays/slices for iteration:

```go
for i, v := range mySlice {
  // do something
}
for k, v := range myMap {
  // do somthing
}
```

### Maps

Defined in the form `map[kT]vT` where `kT` is the type of the key and `vT` is the type of the value. A map not initialized with a literal must be created using `make` in order for values to be assigned to it:

```go
var m = map[string]int

func main() {
  m = make(map[string]int)
  // can now assign values to m
}
```

When using a literal, if the top-level type is just a type name, it can be omitted:

```go
type Vertex struct {
	Lat, Long float64
}

var m = map[string]Vertex{
  // same as "Bell Labs": Vertex{40.68433, -74.39967}
	"Bell Labs": {40.68433, -74.39967},
	"Google": {37.42202, -122.08408},
}
```

Some useful operations to remember when dealing with maps:

```go
// delete an element
delete(m, key)

// check if a key has an associated value
elem, ok := m[key]
```

Interestingly, since values of maps are initialized to the zero value of the type used, a check is not required when attempting to say, increment a value in the map. If the value does not exist for the key, it will be seen as the initial value for int (0), so incrementing will make it 1. If it does exist, the value will be incremented as expect. Example (counting word occurrences in a string):

```go
// OPTION 1: checking if the value exists in the map
func WordCount1(s string) map[string]int {
	m := make(map[string]int)
	for _, str := range strings.Fields(s) {
		if _, ok := m[str]; ok {
			m[str] = m[str] + 1
		} else {
			m[str] = 1
		}
	}
	return m
}
// OPTION 2: No need to check since the value will be initialized to 0 for a
// value that has not yet been added to the map
func WordCount2(s string) map[string]int {
	m := make(map[string]int)
	for _, str := range strings.Fields(s) {
    m[str]++
	}
	return m
}
```

## Concurrency

Can be pretty complex, look [here](http://www.golangbootcamp.com/book/concurrency) to revisit.

The gist of concurrency in Go is that goroutines are used to evaluate work asynchronously, and channels are used to synchronize data across routines. Channels are blocking when goroutines using that channel are running, and another goroutine channel is waiting to pull values. So, if two goroutines were running to sum an array, each adding a value to the channel on completion, the routine waiting to pull two values would wait until they were done, since the values are not yet ready. If all goroutines using a channel are complete, and the values needed by another routine are not available, then the result is a deadlock.

Buffered channel sends are blocking when the channel is full, and receives are blocking when the channel is empty.

### Goroutines

a goroutine is a lightweight thread managed by the Go runtime:

```go
go f(x, y, z)
```

Keep in mind that the evaluation of `f`, `x`, `y`, `z` will occur in the current goroutine, by the execution of `f` will occur in the new goroutine.

### Channels

Channels are a typed conduit through which you can send and receive values:

```go
ch <- v // send `v` to channel `ch`
v := <-ch // receive from channel `ch` and store in `v`
```

like maps and slices, channels must be created before use:

```go
ch := make(chan int) // a channel for passing integer values
```

The following is an example of summing the values in a slice by using a separate routine on each half:

```go
package main

import "fmt"

func sum(arr[]int, ch chan int) {
  total := 0

  for _, v := range arr {
    total += v
  }

  ch <- total
}

func main() {
  ch := make(chan int)

  arr := []int{1, 2, 3, 4, 5, 6}
  arrLen := len(arr)

  go sum(arr[:arrLen/2], ch)
  go sum(arr[arrLen/2:], ch)

  x, y := <-ch, <-ch // pull 2 values from the channel
  fmt.Println(x, y, x + y)
}
```

Can also create buffered channels that only allow so many values at once. To do so, just pass the buffer length (number of values that can be stored) as the second argument to `make`. A goroutine will wait until the channel is available before executing, if needed (**I'm a little shaky on why this works**):

```go
package main

import "fmt"

func main() {
	c := make(chan int, 2)
	c <- 1
	c <- 2
	add := func(x int) { c <- x }
	go add(3)
	fmt.Println(<-c)
	fmt.Println(<-c)
	fmt.Println(<-c)
}
```

Senders can close channels to indicate that their are no more values to be received. `range` can be used on a channel to receive values until the channel is closed:

```go
v, ok := <-ch // `ok` will be `false` if there are no more values and the channel is closed

for v := range ch {
  // receive values from `ch` until closed
}
```

Technically a receiver can close a channel, but it should never be done. In addition, channels are not like files; they usually *don't* need to be close. Typically, one only does so to escape a `range` loop. To close a channel, invoke `close(ch)`

`cap` can be used on a buffered channel to determine how many spaces are left.

The `select` statement lets a goroutine wait until one of its cases are ready. For example:

```go
select {
case c <- x:
  x, y = y, x+y
case <-quit:
  fmt.Println("quit")
  return
}
```

If multiple cases are ready, one will be selected at random. If given, `default` will run if no other cases are matched. Any case running will block the default's execution.

There is an interesting example on determining whether 2 binary trees are equivalent using Go's concurrency [here](http://www.golangbootcamp.com/book/concurrency).

## Packages

### fmt

Used for printing

methods:
- `Printf`
- `Println`
