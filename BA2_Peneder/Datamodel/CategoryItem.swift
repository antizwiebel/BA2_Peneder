//
//  CategoryItem.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 23.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation


/// A category items contains a number of fuzzy values that a user can choose from and assign to the variable.
public class CategoryItem {
    
    /// The possible fuzzy values that can be used for this item
    public var fuzzyValues : [String]
    /// the name of the item/variable
    public var name: String
    
    ///Initializes a CategoryItem with a given name and an array of fuzzy values
    init(name: String, fuzzyValues: [String]) {
        self.name = name
        self.fuzzyValues = fuzzyValues
        
    }
}
