//
//  CategoryDetailViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 22.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var category: Category?
    var selectedCategoryItem: CategoryItem?
    var selectedRulePartIndex: Int?

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure(tableView: tableView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinationViewController = segue.destination as! CategoryItemViewController
        if let selectedCategoryItem = self.selectedCategoryItem {
            destinationViewController.categoryItem = selectedCategoryItem
            destinationViewController.categoryImage = category?.image
            destinationViewController.selectedRulePartIndex = selectedRulePartIndex
        }
    }
    

}
