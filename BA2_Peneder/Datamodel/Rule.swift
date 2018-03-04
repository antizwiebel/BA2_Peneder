//
//  Rule.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 25.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

class Rule: CustomStringConvertible {
    
    public var title: String
    public var antecedents: [RulePart]?
    public var consequent: RulePart?
    public var logicalOperators: [LogicalOperator]?
    public var ruleImage: UIImage?
    
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
    
    var description: String { return buildRuleString() }

    ///the string-representation of a rule that is later used to save it in a file
    internal func buildRuleString() -> String {
        var ruleString = "EMPTY"
        if self.consequent != nil {
            ruleString = String(describing: self.consequent!) + ",C"
        }
        if self.antecedents?.count ?? 0 > 0 {
            let antecedentCount = self.antecedents?.count ?? 1
            for index in 0...(antecedentCount-1) {
                ruleString = ruleString + "\n" + String(describing: self.antecedents![index])
                if (index != antecedentCount-1) {
                    ruleString = ruleString + "," + String(describing: self.logicalOperators![index+1])
                } else {
                    ruleString = ruleString + ",END"
                }
            }
        }
        return ruleString
    }
}
