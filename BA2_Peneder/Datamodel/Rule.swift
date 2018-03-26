//
//  Rule.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 25.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

/**
 Represents a rule which contains one or more antecedents, which are chained together with ANDs and ORs, one consequent and an associated image
 */
public class Rule: CustomStringConvertible {
    
    /// the antecedents of a rule, i.e. the "IF-part"
    public var antecedents: [RulePart]?
    /// The consequent of a rule, i.e. the "THEN-part"
    public var consequent: RulePart?
    /// The logical operators, OR and AND, that are used to chain antecedents together
    public var logicalOperators: [LogicalOperator]?
    /// The associated image to a rule, used as a background in the MyRules View
    public var ruleImage: UIImage?
    /// The degree of support for a rule's consequent, calculated by using defuzzification
    public var degreeOfSupport: Double?
    
    /// Initializes a new rule with a given array of antecedents, their associated operators and a consequent
    init(antecedents: [RulePart], consequent: RulePart, logicalOperators: [LogicalOperator]) {
        self.antecedents = antecedents
        self.consequent = consequent
        self.logicalOperators = logicalOperators
    }
    
    ///Initializes an empty rule
    init() {
        self.antecedents = [RulePart] ()
        self.logicalOperators = [LogicalOperator] ()
    }
    
    ///the string-representation of a rule that is later used to save it in a file
    public var description: String { return buildRuleString() }

    /// Get the representation of a rule as a string
    /// - Return: the string-representation of a rule that is later used to save it in a file
    internal func buildRuleString() -> String {
        var ruleString = "EMPTY"
        //add consequent to the first line
        if self.consequent != nil {
            ruleString = String(describing: self.consequent!) + ",C"
        }
        // iterate through every antecedent and add a new line for each of them
        if self.antecedents?.count ?? 0 > 0 {
            let antecedentCount = self.antecedents?.count ?? 1
            for index in 0...(antecedentCount-1) {
                ruleString = ruleString + "\n" + String(describing: self.antecedents![index])
                if (index != antecedentCount-1) {
                    ruleString = ruleString + "," + String(describing: self.logicalOperators![index+1])
                } else {
                    //signify the last row with an "END"
                    ruleString = ruleString + ",END"
                }
            }
        }
        return ruleString
    }
}
