# Vapor Notes

## Overview

Vapor is a relatively unopinionated server-side swift framework. It is based off of the PHP Laravel framework

basic commands:

```sh
# create a project
vapor new <project_name>

# build a project
vapor build

# serve the project
vapor serve

# create an xcode project
vapor xcode
```

## Drops



## Views

views are stored in `Resources/Views` and are created by calling `view` on a the `Droplet` object

paths are specified relative to the `Views` directory; returning non-rendered documents (like HTML) is simple:

```swift
drop.get("html") { request in
    return try drop.view.make("path/to/file.ext")
}
```

templated documents (Leaf, Mustache, or Stencil, etc.) can be passed a `Context`:

```swift
drop.get("template") { request in
    return try drop.view.make("path/to/file.ext", [
        "message": "Hello, world!"
    ])
}
```

resources such as images, styles, and scripts should be placed in the `Public` folder

Any class that conforms to `ViewRenderer` can be added to the droplet:

```swift
let drop = Droplet()

drop.view = LeafRenderer(viewsDir: drop.viewsDir)
```

the main renderer for templates is [Leaf](https://vapor.github.io/documentation/guide/leaf.html), which was written specifically for Vapor

## Controllers

basic controllers aren't required to conform to any protocols, and look like the following:

```swift
final class HelloController {
    func sayHello(_ req: Request) throws -> ResponseRepresentable {
        guard let name = req.data["name"] else { 
            throw Abort.badRequest 
        }
        return "Hello, \(name)"
    }
}
```

keep in mind that in order to register a controller method to a route, the method must have the following structure: 
`(Request) throws -> ResponseRepresentable`

this allows for the methods to be bound directly to drops, since the method sturtcure matches that of the expected closue:

```swift
let hc = HelloController()

drop.get("hello", handler: hc.sayHello)
```

