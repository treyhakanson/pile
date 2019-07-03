# Server-Side Swift

## Overview

Server-side swift offers a lot of key advantages:

- Fast
- Type safe
- Flexible and expressive

## Package Management

the swift package manager can be used to quickly initialize a swift package/project:

```sh
swift package init --type executable
```

creates the following items:

- `Package.swift` - contains all packages being used
- `main.swift` - contains the projects code

after adding all dependencies to `Package.swift`, can run the following to generate an xcode project:

```sh
swift package generate-xcodeproj
```

run the following to update dependencies after editing Package.swift:

```sh
swift package update
```

the flow is a bit odd, but basically anytime the `Packge.swift` is changed, must run `swift package update` and then rebuild the xcode project using `swift package generate-xcodeproj` (this must be run anytime something is changed within the projects directories, even if something like an image file is added)

The format to adding dependencies in `Package.swift` is as follows:

```swift
import PackageDescription

let package = Package(
    name: "HelloWorld",
    dependencies: [
        .Package(url: "repo_location.git", majorVersion: 1)
        // other dependencies...
    ]
)
```

after editing this file, must do the following:

1. save the file
2. run `swift package update`
3. run `swift package generate-xcodeproj`

## Useful Packages

Perfect: 
`.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2)`

## Xcode

In order for Xcode to be able to build the project, must use a custom directory as the working directory:

1. Make sure the build source is correct (upper left, righthand option)
2. Click "Edit Scheme" (upper left, lefthand option)
3. Go to the options tab
4. Check "Use custom working directory"
5. Set the working directory to the outermost directory of the project