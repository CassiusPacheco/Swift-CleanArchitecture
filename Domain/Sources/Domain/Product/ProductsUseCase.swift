//
//  ProductsUseCase.swift
//  Domain
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import Entities
import Data

public protocol ProductsUseCaseInterface {
    @discardableResult
    func execute() -> [Product]
}

public class ProductsUseCase: VoidUseCase<[Product]>, ProductsUseCaseInterface {
    private let repository: ProductRepositoryInterface
    
    public init(repository: ProductRepositoryInterface) {
        self.repository = repository
    }
    
    @discardableResult
    override public func execute() -> [Product] {
        return repository.products
    }
}
