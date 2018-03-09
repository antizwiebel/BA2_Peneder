//
//  SettingsViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 07.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    //"stretchy" header
    private let kTableHeaderHeight: CGFloat = 180.0
    var headerView: UIView!
    private let kTableHeaderCutAway: CGFloat = 30.0
    var headerMaskLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        //replace header with the imageview
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.white.cgColor
        
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        
        headerView.layer.mask = headerMaskLayer
        updateImageView()
        
        retrieveUserFilters()
    }

    override func viewWillAppear(_ animated: Bool) {
        retrieveUserFilters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrieveUserFilters()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     updates the imageview if the user scrolled, to make it look like a "stretchy header" and
     draw a little triangle over the image view.
     */
    func updateImageView() {
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + kTableHeaderCutAway/2
        }
        
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height))
        headerMaskLayer?.path = path.cgPath
    }
    
    func retrieveUserFilters() {
        let defaults = UserDefaults.standard
        
        if let preferredCategories = defaults.object(forKey: "PreferredCategories") as? [Category] {
            var preferredCategoriesString = ""
            for index in 0...preferredCategories.count-1 {
                preferredCategoriesString.append(preferredCategories[index].title)
                if index !=  preferredCategories.count-1{
                    preferredCategoriesString.append(", ")
                }
            }
            self.tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.detailTextLabel?.text = preferredCategoriesString
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let viewController = CrispValuesForCategoriesViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateImageView()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
