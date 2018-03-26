//
//  CrispValueCell.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 09.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

/// A TableViewCell which represents a crisp value in the crisp value settings view.
class CrispValueCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let crispValueLabel = UILabel()

    // MARK: Initalizers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // configure nameLabel
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        
        // configure detailLabel
        contentView.addSubview(crispValueLabel)
        crispValueLabel.lineBreakMode = .byWordWrapping
        crispValueLabel.translatesAutoresizingMaskIntoConstraints = false
        crispValueLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        crispValueLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        crispValueLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        crispValueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        crispValueLabel.numberOfLines = 0
        crispValueLabel.font = UIFont.systemFont(ofSize: 18)
        crispValueLabel.textColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
