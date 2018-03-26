//
//  CategoryOverviewTableViewCell.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 21.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

/// A TableViewCell which represents a Category when picking a rule part.
class CategoryOverviewTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
