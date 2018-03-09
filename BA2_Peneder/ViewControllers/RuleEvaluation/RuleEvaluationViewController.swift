//
//  RuleEvaluationViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 08.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

class RuleEvaluationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var rules: [Rule]?
    var categories = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categories = Category.getExampleCategories()
        configure(tableView: self.tableView)
        self.rules = readFromCSVFile(rules: rules)
        sortRulesBySupport()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.rules = readFromCSVFile(rules: rules)
        sortRulesBySupport()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
    func getExampleRules() -> [Rule] {
        var rules = [Rule]()
        
        let fuzzyValues = FuzzyValue.retrieveExampleFuzzyValues()
        
        
        let coldIndex = fuzzyValues.index(where: { (item: FuzzyValue) -> Bool in
            item.title == "cold" // test if this is the item you're looking for
        })
        let icyIndex = fuzzyValues.index(where: { (item: FuzzyValue) -> Bool in
            item.title == "icy" // test if this is the item you're looking for
        })
        let poorIndex = fuzzyValues.index(where: { (item: FuzzyValue) -> Bool in
            item.title == "poor" // test if this is the item you're looking for
        })
        //health category
        let antecedent1 = RulePart (variable: "body temperature", hedge: "", fuzzyValue: fuzzyValues[coldIndex ?? 0] )
        let antecedent2 = RulePart (variable: "temperature", hedge: "", fuzzyValue: fuzzyValues[icyIndex ?? 0] )
        
        let antecedents = [antecedent1, antecedent2, antecedent2, antecedent2, antecedent2]
        
        rules.append(Rule(antecedents: antecedents, consequent: RulePart(variable: "running", hedge: "", fuzzyValue: fuzzyValues[poorIndex ?? 0] ), logicalOperators: [LogicalOperator.AND, LogicalOperator.OR, LogicalOperator.AND,LogicalOperator.OR,LogicalOperator.OR,]))
        rules.append(Rule(antecedents: antecedents, consequent: RulePart(variable: "cycling", hedge: "", fuzzyValue: fuzzyValues[poorIndex ?? 0] ), logicalOperators: [LogicalOperator.AND, LogicalOperator.OR, LogicalOperator.OR,LogicalOperator.OR,LogicalOperator.OR,]))
        
        return rules
    }
    */
    func sortRulesBySupport() {
        self.rules = self.rules!.sorted(by: { $0.degreeOfSupport ?? 0 > $1.degreeOfSupport ?? 0 })
        self.tableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
