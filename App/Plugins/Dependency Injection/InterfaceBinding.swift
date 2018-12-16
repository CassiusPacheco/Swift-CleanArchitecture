//
//  InterfaceBinding.swift
//  App
//
//  Created by Cassius Pacheco on 16/12/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import Persistence
import Data

extension Persistence: CacheInterface {}

extension UserDefaults: UserDefaultsInterface {}
