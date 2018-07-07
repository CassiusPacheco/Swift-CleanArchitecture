//
//  MainViewController.swift
//  DependencyInjector
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import UIKit
import DependencyInjection

final class MainViewController: UIViewController {
    
    private let coordinator: Coordinator
    
    // MARK: - Init methods
    
    init(coordinator: Coordinator) {
        
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action methods
    
    @IBAction func detailViewControllerButtonTouchUpInside() {
        
        self.coordinator.pushDetailViewController()
    }
}
