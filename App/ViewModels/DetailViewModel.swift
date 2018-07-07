//
//  DetailViewModel.swift
//  Project
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import Domain

protocol DetailViewModelInterface {
    
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
        
        self.productsUseCase.execute().forEach { (product) in
            
            print(product.name)
        }
        
        print("\n--")
    }
}
