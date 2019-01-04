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
    let viewModel: MainViewModelInterface
    
    // MARK: - Init methods
    
    init(viewModel: MainViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action methods
    
    @IBAction
    private func detailViewControllerButtonTouchUpInside() {
        viewModel.detailViewControllerButtonTouchUpInside()
    }
}
