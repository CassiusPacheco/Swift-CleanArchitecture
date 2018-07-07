//
//  DI.swift
//  DependencyInjector
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation

final class RecursiveLock {
    
    private let lock = NSRecursiveLock()
    
    @discardableResult
    func sync<T>(action: () -> T) -> T {
        
        lock.lock()
        
        defer { lock.unlock() }
        
        return action()
    }
}

final public class DIContainer {
    
    static public let shared = DIContainer()
    
    private var factories = [String: Any]()
    
    private let lock = RecursiveLock()
    
    public func register<T>(_ type: T.Type, factory: @escaping ((DIContainer) -> T)) {
        
        lock.sync {
            self.factories["\(type)"] = factory
        }
    }
    
    public func registerSingleton<T>(_ type: T.Type, factory: @escaping ((DIContainer) -> T)) {
        
        lock.sync {
            self.factories["\(type)"] = factory(self)
        }
    }
    
    public func resolve<T>(_ type: T.Type) -> T {
        
        return lock.sync {
            
            let key = "\(type)"
            
            if let singleton = self.factories[key] as? T {
                
                return singleton
            }
            else if let instanceFactory = self.factories[key] as? ((DIContainer) -> T) {
                
                return instanceFactory(self)
            }
            else {
                
                fatalError("Instance of type `\(type)` hasn't been registered")
            }
        }
    }
}
