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

protocol AppCoordinatorInterface: Coordinator {
    var siriShortcutCoordinator: SiriShortcutCoordinatorInterface { get }
    var window: UIWindow! { get set }

    func pushDetailViewController()
}

enum AppChild {
    case main
}

class AppCoordinator: AppCoordinatorInterface {
    private(set) lazy var siriShortcutCoordinator: SiriShortcutCoordinatorInterface = SiriShortcutCoordinator(navigationController: navigationController)
    private(set) var navigationController: UINavigationController!
    private let container: DIContainer
    var children = [AppChild: Coordinator]()
    var window: UIWindow!
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func start() {
        // The rootVC needs to be initialised manually
        let mainCoordinator = container.resolve(MainCoordinatorInterface.self)
        var viewModel = container.resolve(MainViewModelInterface.self)
        viewModel.coordinator = mainCoordinator
        children[.main] = mainCoordinator
        
        let mainViewController = MainViewController(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: mainViewController)
        mainCoordinator.navigationController = navigationController
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func pushDetailViewController() {
        let isDetailVisible = navigationController.viewControllers.contains(where: { controller -> Bool in
            return controller is DetailViewController
        })

        guard let mainCoordinator = children[.main] as? MainCoordinatorInterface, !isDetailVisible else { return }
        mainCoordinator.pushDetailViewController()
    }
}
