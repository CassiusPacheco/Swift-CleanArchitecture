//
//  CreateProductUseCase.swift
//  Domain
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import Entities
import Data

public protocol CreateProductUseCaseInterface {
    @discardableResult
    func execute(_ input: String) -> Product
}

public class CreateProductUseCase: UseCase<String, Product>, CreateProductUseCaseInterface {
    private let repository: ProductRepositoryInterface
    
    public init(repository: ProductRepositoryInterface) {
        self.repository = repository
    }
    
    @discardableResult
    override public func execute(_ input: String) -> Product {
        let product = Product(name: input)
        repository.create(product)
        return product
    }
}
