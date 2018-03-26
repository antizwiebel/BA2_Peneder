//
//  EvaluatedRuleTableViewCell.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 08.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import UIKit

/// A TableViewCell which shows a rule and its evaluation in the rule evaluation table.
class EvaluatedRuleTableViewCell: UITableViewCell {

    @IBOutlet weak var degreeOfSupportLabel: UILabel!
    @IBOutlet weak var consequentLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var antecedentsLabel: UILabel!
    @IBOutlet weak var membershipsLabel: UILabel!
    @IBOutlet weak var gradientImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientImage.layer.cornerRadius = 15.0
        shadowView.layer.cornerRadius = 15.0
        //gradientImage.clipsToBounds = true
        self.applyShadow(width: 10, height: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.applyShadow(width: 10, height: 10)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.applyShadow(width: 10, height: 10)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Shadow
    
    private func applyShadow(width: CGFloat, height: CGFloat) {
        let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 15.0)
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowRadius = 6.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: width, height: height)
        shadowView.layer.shadowOpacity = 0.35
        shadowView.layer.shadowPath = shadowPath.cgPath
        
    }
    
}
