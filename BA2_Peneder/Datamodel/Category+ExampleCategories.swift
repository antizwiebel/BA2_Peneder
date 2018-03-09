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
        
       
        let bodyTemperatureFuzzyValues = [FuzzyValue(title: "boiling", minimum: 8, maximum: 12),
            FuzzyValue(title: "hot", minimum: 6, maximum: 10),
            FuzzyValue(title: "warm", minimum: 4, maximum: 8),
            FuzzyValue(title: "cold", minimum: 2, maximum: 6),
            FuzzyValue(title: "icy", minimum: -2, maximum: 4)]
        let healthFuzzyValues = [FuzzyValue(title: "excellent", minimum: 8, maximum: 12),
                                          FuzzyValue(title: "good", minimum: 6, maximum: 10),
                                          FuzzyValue(title: "well-adjusted", minimum: 4, maximum: 8),
                                          FuzzyValue(title: "reasonable", minimum: 2, maximum: 6),
                                          FuzzyValue(title: "poor", minimum: -2, maximum: 4)]
        let fitnessFuzzyValues = [FuzzyValue(title: "excellent", minimum: 8, maximum: 12),
                                          FuzzyValue(title: "good", minimum: 6, maximum: 10),
                                          FuzzyValue(title: "average", minimum: 4, maximum: 8),
                                          FuzzyValue(title: "lacking", minimum: 2, maximum: 6),
                                          FuzzyValue(title: "out of shape", minimum: -2, maximum: 4)]
        //health category
        let healthCategoryItem = CategoryItem(name: "body temperature", fuzzyValues: bodyTemperatureFuzzyValues)
        let healthCategoryItem2 = CategoryItem(name: "health", fuzzyValues: healthFuzzyValues)
        let healthCategoryItem3 = CategoryItem(name: "fitness", fuzzyValues: fitnessFuzzyValues)
        let healthCategoryItems = [healthCategoryItem, healthCategoryItem2, healthCategoryItem3]
        
        categories.append(Category(categoryTitle: "Health", categorySubTitle: "Everything about a person's health and well-being", categoryItems: healthCategoryItems, image: UIImage(named: "Health")!))
        
        let weatherFuzzyValues = [FuzzyValue(title: "hot", minimum: 8, maximum: 12),
                                 FuzzyValue(title: "warm", minimum: 6, maximum: 10),
                                 FuzzyValue(title: "fresh", minimum: 4, maximum: 8),
                                 FuzzyValue(title: "cold", minimum: 2, maximum: 6),
                                 FuzzyValue(title: "frosty", minimum: -2, maximum: 4)]
        let precipitationFuzzyValues = [FuzzyValue(title: "torrential", minimum: 8, maximum: 12),
                                  FuzzyValue(title: "hard", minimum: 6, maximum: 10),
                                  FuzzyValue(title: "wet", minimum: 4, maximum: 8),
                                  FuzzyValue(title: "gentle", minimum: 2, maximum: 6),
                                  FuzzyValue(title: "soft", minimum: -2, maximum: 4)]
        //weather category
        let weatherCategoryItem = CategoryItem(name: "temperature", fuzzyValues: bodyTemperatureFuzzyValues)
        let weatherCategoryItem2 = CategoryItem(name: "weather", fuzzyValues: weatherFuzzyValues)
        let weatherCategoryItem3 = CategoryItem(name: "precipitation", fuzzyValues: precipitationFuzzyValues)
        let weatherCategoryItems = [weatherCategoryItem, weatherCategoryItem2, weatherCategoryItem3]
        
        categories.append(Category(categoryTitle: "Weather", categorySubTitle: "All items concerning temperature and weather", categoryItems: weatherCategoryItems, image: UIImage(named: "Weather")!))
        
        //outdoor sports category
        
        let sportsFuzzyValues = [FuzzyValue(title: "excellent", minimum: 8, maximum: 12),
            FuzzyValue(title: "good", minimum: 6, maximum: 10),
            FuzzyValue(title: "average", minimum: 4, maximum: 8),
            FuzzyValue(title: "bad", minimum: 2, maximum: 6),
            FuzzyValue(title: "poor", minimum: -2, maximum: 4)]
        
        let sampleCategoryItem = CategoryItem(name: "running", fuzzyValues: sportsFuzzyValues)
        let sampleCategoryItem2 = CategoryItem(name: "hiking", fuzzyValues: sportsFuzzyValues)
        let sampleCategoryItem3 = CategoryItem(name: "cycling", fuzzyValues: sportsFuzzyValues)
        let sampleCategoryItem4 = CategoryItem(name: "climbing", fuzzyValues: sportsFuzzyValues)
        let sampleCategoryItem5 = CategoryItem(name: "skiing", fuzzyValues: sportsFuzzyValues)
        let sampleCategoryItems = [sampleCategoryItem, sampleCategoryItem2, sampleCategoryItem3, sampleCategoryItem4, sampleCategoryItem5]
        
        categories.append(Category(categoryTitle: "Outdoor Sports", categorySubTitle: "Everything about outdoor sports", categoryItems: sampleCategoryItems, image: UIImage(named: "Running")!))
        
        
        return categories
    }
    
    static func saveDefaultCrispValuesForItems () {
        let userDefaults = UserDefaults.standard
        let categories = getExampleCategories()
        for category in categories {
            for categoryItem in category.categoryItems {
                userDefaults.set(0.0, forKey: category.title+categoryItem.name)
            }
        }
    }
}
