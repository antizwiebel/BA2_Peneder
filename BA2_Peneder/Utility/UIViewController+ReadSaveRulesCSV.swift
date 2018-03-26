//
//  UIViewController+ReadSaveRulesCSV.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 08.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit
import CSV

/// utility for creating and reading rule csv files
extension UIViewController {
    
    /**
     Creates a csv file on the device's file system containing all the given rules in the specified rule format.
     
     - Parameters:
     - rules: The rules to be saved in the file
    */
    func createCSVFile (rules: [Rule]?) {
        let fileName = "myRules.csv"
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = path.appendingPathComponent(fileName)
            var csvText = ""
            //count the number of rules
            let ruleCount = rules?.count ?? 0
            //add header row
            csvText.append("variable,hedge,fuzzyValue,operator")
            if ruleCount > 0 {
                //add linebreak
                csvText.append("\n")
                
                for index in 0...ruleCount-1 {
                    let newLine = String(describing: rules![index])
                    csvText.append(newLine)
                    if index != ruleCount-1 {
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
    }
    
    /**
     Reads from a csv file on the device's file system containing rules in the specified rule format.
     
     - Returns: The rules retrieved from the file
     */
    func readFromCSVFile(rules: [Rule]?)  -> [Rule]{
        //HEADER format: variable,hedge,fuzzyValue,operator
        
        let stream = InputStream(url: (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("myRules.csv"))!)
        
        var readRules = [Rule]()
        
        if let csv = try? CSVReader(stream: stream!, hasHeaderRow: true) {
            print(csv.headerRow ?? "empty header!")
            
            var readRule = Rule()
            
            let fuzzyValues = FuzzyValue.retrieveExampleFuzzyValues()
            
            while csv.next() != nil {
                switch csv["operator"]! {
                case "C":
                    readRule.consequent = RulePart (variable: csv["variable"]!, hedge: csv["hedge"]!, fuzzyValue: getFuzzyValueForTitle(title: csv["fuzzyValue"]!, fuzzyValues: fuzzyValues))
                    readRule.logicalOperators?.append(LogicalOperator.AND)
                case "AND":
                    readRule.antecedents?.append(RulePart (variable: csv["variable"]!, hedge: csv["hedge"]!, fuzzyValue: getFuzzyValueForTitle(title: csv["fuzzyValue"]!, fuzzyValues: fuzzyValues)))
                    readRule.logicalOperators?.append(LogicalOperator.AND)
                case "OR":
                    readRule.antecedents?.append(RulePart (variable: csv["variable"]!, hedge: csv["hedge"]!, fuzzyValue: getFuzzyValueForTitle(title: csv["fuzzyValue"]!, fuzzyValues: fuzzyValues)))
                    readRule.logicalOperators?.append(LogicalOperator.OR)
                case "END":
                    readRule.antecedents?.append(RulePart (variable: csv["variable"]!, hedge: csv["hedge"]!, fuzzyValue: getFuzzyValueForTitle(title: csv["fuzzyValue"]!, fuzzyValues: fuzzyValues)))
                    //calculate degree of support for read rule
                    readRule.degreeOfSupport = RuleEvaluation.defuzzifyRule(rule: readRule, crispValues: getCrispValuesForRule(rule: readRule))
                    readRules.append(readRule)
                    readRule = Rule()
                default:
                    print("Failed to read file")
                }
            }
        }
        print (readRules)
        return readRules
        
    }
    
    func getCrispValuesForRule (rule: Rule) -> [Float] {
        let categories = Category.readExampleCategories() ?? Category.getExampleCategories()
        var crispValues = [Float]()
        for antecedent in rule.antecedents! {
            for category in categories {
                if let itemIndex = category.categoryItems.index(where: { (item: CategoryItem) -> Bool in
                    if item.title == antecedent.variable {
                        print( item.title + " " + antecedent.variable)
                    }
                    return item.title == antecedent.variable
                }) {
                    let crispValue  = UserDefaults.standard.float(forKey: category.title+category.categoryItems[itemIndex].title)
                    print(category.title+category.categoryItems[itemIndex].title)
                    print("Retrieved Crispvalue: " + crispValue.description)
                    crispValues.append(crispValue)
                }
                
            }
        }
        return crispValues
    }
    
    func getFuzzyValueForTitle(title: String, fuzzyValues: [FuzzyValue]) -> FuzzyValue {
        let itemIndex = fuzzyValues.index(where: { (item: FuzzyValue) -> Bool in
            item.title == title // test if this is the item you're looking for
        })
        //health category
        return fuzzyValues[itemIndex ?? 0]
    }
}
