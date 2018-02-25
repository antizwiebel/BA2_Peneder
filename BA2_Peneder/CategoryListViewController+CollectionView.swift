//
//  CategoryListViewController+CollectionView.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 21.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

extension CategoryListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    internal func configure(collectionView: UICollectionView) {
        
        //TODO: include cells again
        collectionView.registerReusableCell(WeatherCollectionViewCell.self)

        /**
        collectionView.registerReusableCell(WorldPremiereCell.self)
        collectionView.registerReusableCell(FromTheEditorsCell.self)
        collectionView.registerReusableCell(AppOfTheDayCell.self)
        collectionView.registerReusableCell(GetStartedListCell.self)
        */
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    internal func initSampleCategories() {
        let sampleCategoryItem = CategoryItem(name: "temperature", fuzzyValues: ["Test1", "Sample2", "Example3"])
        let sampleCategoryItem2 = CategoryItem(name: "weather", fuzzyValues: ["Sample2", "Test1", "Example3"])
        let sampleCategoryItem3 = CategoryItem(name: "sports", fuzzyValues: ["Test1", "Sample2", "Example3"])
        let sampleCategoryItems = [sampleCategoryItem, sampleCategoryItem2, sampleCategoryItem3]
        
        categories.append(Category(categoryTitle: "Weather", categorySubTitle: "All items concerning temperature and weather", categoryItems: sampleCategoryItems, image: UIImage(named: "Weather")!))
        categories.append(Category(categoryTitle: "Running", categorySubTitle: "All items concerning temperature and weather", categoryItems: sampleCategoryItems, image: UIImage(named: "Running")!))
        categories.append(Category(categoryTitle: "Health", categorySubTitle: "All items concerning temperature and weather", categoryItems: sampleCategoryItems, image: UIImage(named: "Health")!))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = WeatherCollectionViewCell.dequeue(fromCollectionView: collectionView, atIndexPath: indexPath)
        cell.titleLabel.text = categories[indexPath.row].title
        cell.subTitleLabel.text = categories[indexPath.row].subTitle
        cell.imageView.image = categories[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: BaseCategoryCell.cellHeight)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            //presentStoryAnimationController.selectedCardFrame = cell.frame
            //dismissStoryAnimationController.selectedCardFrame = cell.frame
            self.selectedCategory = categories[indexPath.row]
            performSegue(withIdentifier: "showDetail", sender: self)
        }
    }
    
}
