//
//  WeatherCollectionViewCell.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 21.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: BaseCategoryCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    internal static func dequeue(fromCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> WeatherCollectionViewCell {
        guard let cell: WeatherCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath) else {
            fatalError("*** Failed to dequeue WeatherCollectionViewCell ***")
        }
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius = 15.0
        imageView.clipsToBounds = true
    }

}
