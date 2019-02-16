//
//  MainCoordinator.swift
//  App
//
//  Created by Cassius Pacheco on 25/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import DependencyInjection

protocol MainCoordinatorInterface: Coordinator, MainCoordinatorDelegate {
    var navigationController: UINavigationController? { get set }
}

enum MainChild {
    case detail
}

final class MainCoordinator: MainCoordinatorInterface {
    let container: DependencyInjector
    var children = [MainChild: Coordinator]()
    var navigationController: UINavigationController?
    
    init(container: DependencyInjector) {
        self.container = container
    }
    
    func start() {
        // not necessary since this is the initial controller of the app
    }
}

extension MainCoordinator {
    
    func pushDetailViewController() {
        // if a `navigationController` isn't assigned to the coordinator it will create
        // one and present the screen as a modal
        let detailCoordinator = self.container.resolve(DetailCoordinatorInterface.self)
        detailCoordinator.navigationController = self.navigationController
        self.children[.detail] = detailCoordinator
        detailCoordinator.start()
    }
}
