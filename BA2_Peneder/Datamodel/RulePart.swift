//
//  RulePart.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 25.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation

/// represents either an antecedent or a precedent in a rule
class RulePart {
    public var variable: String
    public var hedge: String
    public var fuzzyValue: String
    
    init(variable: String, hedge: String, fuzzyValue: String) {
        self.variable = variable
        self.hedge = hedge
        self.fuzzyValue = fuzzyValue
    }
    
    init(variable: String) {
        self.variable = variable
        self.fuzzyValue = ""
        self.hedge = ""
    }
}
