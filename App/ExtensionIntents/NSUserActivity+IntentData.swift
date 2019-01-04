//
//  NSUserActivity+IntentData.swift
//  ExtensionIntents
//
//  Created by Cassius Pacheco on 4/1/19.
//  Copyright © 2019 Cassius Pacheco. All rights reserved.
//

import Foundation
import MobileCoreServices

#if canImport(CoreSpotlight)
import CoreSpotlight
import UIKit
#endif

extension NSUserActivity {
    public enum ActivityKeys: String {
        case productName
    }

    public static let createProductActivityType = "com.cassiuspacheco.ExtensionIntents.createProduct"

    public static var createProductActivity: NSUserActivity {
        let userActivity = NSUserActivity(activityType: NSUserActivity.createProductActivityType)

        userActivity.title = "Create a product"
        userActivity.isEligibleForPrediction = true

        #if canImport(CoreSpotlight)
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeContent as String)

        attributes.keywords = ["Create", "Product"]
        attributes.displayName = "Create a product"
        attributes.contentDescription = "Create a product"

        userActivity.contentAttributeSet = attributes
        #endif

        userActivity.suggestedInvocationPhrase = "Create a product"
        return userActivity
    }
}
