//
//  FuzzyValue+ExampleFuzzyValues.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 08.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import CSV

extension FuzzyValue {
    
    public static func saveFuzzyValues () {
        let fileName = "exampleFuzzyValues.csv"
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = path.appendingPathComponent(fileName)
            var csvText = ""
            let exampleFuzzyValues = [FuzzyValue(title: "excellent", minimum: 7.5, maximum: 12.5),
                                      FuzzyValue(title: "good", minimum: 5, maximum: 10),
                                      FuzzyValue(title: "average", minimum: 2.5, maximum: 7.5),
                                      FuzzyValue(title: "bad", minimum: 0, maximum: 5),
                                      FuzzyValue(title: "poor", minimum: -2.5, maximum: 2.5),
                                      FuzzyValue(title: "torrential", minimum: 7.5, maximum: 12.5),
                                      FuzzyValue(title: "hard", minimum: 5, maximum: 10),
                                      FuzzyValue(title: "wet", minimum: 2.5, maximum: 7.5),
                                      FuzzyValue(title: "gentle", minimum: 0, maximum: 5),
                                      FuzzyValue(title: "soft", minimum: -2.5, maximum: 2.5),
                                      FuzzyValue(title: "hot", minimum: 7.5, maximum: 12.5),
                                      FuzzyValue(title: "warm", minimum: 5, maximum: 10),
                                      FuzzyValue(title: "fresh", minimum: 2.5, maximum: 7.5),
                                      FuzzyValue(title: "cold", minimum: 0, maximum: 5),
                                      FuzzyValue(title: "frosty", minimum: -2.5, maximum: 2.5),
                                      FuzzyValue(title: "average", minimum: 2.5, maximum: 7.5),
                                      FuzzyValue(title: "lacking", minimum: 0, maximum: 5),
                                      FuzzyValue(title: "out of shape", minimum: -2.5, maximum: 2.5),
                                      FuzzyValue(title: "well-adjusted", minimum: 2.5, maximum: 7.5),
                                      FuzzyValue(title: "reasonable", minimum: 0, maximum: 5),
                                      FuzzyValue(title: "poor", minimum: -2.5, maximum: 2.5),
                                      FuzzyValue(title: "boiling", minimum: 7.5, maximum: 12.5),
                                      FuzzyValue(title: "icy", minimum: -2.5, maximum: 2.5),
                                      FuzzyValue(title: "generous", minimum: 7.5, maximum: 12.5),
                                      FuzzyValue(title: "cheap", minimum: -2.5, maximum: 2.5),
                                      FuzzyValue(title: "delicious", minimum: 7.5, maximum: 12.5),
                                      FuzzyValue(title: "rancid", minimum: -2.5, maximum: 2.5)]
            //add header row
            csvText.append("title,minimum,maximum\n")
            
            for fuzzyValue in exampleFuzzyValues {
                csvText.append(fuzzyValue.description)
                if fuzzyValue.title != exampleFuzzyValues.last?.title {
                    csvText.append("\n")
                }
            }
            do {
                print(csvText)
                try csvText.write(to: fileURL, atomically: true, encoding: .utf8)
            } catch {
                print("Failed to create file")
                print("\(error)")
            }
        }
    }
    
    public static func retrieveFuzzyValuesFromCategoryFile() -> [FuzzyValue]? {
        if let categories = Category.readExampleCategories() {
            var fuzzyValues = [FuzzyValue]()
            for category in categories {
                for categoryItem in category.categoryItems {
                    for fuzzyValue in categoryItem.fuzzyValues {
                        fuzzyValues.append(fuzzyValue)
                    }
                }
            }
            return fuzzyValues
        } else {
            return nil
        }
    }
    
    public static func retrieveExampleFuzzyValues()  -> [FuzzyValue] {
        //HEADER: title,minimum,maximum
        
        let stream = InputStream(url: (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("exampleFuzzyValues.csv"))!)
        var readFuzzyValues = [FuzzyValue]()
        if let csv = try? CSVReader(stream: stream!, hasHeaderRow: true) {
            print(csv.headerRow ?? "empty header!")
            while csv.next() != nil {
                readFuzzyValues.append(FuzzyValue(title: csv["title"]!, minimum:  (csv["minimum"]! as NSString).doubleValue, maximum:  (csv["maximum"]! as NSString).doubleValue))
            }
        }
        return readFuzzyValues
    }
    
}
