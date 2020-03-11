//
//  InterfaceBinding.swift
//  ExtensionIntents
//
//  Created by Cassius Pacheco on 4/1/19.
//  Copyright © 2019 Cassius Pacheco. All rights reserved.
//

import Foundation
import Data
import Persistence
import NetworkServices

// This is a separated file from App's because this usage is much simpler.
// Note that the usage of the DependencyContainer framework is optional for
// this framework since it shouldn't do much and shouldn't perform many operations.
extension Persistence: CacheInterface {}

extension UserDefaults: UserDefaultsInterface {}

extension ProductService: ProductServiceInterface {}
