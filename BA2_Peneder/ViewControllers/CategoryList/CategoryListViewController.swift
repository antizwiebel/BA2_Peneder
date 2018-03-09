//
//  CategoryListViewController.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 21.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var categories: [Category] = []
    var selectedCategory: Category?
    var selectedRulePartIndex: Int?
    let interactor = Interactor()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure(collectionView: collectionView)
        self.categories = Category.getExampleCategories()
        
        // rotate and lock orientation
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationViewController = segue.destination as! CategoryDetailViewController
        destinationViewController.transitioningDelegate = self
        destinationViewController.interactor = interactor
        
        if let selectedCategory = self.selectedCategory {
            destinationViewController.category = selectedCategory
            destinationViewController.selectedRulePartIndex = selectedRulePartIndex
        }
    }

}

extension CategoryListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }

}

