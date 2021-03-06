//
//  ProductServiceInterface.swift
//  Data
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import Entities

public protocol ProductServiceInterface: ServiceInterface {
    // Some service code to fetch products or something
    func create(_ product: Product)
}
