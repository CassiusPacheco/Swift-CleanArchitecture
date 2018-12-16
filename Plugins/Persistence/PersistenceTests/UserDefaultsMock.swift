//
//  UserDefaultsMock.swift
//  PersistenceTests
//
//  Created by Cassius Pacheco on 16/12/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import XCTest
@testable import Persistence

class UserDefaultsMock: UserDefaultsInterface {
    var savedKeys = [String]()
    var mockDictionary = [String: Any]()
    
    func integer(forKey defaultName: String) -> Int {
        return value(for: defaultName) ?? 0
    }
    
    func dictionary(forKey defaultName: String) -> [String : Any]? {
        return value(for: defaultName)
    }
    
    func bool(forKey defaultName: String) -> Bool {
        return value(for: defaultName) ?? false
    }
    
    func string(forKey defaultName: String) -> String? {
        return value(for: defaultName)
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        savedKeys.append(defaultName)
        mockDictionary[defaultName] = value
    }
    
    func removeObject(forKey defaultName: String) {
        mockDictionary.removeValue(forKey: defaultName)
    }
    
    func object(forKey defaultName: String) -> Any? {
        return value(for: defaultName)
    }
    
    func dictionaryRepresentation() -> [String : Any] {
        return mockDictionary
    }
    
    func array(forKey defaultName: String) -> [Any]? {
        return value(for: defaultName)
    }
    
    // This wrapper ensures the `Any?` object returned is not `nil`
    // otherwise casting a nil `Any?` into something else will
    // return a `.some(nil)` result, which is different of `nil`.
    private func value<Value>(for key: String) -> Value? {
        guard let object = mockDictionary[key] else { return nil }
        return object as? Value
    }
}
