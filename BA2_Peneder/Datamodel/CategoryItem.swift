//
//  CategoryItem.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 23.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation

public class CategoryItem {
    
    public var fuzzyValues = [String] ()
    public var name: String
    
    init(name: String, fuzzyValues: [String]) {
        self.name = name
        self.fuzzyValues = fuzzyValues
    }
}
