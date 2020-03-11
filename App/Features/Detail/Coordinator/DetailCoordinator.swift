//
//  DetailCoordinator.swift
//  App
//
//  Created by Cassius Pacheco on 25/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import UIKit
import Foundation
import DependencyContainer

protocol DetailCoordinatorInterface: Coordinator, DetailCoordinatorDelegate {
    var navigationController: UINavigationController? { get set }
}

final class DetailCoordinator: DetailCoordinatorInterface {
    let container: DependencyContainer
    var navigationController: UINavigationController?
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func start() {
        var viewModel = container.resolve(DetailViewModelInterface.self)
        let viewController = DetailViewController(viewModel: viewModel)
        viewModel.coordinator = self
        
        if let navigation = navigationController {
            navigation.pushViewController(viewController, animated: true)
        } else {
            // You can either handle the dismissal here or forward the event to the viewModel
            // or even handle the button creation in the viewController itself.
            let dismissButton = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissButtonTapped))
            let navigation = UINavigationController(rootViewController: viewController)
            viewController.navigationItem.leftBarButtonItem = dismissButton
            navigationController = navigation
            
            let window = container.resolve(UIWindow.self)
            window.rootViewController?.present(navigation, animated: true)
        }
    }
    
    @objc
    private func dismissButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
}

extension DetailCoordinator {
    // MARK: - DetailCoordinatorDelegate methods

    var siriShortcutCoordinator: SiriShortcutCoordinatorInterface {
        return container.resolve(AppCoordinatorInterface.self).siriShortcutCoordinator
    }
}
