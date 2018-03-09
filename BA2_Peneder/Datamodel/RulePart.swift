//
//  RulePart.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 25.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation

/// represents either an antecedent or a precedent in a rule
public class RulePart: CustomStringConvertible {
    
    /// the variable or object that is assigned a hedge and a fuzzy value
    public var variable: String
    /// the hedge that can further specify and limit or dilate the relation between variable and fuzzy value
    public var hedge: String
    /// the fuzzy value which is assigned to the variable
    public var fuzzyValue: FuzzyValue
    
    /**
     Initializes a new Rulepart with the provided variable, hedge and fuzzy value.
     */
    init(variable: String, hedge: String, fuzzyValue: FuzzyValue) {
        self.variable = variable
        self.hedge = hedge
        self.fuzzyValue = fuzzyValue
    }
   
    /**
     Initializes a new Rulepart with a provided variable and sets the hedge and fuzzy value to an empty string.
     */
    init(variable: String) {
        self.variable = variable
        self.fuzzyValue = FuzzyValue(title: "")
        self.hedge = ""
    }
    ///returns a string that contains the variable, hedge and fuzzyValue; seperated by a comma
    public var description: String { return variable + "," + hedge + "," + fuzzyValue.title }

}
