//
//  CategoryItemTableViewCell.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 22.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

class CategoryItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var view: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        view.layer.cornerRadius = 15.0
        view.clipsToBounds = true
        // Configure the view for the selected state
    }
    
}
