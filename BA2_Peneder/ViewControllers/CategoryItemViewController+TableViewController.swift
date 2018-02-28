//
//  CategoryItemViewController+TableViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 26.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

extension CategoryItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    internal func configure(tableView: UITableView) {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (categoryItem?.fuzzyValues.count ?? 0) + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "CategoryOverviewCell") as! CategoryOverviewTableViewCell!
            if cell == nil {
                tableView.register(UINib(nibName: "CategoryOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryOverviewCell")
                cell = tableView.dequeueReusableCell(withIdentifier: "CategoryOverviewCell") as! CategoryOverviewTableViewCell!
            }
            cell?.separatorInset = UIEdgeInsets.zero
            cell?.preservesSuperviewLayoutMargins = false
            cell?.layoutMargins = UIEdgeInsets.zero
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.titleLabel.text = self.categoryItem?.name ?? "N/A"
            cell?.subTitleLabel.text = ""
            cell?.view.alpha = 0
            cell?.imageView?.image = self.categoryImage ?? UIImage (named: "Weather")
            cell?.imageView?.contentMode = UIViewContentMode.scaleAspectFill
            return cell!
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemCell") as! CategoryItemTableViewCell!
        if cell == nil {
            tableView.register(UINib(nibName: "CategoryItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryItemCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemCell") as! CategoryItemTableViewCell!
        }
        cell?.label.text = categoryItem?.fuzzyValues[indexPath.row-1] ?? "N/A"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            //create selected rulepart and send to NewRule view
            let selectedFuzzyValue = self.categoryItem?.fuzzyValues[indexPath.row-1]
            //TODO: include possibility to select hedge?
            self.selectedRulepart = RulePart (variable: categoryItem?.name ?? "N/A", hedge: "", fuzzyValue: selectedFuzzyValue ?? "N/A")
            performSegue(withIdentifier: "unwindToNewRule", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 150
        }
        
        return 100
    }
    
    
}
