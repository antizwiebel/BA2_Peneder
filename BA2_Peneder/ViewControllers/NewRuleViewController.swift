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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView: tableView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if self.rule?.antecedents?.count ?? 0 > 0 && self.rule?.consequent != nil {
            self.createRuleButton.isEnabled = true
            self.createRuleButton.backgroundColor = UIColor.myBlue
        } else {
            self.createRuleButton.isEnabled = false
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToNewRule(segue:UIStoryboardSegue) { }

    
    @IBAction func onCreateButtonTouched(_ sender: Any) {
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinationViewController = segue.destination as! CategoryListViewController
        if let selectedRulepartIndex = self.selectedRulePartIndex {
            destinationViewController.selectedRulePartIndex = selectedRulePartIndex
        }
    }
}

