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

    // MARK: - Configuration

    internal func configure(collectionView: UICollectionView) {
        //register cells
        collectionView.registerReusableCell(WeatherCollectionViewCell.self)
        //configure collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return preferredCategoriesIndices?.count ?? 0
        case 1:
            return categories.count
        default:
            return 0
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = WeatherCollectionViewCell.dequeue(fromCollectionView: collectionView, atIndexPath: indexPath)
        switch indexPath.section {
        //"preferred categories" section
        case 0:
            cell.titleLabel.text = categories[ self.preferredCategoriesIndices?[indexPath.row] ?? 0].title
            cell.subTitleLabel.text = categories[self.preferredCategoriesIndices?[indexPath.row] ?? 0].subTitle
            cell.imageView.image = categories[self.preferredCategoriesIndices?[indexPath.row] ?? 0].image ?? UIImage(named: "Gradient")
        //"all categories" section
        case 1:
            cell.titleLabel.text = categories[indexPath.row].title
            cell.subTitleLabel.text = categories[indexPath.row].subTitle
            cell.imageView.image = categories[indexPath.row].image ?? UIImage(named: "Gradient")
        default:
            cell.titleLabel.text = categories[indexPath.row].title
            cell.subTitleLabel.text = categories[indexPath.row].subTitle
            cell.imageView.image = categories[indexPath.row].image ?? UIImage(named: "Gradient")
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
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
    
    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
            switch indexPath.section {
            case 0:
                sectionHeader.sectionHeaderLabel.text = "Preferred categories"
            case 1:
                sectionHeader.sectionHeaderLabel.text = "All categories"
            default:
                sectionHeader.sectionHeaderLabel.text = "Section \(indexPath.section)"
            }
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.selectedCategory = self.categories[indexPath.row]
        } else {
            self.selectedCategory = self.categories[self.preferredCategoriesIndices?[indexPath.row] ?? 0]
        }
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
}
