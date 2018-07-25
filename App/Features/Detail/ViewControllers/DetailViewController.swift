//
//  DetailViewController.swift
//  DependencyInjector
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet
    private var textField: UITextField!
    
    private var viewModel: DetailViewModelInterface
    
    // MARK: - Init methods
    
    init(viewModel: DetailViewModelInterface) {
        
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
        print("DetailViewController has been deallocated")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        textField.addTarget(self, action: #selector(textFieldCharacterDidChange), for: .editingChanged)
    }
    
    // MARK: - Action

    @IBAction
    func createButtonTouchUpInside() {
        
        viewModel.createButtonTouchUpInside()
    }
    
    @IBAction
    func printAllButtonTouchUpInside() {
        
        viewModel.printAllButtonTouchUpInside()
    }
    
    @objc
    func textFieldCharacterDidChange() {
        
        viewModel.textFieldInput = textField.text ?? ""
    }
}

extension DetailViewController: DetailViewModelDelegate {
    
    func productCreated() {
        
        textField.text = nil
    }
}
