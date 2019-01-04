//
//  CacheInterface.swift
//  Data
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation

public protocol CacheInterface {
    func removeValue(for key: String)
    func save<Value>(_ value: Value?, for key: String)
    func value<Value>(for key: String) -> Value?
    func bool(for key: String) -> Bool
    func saveEncoded<Value: Codable>(_ value: Value?, for key: String)
    func decodedValue<Value: Codable>(for key: String) -> Value?
}

public extension CacheInterface {
    public static var appGroup: String {
        return "group.com.cassiuspacheco.Swift-CleanArchitecture"
    }
}
