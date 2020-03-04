//
//  UseCase.swift
//  Tests
//
//  Created by Cassius Pacheco on 7/7/18.
//  Copyright © 2018 Cassius Pacheco. All rights reserved.
//

import Foundation
import UIKit

public class VoidUseCase<Output> {
    
    @discardableResult
    public func execute() -> Output {
        
        fatalError("this should be overridden")
    }
}

public class UseCase<Input, Output> {
    
    @discardableResult
    public func execute(_ input: Input) -> Output {
        
        fatalError("this should be overridden")
    }
}
