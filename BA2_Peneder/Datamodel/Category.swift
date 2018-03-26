//
//  Category.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 23.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit




/// A category contains further items that are used to browse through possible variables and fuzzy values that can be used to construct a rule. Features a title, subtitle and a striking image to explain the purpose and its content to the user
public class Category {
    
    /// The title of the category
    public var title: String = "Test"
    /// The subtitle of the category that offers further explanation to the user
    public var subTitle: String = "This is a category subtitle"
    /// The categoryItems that this category contains
    public var categoryItems : [CategoryItem]
    /// A striking image that helps to visually identify a category at a glance
    public var image: UIImage?
    
    ///Standard initializer
    init() {
        self.categoryItems = [CategoryItem]()
    }
    
    ///Initialize a category with all the required content.
    init(categoryTitle: String, categorySubTitle: String, categoryItems: [CategoryItem], image: UIImage) {
        self.title = categoryTitle
        self.subTitle = categorySubTitle
        self.categoryItems = categoryItems
        self.image = image
    }
    
    
}
