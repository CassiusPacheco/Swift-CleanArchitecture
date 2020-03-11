//
//  DetailViewController.swift
//  DependencyContainer
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import UIKit
import IntentsUI
import ExtensionIntents

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
        createAddToSiriButton()
        textField.addTarget(self, action: #selector(textFieldCharacterDidChange), for: .editingChanged)
    }
    
    // MARK: - Action

    @IBAction
    private func createButtonTouchUpInside() {
        viewModel.createButtonTouchUpInside()
    }
    
    @IBAction
    private func printAllButtonTouchUpInside() {
        viewModel.printAllButtonTouchUpInside()
    }
    
    @objc
    private func textFieldCharacterDidChange() {
        viewModel.textFieldInput = textField.text ?? ""
    }

    private func createAddToSiriButton() {
        // Note that this is a useless intent. The idea is just to show the concept working.
        let intent = CreateProductIntent()
        intent.name = "Test"
        let shortcutButton = INUIAddVoiceShortcutButton(style: .whiteOutline)
        shortcutButton.shortcut = INShortcut(intent: intent)
        shortcutButton.delegate = viewModel.shortcutButtonDelegate

        navigationItem.setRightBarButton(UIBarButtonItem(customView: shortcutButton), animated: true)
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func productCreated() {
        textField.text = nil
    }
}
