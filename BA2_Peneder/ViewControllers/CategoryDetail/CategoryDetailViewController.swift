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
    var interactor:Interactor? = nil

    @IBOutlet weak var containerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerLeadingConstraint: NSLayoutConstraint!
    
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
    
    func showHelperCircle(){
        let center = CGPoint(x: view.bounds.width * 0.5, y: 100)
        let small = CGSize(width: 30, height: 30)
        let circle = UIView(frame: CGRect(origin: center, size: small))
        circle.layer.cornerRadius = circle.frame.width/2
        circle.backgroundColor = UIColor.white
        circle.layer.shadowOpacity = 0.8
        circle.layer.shadowOffset = CGSize()
        view.addSubview(circle)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.25,
            options: [],
            animations: {
                circle.frame.origin.y += 200
                circle.layer.opacity = 0
        },
            completion: { _ in
                circle.removeFromSuperview()
        }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure(tableView: tableView)
        tableView.panGestureRecognizer.addTarget(self, action: Selector("handleGesture:"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showHelperCircle()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinationViewController = segue.destination as! CategoryItemViewController
        destinationViewController.transitioningDelegate = self
        destinationViewController.interactor = interactor
        if let selectedCategoryItem = self.selectedCategoryItem {
            destinationViewController.categoryItem = selectedCategoryItem
            destinationViewController.categoryImage = category?.image
            destinationViewController.selectedRulePartIndex = selectedRulePartIndex
        }
    }
    

}

extension CategoryDetailViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (interactor?.hasStarted)! ? interactor : nil
    }
    
}
