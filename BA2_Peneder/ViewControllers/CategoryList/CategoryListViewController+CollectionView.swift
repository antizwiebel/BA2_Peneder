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
        //register cells
        collectionView.registerReusableCell(WeatherCollectionViewCell.self)
        //configure collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
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
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            return CGSize(width: collectionView.bounds.width, height: BaseCategoryCell.cellHeight)
        } else {
            
            // Number of Items per Row
            let numberOfItemsInRow = 2
            
            // Current Row Number
            let rowNumber = indexPath.item/numberOfItemsInRow
            
            // Compressed With
            let compressedWidth = collectionView.bounds.width/3
            
            // Expanded Width
            let expandedWidth = (collectionView.bounds.width/3) * 2
            
            // Is Even Row
            let isEvenRow = rowNumber % 2 == 0
            
            // Is First Item in Row
            let isFirstItem = indexPath.item % numberOfItemsInRow != 0
            
            // Calculate Width
            var width: CGFloat = 0.0
            if isEvenRow {
                width = isFirstItem ? compressedWidth : expandedWidth
            } else {
                width = isFirstItem ? expandedWidth : compressedWidth
            }
            
            return CGSize(width: width, height: BaseCategoryCell.cellHeight)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            //dismissStoryAnimationController.selectedCardFrame = cell.frame
            self.selectedCategory = categories[indexPath.row]
            performSegue(withIdentifier: "showDetail", sender: self)
        }
    }
    
}
