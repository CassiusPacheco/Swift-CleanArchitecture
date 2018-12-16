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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let mainWindow = UIWindow(frame: UIScreen.main.bounds)
        self.window = mainWindow
        
        dependencyInjection.setupWithMainWindow(mainWindow)
        
        var coordinator = dependencyInjection.container.resolve(AppCoordinatorInterface.self)
        coordinator.window = window
        coordinator.start()
        
        return true
    }
}

