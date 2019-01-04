//
//  SiriShortcutCoordinator.swift
//  App
//
//  Created by Cassius Pacheco on 4/1/19.
//  Copyright © 2019 Cassius Pacheco. All rights reserved.
//

import Foundation
import IntentsUI
import os.log

// This coordinator is a bit different of the others because an instance of this coordinator will be kept in the AppCoordinator
// to handle all SiriShortcuts presentation/dismissal methods and also handle the Shortcut button delegate calls.
protocol SiriShortcutCoordinatorInterface: Coordinator, INUIAddVoiceShortcutButtonDelegate {}

final class SiriShortcutCoordinator: NSObject, SiriShortcutCoordinatorInterface {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {}
}

extension SiriShortcutCoordinator: INUIAddVoiceShortcutButtonDelegate {
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        navigationController.present(addVoiceShortcutViewController, animated: true, completion: nil)
    }

    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        navigationController.present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
}

extension SiriShortcutCoordinator: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let error = error as NSError? {
            os_log("Error adding voice shortcut: %@", log: OSLog.default, type: .error, error)
        }

        controller.dismiss(animated: true, completion: nil)
    }

    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension SiriShortcutCoordinator: INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let error = error as NSError? {
            os_log("Error adding voice shortcut: %@", log: OSLog.default, type: .error, error)
        }

        controller.dismiss(animated: true, completion: nil)
    }

    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }

    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
