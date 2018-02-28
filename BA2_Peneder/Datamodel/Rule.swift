//
//  Rule.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 25.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation

class Rule {
    public var title: String
    public var antecedents: [RulePart]?
    public var consequent: RulePart?
    public var logicalOperators: [LogicalOperator]?
    
    init(antecedents: [RulePart], consequent: RulePart, title: String, logicalOperators: [LogicalOperator]) {
        self.antecedents = antecedents
        self.consequent = consequent
        self.title = title
        self.logicalOperators = logicalOperators
    }
    
    init() {
        self.title = "My rule"
        self.antecedents = [RulePart] ()
        self.logicalOperators = [LogicalOperator] ()
    }
}
