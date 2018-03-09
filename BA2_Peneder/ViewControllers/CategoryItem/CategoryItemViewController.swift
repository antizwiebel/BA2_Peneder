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
    var interactor:Interactor? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView: tableView)
        tableView.panGestureRecognizer.addTarget(self, action: Selector("handleGesture:"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.3
        
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
    }
    
    // Refactoring the progress calculation.
    // In the case of dragging downward, pulling down 50, and the screen height is 500, results in 0.10
    func progressAlongAxis(pointOnAxis: CGFloat, axisLength: CGFloat) -> CGFloat {
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
        let positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
        return CGFloat(positiveMovementOnAxisPercent)
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
                destinationViewController.rule?.ruleImage = categoryImage ?? UIImage(named: "Running")
            }
            destinationViewController.tableView.reloadData()
        }
    }

}
