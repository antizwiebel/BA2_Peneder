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
    var selectedRuleIndex: Int?
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

    override func viewWillDisappear(_ animated: Bool) {
        createCSVFile(rules: rules)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToRuleEvaluation(segue:UIStoryboardSegue) { }
    
    func sortRulesBySupport() {
        self.rules = self.rules!.sorted(by: { $0.degreeOfSupport ?? 0 > $1.degreeOfSupport ?? 0 })
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destinationViewController = segue.destination as! NewRuleViewController
        
        //update rule?
        if selectedRuleIndex != -1 {
            destinationViewController.rule = rules?[selectedRuleIndex!]
        }
        destinationViewController.selectedRuleIndex = selectedRuleIndex ?? -1
        destinationViewController.navigatedFromMyRules = false
    }

}
