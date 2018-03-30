//
//  RuleEvaluation.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 08.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation

/// Provides various methods to evaluate rules and arrive at a truth value for a rule.
public class RuleEvaluation {
    
    /**
     Defuzzifies a given rule with an array of crisp values.
     
     - Parameters:
     - rule: the rule that needs to be defuzzified
     - crispValues: an array of crisp values that are used to defuzzify each antecedent of a rule.
     
     - Returns: The "truth value" of a rule, ranging from 0 to 1 or -1 if there was an error.
    */
    public static func defuzzifyRule (rule: Rule, crispValues: [Float]) -> Double{
        var memberships = [Double]()
        if let antecedents = rule.antecedents {
            var defuzzifiedValue: Double = -1
            if antecedents.isEmpty == false {
                for index in 0...antecedents.count-1 {
                    let fuzzyValue = antecedents[index].fuzzyValue
                    memberships.append(calculateMembership(x: crispValues[index], a: fuzzyValue.minimum, b: (fuzzyValue.maximum + fuzzyValue.minimum) / 2, c: fuzzyValue.maximum))
                }
                defuzzifiedValue = memberships.first ?? -1
                if antecedents.count > 1  && rule.logicalOperators?.count ?? 0 > 0  {
                    for index in 1...(rule.logicalOperators?.count)!-1 {
                        defuzzifiedValue = logicalRelation(membership1: defuzzifiedValue, membership2: memberships[index], logicalOperator: rule.logicalOperators![index])
                        print(defuzzifiedValue)
                    }
                }
            }
            return defuzzifiedValue
        } else {
            //antecedents are nil
            return -1
        }
    }
    
    /**
    Unites two given membership values with a given LogicalOperator. For AND the minimum is returned and for OR the maximum.
     - Parameters:
     - membership1: the first membership value
     - membership2: the second membership value
     - logicalOperator: the logical operator which connects the two values

     - Returns: the unified membership value.
    */
    static func logicalRelation(membership1: Double, membership2: Double, logicalOperator: LogicalOperator) -> Double {
        if logicalOperator == LogicalOperator.AND {
            //return min(membership1, membership2)
            return min (membership1, membership2)
        } else {
            return max(membership1, membership2)
        }
    }
    
    /**
     Triangular Membership function for crisp values. x is the crisp input and depends on three parameters a, b, c
     - Parameters:
     - x: the input
     - a: left "foot" of the triangle
     - b: peak of the triangle
     - c: right "foot" of the triangle
     */
    public static func calculateMembership(x: Float, a: Double, b:Double, c:Double) -> Double {
        if Double(x) <= a {
            return 0
        } else if (a <= Double(x)) && ( Double(x) <= b) {
            return (Double(x)-a)/(b-a)
        } else if (b <= Double(x)) && (Double(x) <= c) {
            return (c-Double(x))/(c-b)
        } else if  c <= Double(x) {
            return 0
        }
            return 0
    }
}
