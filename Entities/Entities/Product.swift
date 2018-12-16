//
//  Product.swift
//  DependencyInjector
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation

public struct Product: Codable {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
