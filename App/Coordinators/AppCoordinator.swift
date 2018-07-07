//
//  AppCoordinator.swift
//  Project
//
//  Created by Cassius Pacheco on 8/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import UIKit
import DependencyInjection

class AppCoordinator: Coordinator {
    
    private(set) var navigationController: UINavigationController!
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        
        self.container = container
        
        let mainViewController = MainViewController(coordinator: self)
        self.navigationController = UINavigationController(rootViewController: mainViewController)
    }
    
    func start(_ window: UIWindow) {
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func pushDetailViewController() {
        
        let detailViewController = container.resolve(DetailViewController.self)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
