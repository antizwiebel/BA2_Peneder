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

class MyRulesViewController: UIViewController, MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var rules: [Rule]?
    var selectedRuleIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView: tableView)
        readFromCSVFile()
    }

    override func viewWillDisappear(_ animated: Bool) {
        createCSVFile()

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
        createCSVFile()
        readFromCSVFile()
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
            } else {
                showErrorAlert("Error", msg: "There is no data to export")
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func showErrorAlert(_ title: String, msg: String)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getExampleRules() -> [Rule] {
        var rules = [Rule]()
        
        //health category
        let antecedent1 = RulePart (variable: "body temperature", hedge: "", fuzzyValue: "cold")
        let antecedent2 = RulePart (variable: "temperature", hedge: "", fuzzyValue: "icy")

        let antecedents = [antecedent1, antecedent2, antecedent2, antecedent2, antecedent2]
        
        rules.append(Rule(antecedents: antecedents, consequent: RulePart(variable: "running", hedge: "", fuzzyValue: "poor"), logicalOperators: [LogicalOperator.AND, LogicalOperator.OR, LogicalOperator.OR,LogicalOperator.OR,LogicalOperator.OR,]))
        rules.append(Rule(antecedents: antecedents, consequent: RulePart(variable: "cycling", hedge: "", fuzzyValue: "poor"), logicalOperators: [LogicalOperator.AND, LogicalOperator.OR, LogicalOperator.OR,LogicalOperator.OR,LogicalOperator.OR,]))
        
        return rules
    }
    
    func createCSVFile (){
        let fileName = "myRules.csv"
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = path.appendingPathComponent(fileName)
            var csvText = ""
            //count the number of rules
            let ruleCount = rules?.count ?? 0
            
            if ruleCount > 0 {
                //add header row
                csvText.append("variable,hedge,fuzzyValue,operator\n")
                
                for index in 0...ruleCount-1 {
                    let newLine = String(describing: self.rules![index])
                    csvText.append(newLine)
                    if index != ruleCount-1 {
                        csvText.append("\n")
                    }
                }
                do {
                    print(csvText)
                    try csvText.write(to: fileURL, atomically: true, encoding: .utf8)
                } catch {
                        print("Failed to create file")
                        print("\(error)")
                    }
                    
                } else {
                    showErrorAlert("Error", msg: "There is no data to export")
                }
        }
    }
    
    func readFromCSVFile()  {
        //HEADER: variable,hedge,fuzzyValue,operator
        
        let stream = InputStream(url: (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("myRules.csv"))!)
        let csv = try! CSVReader(stream: stream!, hasHeaderRow: true)
        print(csv.headerRow ?? "empty header!")
        
        var readRules = [Rule]()
        
        var readRule = Rule()
        
        while csv.next() != nil {
            print(csv["operator"]!)
            print(csv.currentRow ?? "empty row")
            switch csv["operator"]! {
            case "C":
                readRule.consequent = RulePart (variable: csv["variable"]!, hedge: csv["hedge"]!, fuzzyValue: csv["fuzzyValue"]!)
                readRule.logicalOperators?.append(LogicalOperator.AND)
            case "AND":
                readRule.antecedents?.append(RulePart (variable: csv["variable"]!, hedge: csv["hedge"]!, fuzzyValue: csv["fuzzyValue"]!))
                readRule.logicalOperators?.append(LogicalOperator.AND)
            case "OR":
                readRule.antecedents?.append(RulePart (variable: csv["variable"]!, hedge: csv["hedge"]!, fuzzyValue: csv["fuzzyValue"]!))
                readRule.logicalOperators?.append(LogicalOperator.OR)
            case "END":
                readRule.antecedents?.append(RulePart (variable: csv["variable"]!, hedge: csv["hedge"]!, fuzzyValue: csv["fuzzyValue"]!))
                readRules.append(readRule)
                readRule = Rule()
            default:
                print("Failed to read file")
            }
        }
        print (readRules)
        self.rules = readRules
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinationViewController = segue.destination as! NewRuleViewController
        //update rule?
        if selectedRuleIndex != -1 {
            destinationViewController.rule = rules?[selectedRuleIndex!]
        }
        destinationViewController.selectedRuleIndex = selectedRuleIndex ?? -1
    }
    

}


