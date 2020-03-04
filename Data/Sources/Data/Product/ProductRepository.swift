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
        static let products = "products"
    }
    
    private let cache: CacheInterface
    private let service: ProductServiceInterface
    
    public init(cache: CacheInterface, service: ProductServiceInterface) {
        self.cache = cache
        self.service = service
    }
    
    public var products: [Product] {
        return cache.decodedValue(for: keys.products) ?? []
    }
    
    public func create(_ product: Product) {
        service.create(product)
        cache.saveEncoded(products + [product], for: keys.products)
    }
}
