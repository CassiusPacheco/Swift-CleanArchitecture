//
//  DependencyGraph.swift
//  Project
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import DependencyInjection
import Entities
import Domain
import Data

final class DependencyGraph {
    
    let container: DIContainer
    
    init(container: DIContainer) {
        
        self.container = container
    }
    
    func setup() {
        
        container.registerSingleton(Coordinator.self) { (di) -> Coordinator in
            return AppCoordinator(container: di)
        }
        
        container.registerSingleton(CacheInterface.self) { _ -> CacheInterface in
            return Persistence(defaults: .standard)
        }
        
        container.register(ProductServiceInterface.self) { (di) -> ProductServiceInterface in
            return ProductService()
        }
        
        container.register(ProductRepositoryInterface.self) { (di) -> ProductRepositoryInterface in
            return ProductRepository(cache: di.resolve(CacheInterface.self))
        }
        
        container.register(ProductsUseCaseInterface.self) { (di) -> ProductsUseCaseInterface in
            return ProductsUseCase(repository: di.resolve(ProductRepositoryInterface.self))
        }
        
        container.register(CreateProductUseCaseInterface.self) { (di) -> CreateProductUseCaseInterface in
            return CreateProductUseCase(repository: di.resolve(ProductRepositoryInterface.self))
        }
        
        container.register(DetailViewModelInterface.self) { (di) -> DetailViewModelInterface in
            return DetailViewModel(productsUseCase: di.resolve(ProductsUseCaseInterface.self),
                                   createProductUseCase: di.resolve(CreateProductUseCaseInterface.self))
        }
        
        container.register(DetailViewController.self) { (di) -> DetailViewController in
            return DetailViewController(viewModel: di.resolve(DetailViewModelInterface.self))
        }
    }
}
