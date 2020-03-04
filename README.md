# The Clean Architecture

This sample project is inspired on [The Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html) by Uncle Bob.

Its main goal is to follow the [SOLID principles](https://en.wikipedia.org/wiki/SOLID) in order to keep the software well organised, testable, easy to maintain and more importantly easy to extend/change.

As explained in the posts above and in [the book](https://www.amazon.com/Clean-Architecture-Craftsmans-Software-Structure/dp/0134494164), databases, network clients and frameworks are abstracted in the upper layers (Entities, Data and Domain layers) and should not be imported/referenced into them, instead they should be injected in the App level as dependencies through the interfaces exposed by the upper layers.

![graph](
https://8thlight.com/blog/assets/posts/2012-08-13-the-clean-architecture/CleanArchitecture-8d1fe066e8f7fa9c7d8e84c1a6b0e2b74b2c670ff8052828f4a7e73fcbbc698c.jpg)

## Modules

In this sample app we have the following modules/layers:

### DependencyInjector

Framework responsible for linking the Interfaces to the `Factories`. This should only the referenced/used in the `App Module`.

### Entities

Top level module. This should not have access to any other module in the system and must be the simplest possible.

### Data

Responsible for exposing a few Interfaces for external plugins implementations such as databases, memory caches, network, bluetooth, etc. This should not reference any concrete class related to these. It also contains the `Repositories` which are another abstraction for the use of the plugins mentioned above. This module can only access `Entities` layer, nothing else.

### Domain

This module exposes `UseCases` to process business logic using the [Command Pattern](https://en.wikipedia.org/wiki/Command_pattern). The use cases must be simple and have only one responsibility. They usually communicate with `Repositories` from the `Data layer` through Interfaces. Ideally `UseCases` would return `DataStructures` instead of `Entities` to the lower layers, since these could contain UI-specific data which isn't part of the `Entities` layer.

### App

In this layer we have all the code that's specific to the platform of development. In this sample project the platform is iOS, furthermore a concrete implementation of the `CacheInterface` exposed by the `Data layer` was implemented in the `App layer` using `UserDefaults` as the persistence choice, for example.
This layer may have `ViewModels`, `Coordinators`, `ViewControllers`, `Views`, third party frameworks and, finally, is also responsible for setting up the dependency graph for the project by linking all the interfaces to their respective concrete classes.

## Tests

Even though I haven't written any tests yet, the whole project is completely testable, since all layers are being isolated by interfaces, as suggested by the SOLID principles.

## Getting Started

### Prerequisites
- Xcode 11.3.1
- iOS 12
- Swift 5.1

### Installing
The project uses Swift Package Manager for dependency management. Just open `SwiftCleanArchitecture.xcworkspace`, select the `App` target and run it.

To check out the legacy example built with Carthage, have a look at this [branch](https://github.com/CassiusPacheco/Swift-CleanArchitecture/tree/carthage).
