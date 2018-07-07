//
//  ProductRepository.swift
//  Data
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import Entities

public protocol ProductRepositoryInterface {
    
    var products: [Product] { get }
    
    func create(_ product: Product)
}

public class ProductRepository: ProductRepositoryInterface {
    
    struct keys {

        static let products: Key = "products"
    }
    
    private let cache: CacheInterface
    
    public init(cache: CacheInterface) {
        
        self.cache = cache
    }
    
    public var products: [Product] {
        
        return cache.decodedValue(for: keys.products) ?? []
    }
    
    public func create(_ product: Product) {
        
        cache.saveEncoded(products + [product], for: keys.products)
    }
}
