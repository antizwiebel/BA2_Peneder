//
//  SecondViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 21.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

class NewRuleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createRuleButton: UIButton!
    
    var rule: Rule?
    var selectedRulePartIndex: Int?
    var selectedRuleIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // rotate and lock orientation
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
        configure(tableView: tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        canCreateRule()
    }
    
    ///checks if the current rule has at least one antecedent and consequent and, if yes, enables the create button
    func canCreateRule() {
        if self.rule?.antecedents?.count ?? 0 > 0 && self.rule?.consequent != nil {
            self.createRuleButton.isEnabled = true
            self.createRuleButton.backgroundColor = UIColor.myBlue
        } else {
            self.createRuleButton.isEnabled = false
            self.createRuleButton.backgroundColor = UIColor.gray
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToNewRule(segue:UIStoryboardSegue) { }
    
    @IBAction func onCreateButtonTouched(_ sender: Any) {
        print(self.rule!)
        performSegue(withIdentifier: "unwindToMyRules", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        
        switch segue.identifier! {
        case "selectRulePart":
            // Pass the selected RulePart to the CategoryListViewController.
            let destinationViewController = segue.destination as! CategoryListViewController
            if self.selectedRulePartIndex != nil {
                destinationViewController.selectedRulePartIndex = selectedRulePartIndex
            }
        case "unwindToMyRules":
            // Unwind back to the MyRulesViewController with the newly created or updated rule
            let destinationViewController = segue.destination as! MyRulesViewController
            if self.rule != nil {
                //update existing rule?
                if selectedRuleIndex ?? 0 >= 0 {
                    destinationViewController.rules?[selectedRuleIndex ?? 0] = rule!
                    //insert new rule at the end?
                } else if selectedRuleIndex ?? 0 == -1 {
                    destinationViewController.rules?.append(rule!)
                }
                destinationViewController.tableView.reloadData()
            }
        default:
            return
        }
        
    }
}

