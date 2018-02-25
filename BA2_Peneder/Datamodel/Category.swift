//
//  Category.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 23.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

public class Category {
    
    public var title: String = "Test"
    public var subTitle: String = "This is a category subtitle"
    public var categoryItems = [CategoryItem] ()
    public var image: UIImage?
    
    init(categoryTitle: String, categorySubTitle: String, categoryItems: [CategoryItem], image: UIImage) {
        self.title = categoryTitle
        self.subTitle = categorySubTitle
        self.categoryItems = categoryItems
        self.image = image
    }
}
