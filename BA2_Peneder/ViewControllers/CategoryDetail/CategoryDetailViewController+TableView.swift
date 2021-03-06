//
//  CategoryDetailViewController+TableView.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 22.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

extension CategoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    internal func configure(tableView: UITableView) {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (category?.categoryItems.count ?? 0) + 1
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
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.titleLabel.text = category?.title ?? "N/A"
            cell?.subTitleLabel.text = "Select the variable and its value" //category?.subTitle ?? "N/A"
            cell?.imageView?.image = category?.image ?? UIImage (named: "Weather")
            cell?.imageView?.contentMode = UIViewContentMode.scaleAspectFill
            return cell!
        }

        var cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemCell") as! CategoryItemTableViewCell!
        if cell == nil {
            tableView.register(UINib(nibName: "CategoryItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryItemCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemCell") as! CategoryItemTableViewCell!
        }
        cell?.label.text = category?.categoryItems[indexPath.row-1].title ?? "N/A"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            self.tableView.deselectRow(at: indexPath, animated: true)
            let cell = tableView.cellForRow(at: indexPath) as? CategoryItemTableViewCell

            self.selectedCategoryItem = category?.categoryItems[indexPath.row-1]
            cell?.setSelected(false, animated: true)
            
            performSegue(withIdentifier: "showValues", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 200
        }
        
        return 100
    }
    
    
}
