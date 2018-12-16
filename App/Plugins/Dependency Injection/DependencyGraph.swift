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
import Persistence

final class DependencyGraph {
    
    let container: DIContainer
    
    init(container: DIContainer) {
        
        self.container = container
    }
    
    func setupWithMainWindow(_ window: UIWindow) {
        
        setupAppDelegate(window)
        setupCoordinators()
        setupServices()
        setupPersistence()
        setupRepositories()
        setupUseCases()
        setupViewModels()
    }
    
    private func setupAppDelegate(_ window: UIWindow) {
        
        container.registerSingleton(UIWindow.self) { di -> UIWindow in
            return window
        }
    }
    
    private func setupCoordinators() {
        
        container.registerSingleton(AppCoordinatorInterface.self) { di -> AppCoordinatorInterface in
            return AppCoordinator(container: di)
        }
        
        container.register(MainCoordinatorInterface.self) { di -> MainCoordinatorInterface in
            return MainCoordinator(container: di)
        }
        
        container.register(DetailCoordinatorInterface.self) { di -> DetailCoordinatorInterface in
            return DetailCoordinator(container: di)
        }
    }
    
    private func setupServices() {
        
        container.register(ProductServiceInterface.self) { di -> ProductServiceInterface in
            return ProductService()
        }
    }
    
    private func setupPersistence() {
        
        container.registerSingleton(CacheInterface.self) { _ -> CacheInterface in
            return Persistence(defaults: UserDefaults.standard)
        }
    }
    
    private func setupRepositories() {
        
        container.register(ProductRepositoryInterface.self) { di -> ProductRepositoryInterface in
            return ProductRepository(cache: di.resolve(CacheInterface.self))
        }
    }
    
    private func setupUseCases() {
        
        container.register(ProductsUseCaseInterface.self) { di -> ProductsUseCaseInterface in
            return ProductsUseCase(repository: di.resolve(ProductRepositoryInterface.self))
        }
        
        container.register(CreateProductUseCaseInterface.self) { di -> CreateProductUseCaseInterface in
            return CreateProductUseCase(repository: di.resolve(ProductRepositoryInterface.self))
        }
    }
    
    private func setupViewModels() {
        
        container.register(MainViewModelInterface.self) { di -> MainViewModelInterface in
            return MainViewModel()
        }
        
        container.register(DetailViewModelInterface.self) { di -> DetailViewModelInterface in
            return DetailViewModel(productsUseCase: di.resolve(ProductsUseCaseInterface.self),
                                   createProductUseCase: di.resolve(CreateProductUseCaseInterface.self))
        }
    }
}
