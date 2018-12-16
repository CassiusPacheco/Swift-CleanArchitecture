//
//  RecursiveLock.swift
//  DependencyInjection
//
//  Created by Cassius Pacheco on 16/12/18.
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
