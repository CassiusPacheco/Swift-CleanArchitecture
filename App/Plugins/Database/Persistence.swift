//
//  Persistence.swift
//  Tests
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import Data

final class Persistence: CacheInterface {
    
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults) {
        
        self.defaults = defaults
    }
    
    func save<Value>(_ value: Value?, for key: Key) {

        defaults.setValue(value, forKey: key.rawValue)
        defaults.synchronize()
    }
    
    func value<Value>(for key: Key) -> Value? {
        
        return defaults.value(forKey: key.rawValue) as? Value
    }
    
    func saveEncoded<Value: Encodable>(_ value: Value?, for key: Key) {
        
        let encoded = try? JSONEncoder().encode(value)
        
        defaults.setValue(encoded, forKey: key.rawValue)
        defaults.synchronize()
    }
    
    func decodedValue<Value: Decodable>(for key: Key) -> Value? {
        
        guard let data = defaults.value(forKey: key.rawValue) as? Data else { return nil }
        
        return try? JSONDecoder().decode(Value.self, from: data)
    }
}
