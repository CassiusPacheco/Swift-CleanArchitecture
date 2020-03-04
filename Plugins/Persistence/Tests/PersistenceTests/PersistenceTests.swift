//
//  PersistenceTests.swift
//  PersistenceTests
//
//  Created by Cassius Pacheco on 16/12/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import XCTest
@testable import Persistence

final class PersistenceTests: XCTestCase {
    struct DummySerializableObject: Codable {
        let name: String
        let age: Int
    }
    
    func data(forName name: String, age: Int) -> Data {
        return try! JSONSerialization.data(withJSONObject: ["name": name, "age": age], options: [])
    }
    
    func testWriteAndReadFoundationObject() {
        let object = "My Object"
        let key = "test"
        let defaults = UserDefaultsMock()
        let persistence = Persistence(defaults: defaults)
        
        XCTAssertNil(persistence.value(for: key))
        
        persistence.save(object, for: key)
        
        XCTAssertEqual(persistence.value(for: key), object)
    }
    
    func testWriteAndReadSerializableObject() {
        let object = DummySerializableObject(name: "João", age: 18)
        let key = "test"
        let defaults = UserDefaultsMock()
        let persistence = Persistence(defaults: defaults)
        
        var returnedObject: DummySerializableObject? = persistence.decodedValue(for: key)
        
        XCTAssertNil(returnedObject)
        
        persistence.saveEncoded(object, for: key)
        
        returnedObject = persistence.decodedValue(for: key)
        
        XCTAssertEqual(returnedObject?.name, object.name)
        XCTAssertEqual(returnedObject?.age, object.age)
    }
    
    func testWriteAndReadSerializableObjectsArray() {
        let object1 = DummySerializableObject(name: "Jana", age: 18)
        let object2 = DummySerializableObject(name: "Marcos", age: 25)
        let object3 = DummySerializableObject(name: "Oprah", age: 54)
        let array = [object1, object2, object3]
        
        let key = "test"
        let defaults = UserDefaultsMock()
        let persistence = Persistence(defaults: defaults)
        
        var returnedObjects: [DummySerializableObject]? = persistence.decodedValue(for: key)
        
        XCTAssertNil(returnedObjects)
        
        persistence.saveEncoded(array, for: key)
        
        returnedObjects = persistence.decodedValue(for: key)
        
        XCTAssertEqual(returnedObjects!.first!.name, object1.name)
        XCTAssertEqual(returnedObjects!.first!.age, object1.age)
        
        XCTAssertEqual(returnedObjects![2].name, object3.name)
        XCTAssertEqual(returnedObjects![2].age, object3.age)
    }
    
    func testBoolForKey() {
        let key = "test"
        let defaults = UserDefaultsMock()
        defaults.mockDictionary[key] = true
        
        let persistence = Persistence(defaults: defaults)
        
        XCTAssertEqual(defaults.bool(forKey: key), true)
        
        persistence.save(false, for: key)
        
        XCTAssertEqual(defaults.bool(forKey: key), true)
        
        persistence.removeValue(for: key)
        
        XCTAssertNil(persistence.value(for: key), "read value from persistence to ensure the barrier queue has finished removing the value")
    }
    
    func testRemoveValue() {
        let key = "test"
        let defaults = UserDefaultsMock()
        defaults.mockDictionary[key] = "abc"
        
        let persistence = Persistence(defaults: defaults)
        
        XCTAssertEqual(defaults.string(forKey: key), "abc")
        XCTAssertEqual(defaults.object(forKey: key) as? String, "abc")
        
        persistence.removeValue(for: key)
        
        XCTAssertNil(persistence.value(for: key), "read value from persistence to ensure the barrier queue has finished removing the value")
    }
}
