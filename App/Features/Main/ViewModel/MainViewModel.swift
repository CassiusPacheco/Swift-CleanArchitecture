//
//  MainViewModel.swift
//  App
//
//  Created by Cassius Pacheco on 25/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation

protocol MainCoordinatorDelegate: class {
    
    func pushDetailViewController()
}

protocol MainViewModelInterface {
    
    var coordinator: MainCoordinatorDelegate? { get set }
    
    func detailViewControllerButtonTouchUpInside()
}

final class MainViewModel: MainViewModelInterface {
    
    weak var coordinator: MainCoordinatorDelegate?
    
    func detailViewControllerButtonTouchUpInside() {
        
        self.coordinator?.pushDetailViewController()
    }
}
