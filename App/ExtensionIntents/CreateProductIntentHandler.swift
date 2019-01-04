//
//  CreateProductIntentHandler.swift
//  ExtensionIntents
//
//  Created by Cassius Pacheco on 4/1/19.
//  Copyright © 2019 Cassius Pacheco. All rights reserved.
//

import Foundation
import Entities
import Data
import Persistence
import NetworkServices

public final class CreateProductIntentHandler: NSObject, CreateProductIntentHandling {
    public func handle(intent: CreateProductIntent, completion: @escaping (CreateProductIntentResponse) -> Void) {
        guard let productName = intent.name else {
            completion(CreateProductIntentResponse(code: .failure, userActivity: nil))
            return
        }

        let product = Product(name: productName)
        let persistence = Persistence(defaults: UserDefaults(suiteName: Persistence.appGroup)!)
        let productRepository = ProductRepository(cache: persistence, service: ProductService())
        productRepository.create(product)

        let userActivity = NSUserActivity(activityType: NSUserActivity.createProductActivityType)
        userActivity.addUserInfoEntries(from: [NSUserActivity.ActivityKeys.productName.rawValue: product.name])

        let response = CreateProductIntentResponse.success(name: productName)
        response.userActivity = userActivity
        completion(response)
    }
}
