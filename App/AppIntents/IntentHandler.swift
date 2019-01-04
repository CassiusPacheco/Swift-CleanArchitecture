//
//  IntentHandler.swift
//  AppIntents
//
//  Created by Cassius Pacheco on 4/1/19.
//  Copyright © 2019 Cassius Pacheco. All rights reserved.
//

import Intents
import ExtensionIntents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        guard intent is CreateProductIntent else { fatalError("Unhandled intent type: \(intent)") }
        return CreateProductIntentHandler()
    }
}
