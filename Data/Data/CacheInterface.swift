//
//  CacheInterface.swift
//  Data
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation

public struct Key: Hashable, RawRepresentable, ExpressibleByStringLiteral {
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: String) {
        self.rawValue = value
    }
}

public protocol CacheInterface {
    
    func save<Value>(_ value: Value?, for key: Key)
    
    func value<Value>(for key: Key) -> Value?
    
    func saveEncoded<Value: Encodable>(_ value: Value?, for key: Key)
    
    func decodedValue<Value: Decodable>(for key: Key) -> Value?
}
