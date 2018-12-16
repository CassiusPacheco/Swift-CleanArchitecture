//
//  DIContainerTests.swift
//  DependencyInjectionTests
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import XCTest
@testable import DependencyInjection

final class DIContainerTests: XCTestCase {
    private struct DummyTest: Equatable {
        let name: String
        let id: String = UUID().uuidString
    }
    
    func testContainerResolvesRegisteredClasses() {
        let container = DIContainer()
        
        container.register(DummyTest.self) { (di) -> DummyTest in
            return DummyTest(name: "Test")
        }
        
        let resolvedTest1 = container.resolve(DummyTest.self)
        let resolvedTest2 = container.resolve(DummyTest.self)
        
        XCTAssertNotEqual(resolvedTest1, resolvedTest2, "Factory creates a new instance for every instance resolved")
    }
    
    func testContainerResolvesSingletonRegisteredClasses() {
        let container = DIContainer()
        
        container.registerSingleton(DummyTest.self) { (di) -> DummyTest in
            return DummyTest(name: "Test")
        }
        
        let resolvedTest1 = container.resolve(DummyTest.self)
        let resolvedTest2 = container.resolve(DummyTest.self)
        
        XCTAssertEqual(resolvedTest1, resolvedTest2, "Singleton factories retunrs the same instance for every instance resolved")
    }
    
    func testContainerContainsRegisteredSingletonClass() {
        let container = DIContainer()
        
        XCTAssertFalse(container.contains(DummyTest.self))
        
        container.registerSingleton(DummyTest.self) { di -> DummyTest in
            return DummyTest(name: "Test")
        }
        
        XCTAssertTrue(container.contains(DummyTest.self), "container should contain the registered singleton")
    }
    
    func testContainerContainsRegisteredFactoryClass() {
        let container = DIContainer()
        
        XCTAssertFalse(container.contains(DummyTest.self))
        
        container.register(DummyTest.self) { di -> DummyTest in
            return DummyTest(name: "Test")
        }
        
        XCTAssertTrue(container.contains(DummyTest.self), "container should contain the registered factory")
    }
}
