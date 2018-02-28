//
//  CategoryItemViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 26.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

class CategoryItemViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categoryItem: CategoryItem?
    var categoryImage: UIImage?
    var selectedRulepart: RulePart?
    var selectedRulePartIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView: tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinationViewController = segue.destination as! NewRuleViewController
        if let selectedRulepart = self.selectedRulepart {
            //update existing antecedent?
            if selectedRulePartIndex ?? 0 >= 0 {
                destinationViewController.rule?.antecedents![selectedRulePartIndex ?? 0] = selectedRulepart
            //insert new antecedent at the end?
            } else if selectedRulePartIndex ?? 0 == -1 {
                destinationViewController.rule?.antecedents?.append(selectedRulepart)
                if destinationViewController.rule?.antecedents?.count ?? 0 > 0 {
                    destinationViewController.rule?.logicalOperators?.append(LogicalOperator.AND)
                }
            //update consequent?
            } else  if selectedRulePartIndex ?? 0 == -2 {
                destinationViewController.rule?.consequent = selectedRulepart
            }
            destinationViewController.tableView.reloadData()
        }
    }

}
