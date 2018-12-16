//
//  Persistence.swift
//  Persistence
//
//  Created by Cassius Pacheco on 16/12/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation

public final class Persistence {
    private lazy var queue: DispatchQueue = DispatchQueue(label: "com.cassius.Persistence", qos: .userInitiated, attributes: .concurrent)
    private let defaults: UserDefaultsInterface
    
    public init(defaults: UserDefaultsInterface) {
        self.defaults = defaults
    }
    
    public func removeValue(for key: String) {
        queue.async(flags: .barrier) {
            self.defaults.removeObject(forKey: key)
        }
    }
    
    public func save<Value>(_ value: Value?, for key: String) {
        queue.async(flags: .barrier) {
            self.defaults.set(value, forKey: key)
        }
    }
    
    public func value<Value>(for key: String) -> Value? {
        var value: Value?
        
        queue.sync {
            // This ensures the `Any?` object returned is not `nil`
            // otherwise casting a nil `Any?` into something else will
            // return a `.some(nil)` result, which is different of `nil`.
            if let object = self.defaults.object(forKey: key) {
                value = object as? Value
            }
        }
        
        return value
    }
    
    public func bool(for key: String) -> Bool {
        var value: Bool = false
        
        queue.sync {
            value = self.defaults.bool(forKey: key)
        }
        
        return value
    }
    
    public func saveEncoded<Value: Codable>(_ value: Value?, for key: String) {
        queue.async(flags: .barrier) {
            let data = try? JSONEncoder().encode(value)
            self.defaults.set(data, forKey: key)
        }
    }
    
    public func decodedValue<Value: Codable>(for key: String) -> Value? {
        var value: Value?
        
        queue.sync {
            guard let data: Data = self.value(for: key) else { return }
            value = try? JSONDecoder().decode(Value.self, from: data)
        }
        
        return value
    }
}
