//
//  FuzzyValue.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 08.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation

/// represents a fuzzy value and its triangular-shaped membership function
public class FuzzyValue: CustomStringConvertible {
    
    /// the variable or object that is assigned a hedge and a fuzzy value
    public var title: String
    /// the hedge that can further specify and limit or dilate the relation between variable and fuzzy value
    public var minimum: Double
    /// the fuzzy value which is assigned to the variable
    public var maximum: Double
    
    /**
     Initializes a new Rulepart with the provided variable, hedge and fuzzy value.
     */
    init(title: String, minimum: Double, maximum: Double) {
        self.title = title
        self.minimum = minimum
        self.maximum = maximum
    }
    
    /**
     Initializes a new Rulepart with a provided variable and sets the hedge and fuzzy value to an empty string.
     */
    init(title: String) {
        self.title = title
        self.minimum = 0
        self.maximum = 0
    }
    ///returns a string that contains the variable, hedge and fuzzyValue; seperated by a comma
    public var description: String { return title + ", " + String(minimum) + ", " + String(maximum) }
    
    static func == (lhs: FuzzyValue, rhs: FuzzyValue) -> Bool {
        return lhs.title == rhs.title &&
            lhs.minimum == rhs.minimum &&
            lhs.maximum == rhs.maximum
    }
}
