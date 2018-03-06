//
//  Category+ExampleCategories.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 28.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

extension Category {
    
    ///Used to retrieve fully defined example categories to showcase the functionality of the app and for testing purposes
    /// - Returns: a set of three categories plus items for testing
    static func getExampleCategories() -> [Category] {
        var categories = [Category]()
        
        //health category
        let healthCategoryItem = CategoryItem(name: "body temperature", fuzzyValues: ["boiling", "hot", "warm", "cold", "icy"])
        let healthCategoryItem2 = CategoryItem(name: "health", fuzzyValues: ["excellent", "good",  "well-adjusted", "reasonable", "poor"])
        let healthCategoryItem3 = CategoryItem(name: "fitness", fuzzyValues: ["excellent", "good",  "average", "lacking", "out of shape"])
        let healthCategoryItems = [healthCategoryItem, healthCategoryItem2, healthCategoryItem3]
        
        categories.append(Category(categoryTitle: "Health", categorySubTitle: "Everything about a person's health and well-being", categoryItems: healthCategoryItems, image: UIImage(named: "Health")!))
        
        //weather category
        let weatherCategoryItem = CategoryItem(name: "temperature", fuzzyValues: ["boiling", "hot", "warm", "cold", "icy"])
        let weatherCategoryItem2 = CategoryItem(name: "weather", fuzzyValues: ["blazing hot", "hot", "warm", "fresh", "cold", "frosty"])
        let weatherCategoryItem3 = CategoryItem(name: "precipitation", fuzzyValues: ["torrential", "hard", "wet", "gentle", "soft"])
        let weatherCategoryItems = [weatherCategoryItem, weatherCategoryItem2, weatherCategoryItem3]
        
        categories.append(Category(categoryTitle: "Weather", categorySubTitle: "All items concerning temperature and weather", categoryItems: weatherCategoryItems, image: UIImage(named: "Weather")!))
        
        //outdoor sports category
        
        let sampleCategoryItem = CategoryItem(name: "running", fuzzyValues: ["excellent", "good",  "average", "bad", "poor"])
        let sampleCategoryItem2 = CategoryItem(name: "hiking", fuzzyValues: ["excellent", "good",  "average", "bad", "poor"])
        let sampleCategoryItem3 = CategoryItem(name: "cycling", fuzzyValues: ["excellent", "good",  "average", "bad", "poor"])
        let sampleCategoryItem4 = CategoryItem(name: "climbing", fuzzyValues: ["excellent", "good",  "average", "bad", "poor"])
         let sampleCategoryItem5 = CategoryItem(name: "skiing", fuzzyValues: ["excellent", "good",  "average", "bad", "poor"])
        let sampleCategoryItems = [sampleCategoryItem, sampleCategoryItem2, sampleCategoryItem3, sampleCategoryItem4, sampleCategoryItem5]
        
        categories.append(Category(categoryTitle: "Outdoor Sports", categorySubTitle: "Everything about outdoor sports", categoryItems: sampleCategoryItems, image: UIImage(named: "Running")!))
        
        
        return categories
    }
}
