//
//  UserDefaultsInterface.swift
//  Persistence
//
//  Created by Cassius Pacheco on 16/12/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation

public protocol UserDefaultsInterface {
    func integer(forKey defaultName: String) -> Int
    func dictionary(forKey defaultName: String) -> [String: Any]?
    func bool(forKey defaultName: String) -> Bool
    func string(forKey defaultName: String) -> String?
    func set(_ value: Any?, forKey defaultName: String)
    func removeObject(forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
    func dictionaryRepresentation() -> [String: Any]
    func array(forKey defaultName: String) -> [Any]?
}
