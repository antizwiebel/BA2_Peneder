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
    
    /// Shadow View
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryImage.layer.cornerRadius = 15.0
        shadowView.layer.cornerRadius = 15.0
        categoryImage.clipsToBounds = true
        categoryImage.blurView.setup(style: UIBlurEffectStyle.dark, alpha: 0.25).enable()
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
    /*
    // MARK: - Shadow
    private func configureShadow() {
        // Shadow View
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: 20,
                                              y: 20,
                                              width: bounds.width - (2 * 20),
                                              height: bounds.height - (2 * 20)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
        self.applyShadow(width: 7, height: 7)
    }
    */
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
