# Perfect

## Overview

Perfect is a server-sided swift web framework. It's inspired by rails.

## Basics

See the "HelloWorld" project for a basic HTTP server, which serves static content and introduces the perfect routes

## Perfect Assistant

### Project Creation

The Perfect Assistane helps for creating new projects, giving a few options:

- Perfect Template App: sets up a basic "Hello World" boilerplate
- Empty Executable Project: the equivalent of `swift package init type --executable`. Baiscally a project where you're starting from scratch
- Empty Library Project: the equivalent of `swift package init`. Basically a project intended to be a reusable swift library to be imported into other projects
- Custom Repository URL: lets you input something like a github repo url, and will pull and build the project for you
- Perfect Template App Engine: A modified version of the "Hello World" app intended for usage with the Google App Engine

Example projects are also available from the assistant, and they're a great learning resource

### Deployment

User: perfect
Group: ec2-full-access
Access Key ID: AKIAI3632CXCOLEMAVBQ
Secret Access Key: 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

### Miscallaneous

Creating a project with Perfect Assistant will give you additional useful features to manipulate, build, and deplot the project

Also allows you to drag and drop common dependencies, specify version, etc.

The biggest advantage of the assistant is to build the project in a linux environment on your local machine. It does this behind the scenes via the following steps:

1. Builds an ubuntu docker image
2. Installs Swift 3.0, other dependencies
3. Moves source code to image
4. Builds and runs
5. Returns results of build back to local machine

### Templating

Must add a package for templating; currently, the only stable one appears to be for mustache
