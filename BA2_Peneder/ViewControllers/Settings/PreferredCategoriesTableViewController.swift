//
//  PreferredCategoriesTableViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 07.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

class PreferredCategoriesTableViewController: UITableViewController {

    var categories: [Category] = []
    var selectedCategoriesIndices: [Int]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        self.categories = Category.getExampleCategories()
        retrievePreferredCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].title
        cell.detailTextLabel?.text = categories[indexPath.row].subTitle
        return cell
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(selectedCategoriesIndices, forKey: "PreferredCategories")
        
        defaults.synchronize()
        self.navigationController?.popViewController(animated: true)
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCategoriesIndices == nil {
            selectedCategoriesIndices = [Int]()
        }
        //check if item is already in selected categories, if yes, delete it and remove checkmark from cell and if no, insert it and add a checkmark to cell
        if let index = selectedCategoriesIndices?.index(where: { $0 == indexPath.row }) {
            selectedCategoriesIndices?.remove(at: index)
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        } else {
            selectedCategoriesIndices?.append(indexPath.row)
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    /// retrieves the preferred categories from the Userdefaults and selects the corresponding cells as well as adding a checkmark on the right
    func retrievePreferredCategories() {
        let defaults = UserDefaults.standard
        
        if let preferredCategoriesIndices = defaults.object(forKey: "PreferredCategories") as? [Int] {
            for index in preferredCategoriesIndices {
                let preferredCategoriesIndex =  IndexPath(row: index, section: 0)
                tableView.selectRow(at: preferredCategoriesIndex, animated: true, scrollPosition: UITableViewScrollPosition.bottom)
                tableView.cellForRow(at: preferredCategoriesIndex)?.accessoryType =    UITableViewCellAccessoryType.checkmark
            }
        }
    }
    
}
