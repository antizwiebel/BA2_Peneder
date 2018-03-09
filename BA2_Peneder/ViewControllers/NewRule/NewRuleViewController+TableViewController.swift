//
//  NewRuleViewController+TableViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 25.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

extension NewRuleViewController: UITableViewDelegate, UITableViewDataSource {

    internal func configure(tableView: UITableView) {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        if (rule == nil) {
            rule = Rule ()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfAntecedents = rule?.antecedents?.count ?? 0
        if numberOfAntecedents == 0 {
            return 4
        } else {
            return numberOfAntecedents*2 + 3
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "NewRuleCell") as! NewRuleTableViewCell!
        if cell == nil {
            tableView.register(UINib(nibName: "NewRuleTableViewCell", bundle: nil), forCellReuseIdentifier: "NewRuleCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "NewRuleCell") as! NewRuleTableViewCell!
        }
        let numberOfAntecedents = rule?.antecedents?.count ?? 0
        //first row is always "if"
        if indexPath.row == 0 {
            cell?.label.text = "if"
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.label.textColor = UIColor.black
        // then is always the second-to last row to seperate antecedents from consequent
        } else if (numberOfAntecedents == 0 && indexPath.row == 2) ||
            (numberOfAntecedents != 0 && indexPath.row == (1 + 2*numberOfAntecedents)){
            cell?.label.text = "then"
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.label.textColor = UIColor.black
        // if there is no antecedent yet, insert a placeholder "A" for a possible antecedent
        } else if numberOfAntecedents == 0 && indexPath.row == 1 {
            cell?.label.textColor = UIColor.myBlue
            cell?.label.text = "A"
        // if there is no consequent yet, insert a placeholder "X" for a possible consequent
        } else if (numberOfAntecedents == 0 && indexPath.row == 3 && self.rule?.consequent == nil) ||
            (self.rule?.consequent == nil &&  indexPath.row == (2 + 2*numberOfAntecedents)){
            cell?.label.textColor = UIColor.myBlue
            cell?.label.text = "X"
        //insert RulePart at current row
        } else if (numberOfAntecedents == 0 && indexPath.row == 3 && self.rule?.consequent != nil) || (indexPath.row == (2 + 2*numberOfAntecedents)) {
            cell?.label.textColor = UIColor.myBlue
            let rulepart = self.rule?.consequent ?? RulePart(variable: "A")
            cell?.label.text = rulepart.variable + " is " + rulepart.hedge + " " + rulepart.fuzzyValue.title
        //insert a "+" to indicate that a user can insert more antecedents
        } else if indexPath.row == (2*numberOfAntecedents) {
            cell?.label.textColor = UIColor.myBlue
            cell?.label.text = "+"
        //insert logicalOperator at current row
        } else if indexPath.row % 2 == 0 {
            cell?.label.textColor = UIColor.myBlue
            let index = indexPath.row/2
            let logicalOperator = self.rule?.logicalOperators?[index] ?? LogicalOperator.AND
            cell?.label.text = String(describing: logicalOperator)
        //insert RulePart at current row
        } else {
            cell?.label.textColor = UIColor.myBlue
            let index = indexPath.row/2
            let rulepart = self.rule?.antecedents?[index] ?? RulePart(variable: "A")
            cell?.label.text = rulepart.variable + " is " + rulepart.hedge + " " + rulepart.fuzzyValue.title
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if getIndexCodeForSelectedCell(index: indexPath.row) == -2 {
                rule?.consequent = nil
            } else {
                let index = indexPath.row/2
                rule?.antecedents?.remove(at: index)
                rule?.logicalOperators?.remove(at: index)
                
                if (self.rule?.antecedents?.count ?? 0 > 0 ) {
                    if indexPath.row != 1 {
                        self.tableView.deleteRows(at: [indexPath, IndexPath(row: indexPath.row-1, section: indexPath.section)], with: .fade)
                    } else {
                        self.tableView.deleteRows(at: [indexPath, IndexPath(row: indexPath.row+1, section: indexPath.section)], with: .fade)
                    }
                } else {
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
            canCreateRule()
            self.tableView.reloadData()
        }
    }
        
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let cell = tableView.cellForRow(at: indexPath) as? NewRuleTableViewCell
        let cellText = cell?.label.text
        //only cells with RuleParts are editable
        if cellText == "AND" || cellText == "OR" || cellText == "if" || cellText == "then" || cellText == "A" || cellText == "X" || cellText == "+" {
            return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? NewRuleTableViewCell
        cell?.setSelected(false, animated: true)
        self.tableView.deselectRow(at: IndexPath(row: 0, section: 0) , animated: true)
        
        //switch between the two logicalOperators AND and OR if selected
        if cell?.label.text == "AND" {
            let index = indexPath.row/2
            self.rule?.logicalOperators?[index] = LogicalOperator.OR
        } else if cell?.label.text == "OR" {
            let index = indexPath.row/2
            self.rule?.logicalOperators?[index] = LogicalOperator.AND
        } else {
            //get the indexCode for the selected row and perform segue
            selectedRulePartIndex = getIndexCodeForSelectedCell (index: indexPath.row)
            performSegue(withIdentifier: "selectRulePart", sender: self)
        }
        self.tableView.reloadData()
    }
    
    /// returns the indexCode for a selected cell. Return -1 if a new antecedent should be added, -2 when the consequent should be updated and otherwise the index of a selected antecedent
    func getIndexCodeForSelectedCell(index: Int) -> Int {
        let numberOfAntecedents = rule?.antecedents?.count ?? 0
        
        //corner cases for empty rule
        if numberOfAntecedents == 0 && index != 3 {
            return -1
        } else if numberOfAntecedents == 0 && index == 3 {
            return -2
        }
        
        switch index {
        //new antecedent
        case 2*numberOfAntecedents:
            return -1
        //update consequent
        case 2+2*numberOfAntecedents:
            return -2
        //update antecedent
        default:
            return index/2
        }
    }
    
}

