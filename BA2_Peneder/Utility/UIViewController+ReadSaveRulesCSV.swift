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

extension UIViewController {
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
    
    func readFromCSVFile(rules: [Rule]?)  -> [Rule]{
        //HEADER: variable,hedge,fuzzyValue,operator
        
        let stream = InputStream(url: (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("myRules.csv"))!)
        let csv = try! CSVReader(stream: stream!, hasHeaderRow: true)
        print(csv.headerRow ?? "empty header!")
        
        var readRules = [Rule]()
        
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
                readRule.degreeOfSupport = MembershipCalculator.defuzzifyRule(rule: readRule, crispValues: getCrispValuesForRule(rule: readRule))
                readRules.append(readRule)
                readRule = Rule()
            default:
                print("Failed to read file")
            }
        }
        print (readRules)
        return readRules
        
    }
    
    func getCrispValuesForRule (rule: Rule) -> [Float] {
        let categories = Category.getExampleCategories()
        var crispValues = [Float]()
        for antecedent in rule.antecedents! {
            for category in categories {
                if let itemIndex = category.categoryItems.index(where: { (item: CategoryItem) -> Bool in
                    if item.name == antecedent.variable {
                        print( item.name + " " + antecedent.variable)
                    }
                    return item.name == antecedent.variable
                }) {
                    let crispValue  = UserDefaults.standard.float(forKey: category.title+category.categoryItems[itemIndex].name)
                    print(category.title+category.categoryItems[itemIndex].name)
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
