//
//  MyRulesViewController+TableViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 01.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

extension MyRulesViewController: UITableViewDelegate, UITableViewDataSource {
    
    internal func configure(tableView: UITableView) {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "RuleTableViewCell") as! RuleTableViewCell!
        if cell == nil {
            tableView.register(UINib(nibName: "RuleTableViewCell", bundle: nil), forCellReuseIdentifier: "RuleTableViewCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "RuleTableViewCell") as! RuleTableViewCell!
        }
        if let rule = rules?[indexPath.row]{
            cell?.consequentLabel.text = rule.consequent!.variable + " is " + rule.consequent!.fuzzyValue
            cell?.categoryImage.image = rule.ruleImage ?? UIImage (named: "Running")
            cell?.antecedentsLabel.text = fillAntecedentLabel(rule: rule)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            rules?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
    }
    
    func fillAntecedentLabel(rule: Rule) -> String {
        var antecedentString = ""
        if rule.antecedents?.count ?? 0 > 0 {
            let antecedentCount = rule.antecedents?.count ?? 1
            
            for index in 0...(antecedentCount-1) {
                if (index == 0) {
                    antecedentString = antecedentString + rule.antecedents![index].variable + " is " + rule.antecedents![index].fuzzyValue
                } else {
                    antecedentString = antecedentString + "\n" + rule.antecedents![index].variable + " is " + rule.antecedents![index].fuzzyValue
                }
                if (index != antecedentCount-1) {
                    antecedentString = antecedentString + "\n" + String(describing: rule.logicalOperators![index+1])
                }
            }
        }
        return antecedentString
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.rules?[sourceIndexPath.row]
        self.rules?.remove(at: sourceIndexPath.row)
        self.rules?.insert(movedObject!, at: destinationIndexPath.row)
        // To check for correctness enable: self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? RuleTableViewCell
    
        self.selectedRuleIndex = indexPath.row
        cell?.setSelected(false, animated: true)
        
        performSegue(withIdentifier: "showRuleCreator", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}