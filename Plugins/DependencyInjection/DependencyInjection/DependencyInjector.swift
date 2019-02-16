//
//  DependencyInjector.swift
//  DependencyInjector
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation

final public class DependencyInjector {
    private var factories = [String: Any]()
    private var singletonFactories = [String: Any]()
    private var singletonInstances = [String: Any]()
    private let lock: NSLocking

    public init(lock: NSLocking = NSRecursiveLock()) {
        self.lock = lock
    }

    /// Returns whether the specified type has been registered. It returns `true` if there's a singleton instance
    /// already created, or for a singleton factory or regular factory registered.
    /// - Note: This method is thread safe.
    public func contains<T>(_ type: T.Type) -> Bool {
        return lock.sync {
            let key = String(describing: type)
            return singletonInstances[key] != nil || singletonFactories[key] != nil || factories[key] != nil
        }
    }
}

public extension DependencyInjector {
    // MARK: - Singleton registration
    /// Registers a singleton factory closure. The instance will only be created once resolved.
    /// Arguments are not supported for singleton registration.
    /// - Note: This method is not thread safe and should only be used at the application start up.
    func registerSingleton<T>(_ type: T.Type, factory: @escaping ((DependencyInjector) -> T)) {
        singletonFactories[String(describing: type)] = factory
    }
}

public extension DependencyInjector {
    // MARK: - Factory methods with no arguments
    /// Registers a  factory closure. A new instance will be created every time it is resolved.
    /// - Note: This method is not thread safe and should only be used at the application start up.
    func register<T>(_ type: T.Type, factory: @escaping ((DependencyInjector) -> T)) {
        factories[String(describing: type)] = factory
    }

    /// For singleton registration, it returns a previously created singleton instance if already created, otherwise
    /// creates a new instance and caches it. For regular factory, it returns a new instance value.
    /// - Note: This method is thread safe.
    func resolve<T>(_ type: T.Type) -> T {
        return lock.sync {
            let key = String(describing: type)

            if let singleton = self.singletonInstances[key] as? T {
                return singleton
            } else if let singletonFactory = self.singletonFactories[key] as? ((DependencyInjector) -> T) {
                let instance = singletonFactory(self)
                self.singletonInstances[key] = instance
                self.singletonFactories.removeValue(forKey: key)
                return instance
            } else if let instanceFactory = self.factories[key] as? ((DependencyInjector) -> T) {
                return instanceFactory(self)
            } else {
                fatalError("Instance of type `\(type)` hasn't been registered")
            }
        }
    }
}

public extension DependencyInjector {
    // MARK: - Factory methods with one argument
    /// Registers a  factory closure with one argument. A new instance will be created every time it is resolved.
    /// - Note: This method is not thread safe and should only be used at the application start up.
    func register<T, A>(_ type: T.Type, factory: @escaping ((DependencyInjector, A) -> T)) {
        factories[String(describing: type)] = factory
    }

    /// Returns a newly created instance injecting one argument.
    /// - Note: This method is thread safe.
    func resolve<T, A>(_ type: T.Type, argument: A) -> T {
        return lock.sync {
            if let instanceFactory = self.factories[String(describing: type)] as? ((DependencyInjector, A) -> T) {
                return instanceFactory(self, argument)
            } else {
                fatalError("Instance of type `\(type)` hasn't been registered")
            }
        }
    }
}

public extension DependencyInjector {
    // MARK: - Factory methods with two arguments
    /// Registers a  factory closure with two arguments. A new instance will be created every time it is resolved.
    /// - Note: This method is not thread safe and should only be used at the application start up.
    func register<T, A, B>(_ type: T.Type, factory: @escaping ((DependencyInjector, A, B) -> T)) {
        factories[String(describing: type)] = factory
    }

    /// Returns a newly created instance injecting two arguments.
    /// - Note: This method is thread safe.
    func resolve<T, A, B>(_ type: T.Type, arguments arg1: A, _ arg2: B) -> T {
        return lock.sync {
            if let instanceFactory = self.factories[String(describing: type)] as? ((DependencyInjector, A, B) -> T) {
                return instanceFactory(self, arg1, arg2)
            } else {
                fatalError("Instance of type `\(type)` hasn't been registered")
            }
        }
    }
}

public extension DependencyInjector {
    // MARK: - Factory methods with three arguments
    /// Registers a  factory closure with three arguments. A new instance will be created every time it is resolved.
    /// - Note: This method is not thread safe and should only be used at the application start up.
    func register<T, A, B, C>(_ type: T.Type, factory: @escaping ((DependencyInjector, A, B, C) -> T)) {
        factories[String(describing: type)] = factory
    }

    /// Returns a newly created instance injecting three arguments.
    /// - Note: This method is thread safe.
    func resolve<T, A, B, C>(_ type: T.Type, arguments arg1: A, _ arg2: B, _ arg3: C) -> T {
        return lock.sync {
            if let instanceFactory = self.factories[String(describing: type)] as? ((DependencyInjector, A, B, C) -> T) {
                return instanceFactory(self, arg1, arg2, arg3)
            } else {
                fatalError("Instance of type `\(type)` hasn't been registered")
            }
        }
    }
}

public extension DependencyInjector {
    // MARK: - Factory methods with four arguments
    /// Registers a  factory closure with four arguments. A new instance will be created every time it is resolved.
    /// - Note: This method is not thread safe and should only be used at the application start up.
    func register<T, A, B, C, D>(_ type: T.Type, factory: @escaping ((DependencyInjector, A, B, C, D) -> T)) {
        factories[String(describing: type)] = factory
    }

    /// Returns a newly created instance injecting four arguments.
    /// - Note: This method is thread safe.
    func resolve<T, A, B, C, D>(_ type: T.Type, arguments arg1: A, _ arg2: B, _ arg3: C, _ arg4: D) -> T {
        return lock.sync {
            if let instanceFactory = self.factories[String(describing: type)] as? ((DependencyInjector, A, B, C, D) -> T) {
                return instanceFactory(self, arg1, arg2, arg3, arg4)
            } else {
                fatalError("Instance of type `\(type)` hasn't been registered")
            }
        }
    }
}
