//
//  NSLocking.swift
//  DependencyInjection
//
//  Created by Cassius Pacheco on 16/12/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation

extension NSLocking {
    @discardableResult
    public func sync<T>(action: () -> T) -> T {
        lock()

        defer { self.unlock() }

        return action()
    }
}
