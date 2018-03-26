//
//  RuleEvaluationViewController+TableView.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 08.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

extension RuleEvaluationViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "EvaluatedRuleTableViewCell") as! EvaluatedRuleTableViewCell!
        if cell == nil {
            tableView.register(UINib(nibName: "EvaluatedRuleTableViewCell", bundle: nil), forCellReuseIdentifier: "EvaluatedRuleTableViewCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "EvaluatedRuleTableViewCell") as! EvaluatedRuleTableViewCell!
        }
        if let rule = rules?[indexPath.row]{
            cell?.consequentLabel.text = rule.consequent!.variable + " is " + rule.consequent!.fuzzyValue.title
            cell?.antecedentsLabel.text = fillAntecedentLabel(rule: rule)
            cell?.membershipsLabel.text = fillMembershipsLabel(rule: rule)
            cell?.degreeOfSupportLabel.text = "truth: " + String(format: "%.2f", round(100 * rules![indexPath.row].degreeOfSupport!) / 100)
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
    
    func fillAntecedentLabel(rule: Rule) -> String {
        var antecedentString = ""
        if rule.antecedents?.count ?? 0 > 0 {
            let antecedentCount = rule.antecedents?.count ?? 1
            
            for index in 0...(antecedentCount-1) {
                if (index == 0) {
                    antecedentString = antecedentString + rule.antecedents![index].variable + " is " + rule.antecedents![index].fuzzyValue.title
                } else {
                    antecedentString = antecedentString + "\n" + rule.antecedents![index].variable + " is " + rule.antecedents![index].fuzzyValue.title
                }
                if (index != antecedentCount-1) {
                    antecedentString = antecedentString + "\n" + String(describing: rule.logicalOperators![index+1])
                }
            }
        }
        return antecedentString
    }
    
    func fillMembershipsLabel(rule: Rule) -> String {
        var membershipsString = ""
        let crispValues = getCrispValuesForRule(rule: rule)
        if rule.antecedents?.count ?? 0 > 0 {
            let antecedentCount = rule.antecedents?.count ?? 1
            
            for index in 0...(antecedentCount-1) {
                let fuzzyValue = rule.antecedents![index].fuzzyValue
                var memberShip = RuleEvaluation.calculateMembership(x: crispValues[index], a: fuzzyValue.minimum, b: (fuzzyValue.maximum + fuzzyValue.minimum) / 2, c: fuzzyValue.maximum)
                memberShip =  round(100 * memberShip) / 100

                if (index == 0) {
                    membershipsString = membershipsString + String(format: "%.2f", memberShip)
                } else {
                     membershipsString = membershipsString + "\n\n" + String(format: "%.2f", memberShip)
                }
                print(RuleEvaluation.calculateMembership(x: crispValues[index], a: fuzzyValue.minimum, b: (fuzzyValue.maximum + fuzzyValue.minimum) / 2, c: fuzzyValue.maximum).description)
            }
        }
        return membershipsString
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
