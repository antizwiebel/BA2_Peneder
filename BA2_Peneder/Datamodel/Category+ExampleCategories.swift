//
//  Category+ExampleCategories.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 28.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

extension Category {
    
    ///Used to retrieve fully defined example categories to showcase the functionality of the app and for testing purposes
    /// - Returns: a set of three categories plus items for testing
    static func getExampleCategories() -> [Category] {
        var categories = [Category]()
        
       
        let bodyTemperatureFuzzyValues = [FuzzyValue(title: "boiling", minimum: 7.5, maximum: 12.5),
            FuzzyValue(title: "hot", minimum: 5, maximum: 10),
            FuzzyValue(title: "warm", minimum: 2.5, maximum: 7.5),
            FuzzyValue(title: "cold", minimum: 0, maximum: 5),
            FuzzyValue(title: "icy", minimum: -2.5, maximum: 2.5)]
        let healthFuzzyValues = [FuzzyValue(title: "excellent", minimum: 7.5, maximum: 12.5),
                                          FuzzyValue(title: "good", minimum: 5, maximum: 10),
                                          FuzzyValue(title: "well-adjusted", minimum: 2.5, maximum: 7.5),
                                          FuzzyValue(title: "reasonable", minimum: 0, maximum: 5),
                                          FuzzyValue(title: "poor", minimum: -2.5, maximum: 2.5)]
        let fitnessFuzzyValues = [FuzzyValue(title: "excellent", minimum: 7.5, maximum: 12.5),
                                          FuzzyValue(title: "good", minimum: 5, maximum: 10),
                                          FuzzyValue(title: "average", minimum: 2.5, maximum: 7.5),
                                          FuzzyValue(title: "lacking", minimum: 0, maximum: 5),
                                          FuzzyValue(title: "out of shape", minimum: -2.5, maximum: 2.5)]
        //health category
        let healthCategoryItem = CategoryItem(name: "body temperature", fuzzyValues: bodyTemperatureFuzzyValues)
        let healthCategoryItem2 = CategoryItem(name: "health", fuzzyValues: healthFuzzyValues)
        let healthCategoryItem3 = CategoryItem(name: "fitness", fuzzyValues: fitnessFuzzyValues)
        let healthCategoryItems = [healthCategoryItem, healthCategoryItem2, healthCategoryItem3]
        
        categories.append(Category(categoryTitle: "Health", categorySubTitle: "Everything about a person's health and well-being", categoryItems: healthCategoryItems, image: UIImage(named: "Health")!))
        
        let weatherFuzzyValues = [FuzzyValue(title: "hot", minimum: 7.5, maximum: 12.5),
                                 FuzzyValue(title: "warm", minimum: 5, maximum: 10),
                                 FuzzyValue(title: "fresh", minimum: 2.5, maximum: 7.5),
                                 FuzzyValue(title: "cold", minimum: 0, maximum: 5),
                                 FuzzyValue(title: "frosty", minimum: -2.5, maximum: 2.5)]
        let precipitationFuzzyValues = [FuzzyValue(title: "torrential", minimum: 7.5, maximum: 12.5),
                                  FuzzyValue(title: "hard", minimum: 5, maximum: 10),
                                  FuzzyValue(title: "wet", minimum: 2.5, maximum: 7.5),
                                  FuzzyValue(title: "gentle", minimum: 0, maximum: 5),
                                  FuzzyValue(title: "soft", minimum: -2.5, maximum: 2.5)]
        //weather category
        let weatherCategoryItem = CategoryItem(name: "temperature", fuzzyValues: bodyTemperatureFuzzyValues)
        let weatherCategoryItem2 = CategoryItem(name: "weather", fuzzyValues: weatherFuzzyValues)
        let weatherCategoryItem3 = CategoryItem(name: "precipitation", fuzzyValues: precipitationFuzzyValues)
        let weatherCategoryItems = [weatherCategoryItem, weatherCategoryItem2, weatherCategoryItem3]
        
        categories.append(Category(categoryTitle: "Weather", categorySubTitle: "All items concerning temperature and weather", categoryItems: weatherCategoryItems, image: UIImage(named: "Weather")!))
        
        //outdoor sports category
        
        let sportsFuzzyValues = [FuzzyValue(title: "excellent", minimum: 7.5, maximum: 12.5),
            FuzzyValue(title: "good", minimum: 5, maximum: 10),
            FuzzyValue(title: "average", minimum: 2.5, maximum: 7.5),
            FuzzyValue(title: "bad", minimum: 0, maximum: 5),
            FuzzyValue(title: "poor", minimum: -2.5, maximum: 2.5)]
        
        let sampleCategoryItem = CategoryItem(name: "running", fuzzyValues: sportsFuzzyValues)
        let sampleCategoryItem2 = CategoryItem(name: "hiking", fuzzyValues: sportsFuzzyValues)
        let sampleCategoryItem3 = CategoryItem(name: "cycling", fuzzyValues: sportsFuzzyValues)
        let sampleCategoryItem4 = CategoryItem(name: "climbing", fuzzyValues: sportsFuzzyValues)
        let sampleCategoryItem5 = CategoryItem(name: "skiing", fuzzyValues: sportsFuzzyValues)
        let sampleCategoryItems = [sampleCategoryItem, sampleCategoryItem2, sampleCategoryItem3, sampleCategoryItem4, sampleCategoryItem5]
        
        categories.append(Category(categoryTitle: "Outdoor Sports", categorySubTitle: "Everything about outdoor sports", categoryItems: sampleCategoryItems, image: UIImage(named: "OutdoorSports")!))
        
        let foodFuzzyValues = [FuzzyValue(title: "delicious", minimum: 7.5, maximum: 12.5),
                                  FuzzyValue(title: "good", minimum: 5, maximum: 10),
                                  FuzzyValue(title: "average", minimum: 2.5, maximum: 7.5),
                                  FuzzyValue(title: "bad", minimum: 0, maximum: 5),
                                  FuzzyValue(title: "rancid", minimum: -2.5, maximum: 2.5)]
        let tipFuzzyValues = [FuzzyValue(title: "generous", minimum: 7.5, maximum: 12.5),
                               FuzzyValue(title: "good", minimum: 5, maximum: 10),
                               FuzzyValue(title: "average", minimum: 2.5, maximum: 7.5),
                               FuzzyValue(title: "bad", minimum: 0, maximum: 5),
                               FuzzyValue(title: "cheap", minimum: -2.5, maximum: 2.5)]
        
        let foodCategoryItem = CategoryItem(name: "food", fuzzyValues: foodFuzzyValues)
        let serviceCategoryItem = CategoryItem(name: "service", fuzzyValues: sportsFuzzyValues)
        let tipCategoryItem = CategoryItem(name: "tip", fuzzyValues: tipFuzzyValues)
        let restaurantCategoryItems = [foodCategoryItem, serviceCategoryItem, tipCategoryItem]

        categories.append(Category(categoryTitle: "Restaurant", categorySubTitle: "Food, service and tips in a restaurant ", categoryItems: restaurantCategoryItems, image: UIImage(named: "Restaurant")!))
        
        return categories
    }
    
