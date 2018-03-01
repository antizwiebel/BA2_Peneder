//
//  RuleTableViewCell.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 01.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

class RuleTableViewCell: UITableViewCell {
   
    @IBOutlet weak var consequentLabel: UILabel!
    @IBOutlet weak var antecedentsLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryImage.layer.cornerRadius = 15.0
        categoryImage.clipsToBounds = true
        categoryImage.blurView.setup(style: UIBlurEffectStyle.dark, alpha: 0.35).enable()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
