//
//  CrispValuesForCategoriesViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 09.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit
import CollapsibleTableSectionViewController

class CrispValuesForCategoriesViewController: CollapsibleTableSectionViewController, CollapsibleTableSectionDelegate {
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationItem.title = "Select Crisp Values"
        self.categories = Category.readExampleCategories() ?? Category.getExampleCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(_ tableView: UITableView) -> Int {
        return self.categories.count
    }
    
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories[section].categoryItems.count
    }
    
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.categories[section].title

    }
    
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CrispValueCell ??
            CrispValueCell(style: .default, reuseIdentifier: "Cell")
        cell.nameLabel.text = categories[indexPath.section].categoryItems[indexPath.row].title
        let crispValue  = UserDefaults.standard.float(forKey: self.categories[indexPath.section].title+self.categories[indexPath.section].categoryItems[indexPath.row].title)
        cell.crispValueLabel.text = String (crispValue )
        print("REad crispValue" + crispValue.description)
        return cell
    }
    
    func shouldCollapseOthers(_ tableView: UITableView) -> Bool {
        return true
    }
    
    func shouldCollapseByDefault(_ tableView: UITableView) -> Bool {
        return true
    }
    
    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CrispValueCell

        let selectedCategoryItem = self.categories[indexPath.section].categoryItems[indexPath.row]
        let minimumFuzzyValue = self.getMinimumOfFuzzyValuesForItem(categoryItem: selectedCategoryItem)
        let maximumFuzzyValue = self.getMaximumOfFuzzyValuesForItem(categoryItem: selectedCategoryItem)
        var message: String
        //Create the alert controller.
        if minimumFuzzyValue == -2.5 {
            message = "From 0 (lowest) to 10 (highest)"
        } else {
            message = "From " + String(minimumFuzzyValue) + " (lowest) to " + String(maximumFuzzyValue) + " (highest)"
        }
        let alert = UIAlertController(title: "Select crisp value for " + (cell.nameLabel.text ?? "N/A"), message: message, preferredStyle: .alert)
        
        //Add the text field.
        alert.addTextField { (textField: UITextField) in
            textField.text = cell.crispValueLabel.text ?? "0"
            textField.keyboardType = UIKeyboardType.numbersAndPunctuation //.decimalPad
        }
        
        let saveAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let value = textField!.text!.floatValue
            let userDefaults = UserDefaults.standard
            selectedCategoryItem.crispValue = value
            userDefaults.set(value, forKey: self.categories[indexPath.section].title+selectedCategoryItem.title)
            print(value.description)
        })
        
        saveAction.isEnabled = true
        // adding the notification observer here which checks if input value is in the valid range from 0 to 10
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object:alert.textFields?[0], queue: OperationQueue.main) { (notification) -> Void in
            
            let textFieldValue = alert.textFields![0]
            saveAction.isEnabled = self.isValidCrispValue(valueString: textFieldValue.text!, minimum: minimumFuzzyValue, maximum: maximumFuzzyValue) &&  !textFieldValue.text!.isEmpty
        }
        
        //Grab the value from the text field, and save the crisp value when user presses OK.
        alert.addAction(saveAction)
        
        //Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        self.viewDidLoad()
    }
    
    func isValidCrispValue(valueString: String, minimum: Double, maximum: Double) -> Bool {
        // check if string is valid floating value
        if valueString.floatValue != Float.nan {
            if minimum == -2.5 { // needed for 0-10 range, since we dont actually want users to input until -2.5 but the membership function is defined that way to correctly represent 0s and 10s
                return valueString.floatValue >= 0 && valueString.floatValue <= 10
            } else if minimum != Double.nan && maximum != Double.nan {
                return valueString.floatValue >= Float(minimum) && valueString.floatValue <= Float(maximum)
            } else {
                //always set to true, if minimum or maximum was nan to allow any value
                return true
            }
        } else {
            return false
        }
    }
    
    internal func getMinimumOfFuzzyValuesForItem(categoryItem: CategoryItem) -> Double {
        if categoryItem.fuzzyValues.isEmpty == false {
            var minimum: Double = categoryItem.fuzzyValues.first!.minimum
            for fuzzyValue in categoryItem.fuzzyValues {
                if minimum > fuzzyValue.minimum {
                    minimum = fuzzyValue.minimum
                }
            }
            return minimum
        }
        return Double.nan
    }
    
    internal func getMaximumOfFuzzyValuesForItem(categoryItem: CategoryItem) -> Double {
        if categoryItem.fuzzyValues.isEmpty == false {
            var maximum: Double = categoryItem.fuzzyValues.first!.maximum
            for fuzzyValue in categoryItem.fuzzyValues {
                if maximum < fuzzyValue.maximum {
                    maximum = fuzzyValue.maximum
                }
            }
            return maximum
        }
        return Double.nan
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
