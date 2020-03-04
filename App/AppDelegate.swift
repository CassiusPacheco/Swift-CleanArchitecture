//
//  AppDelegate.swift
//  Project
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import UIKit
import DependencyInjector
import ExtensionIntents
import os.log

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private lazy var dependencyGraph = DependencyGraph(container: DependencyInjector())

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let mainWindow = UIWindow(frame: UIScreen.main.bounds)
        self.window = mainWindow
        
        dependencyGraph.setupWithMainWindow(mainWindow)
        
        var coordinator = dependencyGraph.container.resolve(AppCoordinatorInterface.self)
        coordinator.window = window
        coordinator.start()
        
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivity.createProductActivityType ||
            userActivity.activityType == NSStringFromClass(CreateProductIntent.self) else { return false }
        
        let coordinator = dependencyGraph.container.resolve(AppCoordinatorInterface.self)
        coordinator.pushDetailViewController()
        return true
    }
}

