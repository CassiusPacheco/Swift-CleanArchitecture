//
//  DetailViewModel.swift
//  Project
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import Domain

protocol DetailCoordinatorDelegate: class {
    
    // define other routes from the detail screen
}

protocol DetailViewModelInterface {
    
    var coordinator: DetailCoordinatorDelegate? { get set }
    var delegate: DetailViewModelDelegate? { get set }
    var textFieldInput: String { get set }
    
    func createButtonTouchUpInside()
    func printAllButtonTouchUpInside()
}

protocol DetailViewModelDelegate: NSObjectProtocol {
    
    func productCreated()
}

final class DetailViewModel: DetailViewModelInterface {

    private let productsUseCase: ProductsUseCaseInterface
    private let createProductUseCase: CreateProductUseCaseInterface
    
    weak var coordinator: DetailCoordinatorDelegate?
    weak var delegate: DetailViewModelDelegate?
    
    var textFieldInput: String = ""
    
    init(productsUseCase: ProductsUseCaseInterface, createProductUseCase: CreateProductUseCaseInterface) {
        
        self.productsUseCase = productsUseCase
        self.createProductUseCase = createProductUseCase
    }
    
    func createButtonTouchUpInside() {
        
        guard textFieldInput.count > 0 else { return }
        
        createProductUseCase.execute(textFieldInput)
        
        delegate?.productCreated()
    }
    
    func printAllButtonTouchUpInside() {
        
        print("\n--Printing all:\n")
        
        productsUseCase.execute().forEach { (product) in
            
            print(product.name)
        }
        
        print("\n--")
    }
}
