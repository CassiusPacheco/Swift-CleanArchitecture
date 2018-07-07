//
//  AppDelegate.swift
//  Project
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import UIKit
import DependencyInjection

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var dependencyInjection = DependencyGraph(container: DIContainer.shared)

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        dependencyInjection.setup()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let coordinator = dependencyInjection.container.resolve(Coordinator.self)
        coordinator.start(window)
        
        return true
    }
}

