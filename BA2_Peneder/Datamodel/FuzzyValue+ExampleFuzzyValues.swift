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
            let exampleFuzzyValues = [FuzzyValue(title: "excellent", minimum: 8, maximum: 12),
                                      FuzzyValue(title: "good", minimum: 6, maximum: 10),
                                      FuzzyValue(title: "average", minimum: 4, maximum: 8),
                                      FuzzyValue(title: "bad", minimum: 2, maximum: 6),
                                      FuzzyValue(title: "poor", minimum: -2, maximum: 4),
                                      FuzzyValue(title: "torrential", minimum: 8, maximum: 12),
                                      FuzzyValue(title: "hard", minimum: 6, maximum: 10),
                                      FuzzyValue(title: "wet", minimum: 4, maximum: 8),
                                      FuzzyValue(title: "gentle", minimum: 2, maximum: 6),
                                      FuzzyValue(title: "soft", minimum: -2, maximum: 4),
                                      FuzzyValue(title: "hot", minimum: 8, maximum: 12),
                                      FuzzyValue(title: "warm", minimum: 6, maximum: 10),
                                      FuzzyValue(title: "fresh", minimum: 4, maximum: 8),
                                      FuzzyValue(title: "cold", minimum: 2, maximum: 6),
                                      FuzzyValue(title: "frosty", minimum: -2, maximum: 4),
                                      FuzzyValue(title: "average", minimum: 4, maximum: 8),
                                      FuzzyValue(title: "lacking", minimum: 2, maximum: 6),
                                      FuzzyValue(title: "out of shape", minimum: -2, maximum: 4),
                                      FuzzyValue(title: "well-adjusted", minimum: 4, maximum: 8),
                                      FuzzyValue(title: "reasonable", minimum: 2, maximum: 6),
                                      FuzzyValue(title: "poor", minimum: -2, maximum: 4),
                                      FuzzyValue(title: "boiling", minimum: 8, maximum: 12),
                                      FuzzyValue(title: "icy", minimum: -2, maximum: 4)]
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
    
    public static func retrieveExampleFuzzyValues()  -> [FuzzyValue] {
        //HEADER: title,minimum,maximum
        
        let stream = InputStream(url: (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("exampleFuzzyValues.csv"))!)
        let csv = try! CSVReader(stream: stream!, hasHeaderRow: true)
        print(csv.headerRow ?? "empty header!")
        
        var readFuzzyValues = [FuzzyValue]()
        while csv.next() != nil {            
            readFuzzyValues.append(FuzzyValue(title: csv["title"]!, minimum:  (csv["minimum"]! as NSString).doubleValue, maximum:  (csv["maximum"]! as NSString).doubleValue))
        }
        print (readFuzzyValues)
        return readFuzzyValues
    }
    
}