    static func readExampleCategories () -> [Category]?{
        if let path = Bundle.main.path(forResource: "example_category_file", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonObj = try JSON(data: data)
                if jsonObj != JSON.null {
                    var readCategories = [Category]()
                    var readCategory = Category()
                    for category in jsonObj["categories"].arrayValue {
                        readCategory.title =  category["title"].stringValue
                        readCategory.subTitle =  category["title"].stringValue
                        readCategory.image = UIImage(named: category["image"].stringValue)
                        readCategory.categoryItems = readCategoryItemsFromArray(categoryItemArray: category["categoryItems"].arrayValue)
                        readCategories.append(readCategory)
                        readCategory = Category()
                    }
                    return readCategories
                }
            } catch let error {
                print(error.localizedDescription)
            }

        }
        return nil
    }
    
    static internal func readCategoryItemsFromArray(categoryItemArray: [JSON]) -> [CategoryItem] {
        var readCategoryItems = [CategoryItem]()
        var readCategoryItem = CategoryItem()
        for categoryItem in categoryItemArray {
            readCategoryItem.title =  categoryItem["title"].stringValue
            readCategoryItem.crispValue =  categoryItem["crispValue"].floatValue
            readCategoryItem.fuzzyValues = readFuzzyValuesFromArray (fuzzyValueArray: categoryItem["fuzzyValues"].arrayValue)
            readCategoryItems.append(readCategoryItem)
            readCategoryItem = CategoryItem()
        }
        return readCategoryItems
    }
    
    static internal func readFuzzyValuesFromArray(fuzzyValueArray: [JSON]) -> [FuzzyValue] {
        var readFuzzyValues = [FuzzyValue]()
        var readFuzzyValue = FuzzyValue(title: "N/A")
        for fuzzyValue in fuzzyValueArray {
            readFuzzyValue.title =  fuzzyValue["title"].stringValue
            readFuzzyValue.minimum =  fuzzyValue["minimum"].doubleValue
            readFuzzyValue.maximum =  fuzzyValue["maximum"].doubleValue
            readFuzzyValues.append(readFuzzyValue)
            readFuzzyValue = FuzzyValue(title: "N/A")
        }
        return readFuzzyValues
    }
    
    static func saveDefaultCrispValuesForItems () {
        let userDefaults = UserDefaults.standard
        let categories = getExampleCategories()
        for category in categories {
            for categoryItem in category.categoryItems {
                userDefaults.set(0.0, forKey: category.title+categoryItem.title)
            }
        }
    }
}
