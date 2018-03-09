//
//  wichser.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 08.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation

public class MembershipCalculator {
    
    public static func defuzzifyRule (rule: Rule, crispValues: [Float]) -> Double{
        
        var memberships = [Double]()
        for index in 0...rule.antecedents!.count-1 {
            let fuzzyValue = rule.antecedents![index].fuzzyValue
            memberships.append(calculateMembership(x: crispValues[index], a: fuzzyValue.minimum, b: (fuzzyValue.maximum + fuzzyValue.minimum) / 2, c: fuzzyValue.maximum))
        }
        var defuzzifiedValue = memberships.first!
        if rule.antecedents?.count ?? 0 > 1  {
            for index in 1...(rule.logicalOperators?.count)!-1 {
                defuzzifiedValue = logicalRelation(membership1: defuzzifiedValue, membership2: memberships[index], logicalOperator: rule.logicalOperators![index])
                print(defuzzifiedValue)
            }
        }
        return defuzzifiedValue
    }
    
    static func logicalRelation(membership1: Double, membership2: Double, logicalOperator: LogicalOperator) -> Double {
        if logicalOperator == LogicalOperator.AND {
            //return min(membership1, membership2)
            return membership1 * membership2
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
