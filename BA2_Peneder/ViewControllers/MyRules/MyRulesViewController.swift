//
//  MyRulesViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 28.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit
import MessageUI
import CSV

class MyRulesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var rules: [Rule]?
    var selectedRuleIndex: Int?
    var exampleCategories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView: tableView)
        self.exampleCategories = Category.readExampleCategories() ?? Category.getExampleCategories()
        self.rules = readFromCSVFile(rules: rules)
        self.tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.rules = readFromCSVFile(rules: rules)
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        createCSVFile(rules: rules)
        print("VIEW DISAPPEARED")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMyRules(segue:UIStoryboardSegue) { }

    @IBAction func newRuleButtonTapped(_ sender: Any) {
        self.selectedRuleIndex = -1
        performSegue(withIdentifier: "showRuleCreator", sender: self)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        self.tableView.isEditing = !self.tableView.isEditing
        createCSVFile(rules: rules)
        self.rules = readFromCSVFile(rules: rules)
        self.tableView.reloadData()
    }
    
    @IBAction func exportButtonTapped(_ sender: Any) {
        let fileName = "myRules.csv"
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = path.appendingPathComponent(fileName)
            if rules?.count ?? 0 > 0 {
                
                let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
                //exclude certain activities that are not suited for exporting csv files
                vc.excludedActivityTypes = [
                    UIActivityType.assignToContact,
                    UIActivityType.saveToCameraRoll,
                    UIActivityType.postToFlickr,
                    UIActivityType.postToVimeo,
                    UIActivityType.postToTencentWeibo,
                    UIActivityType.postToFacebook,
                    UIActivityType.openInIBooks
                ]
                vc.setValue("My created rules", forKey: "Subject")
                present(vc, animated: true, completion: nil)
            }
        }
    }

    func showErrorAlert(_ title: String, msg: String)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
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
        destinationViewController.navigatedFromMyRules = true
    }
    

}


