//
//  NRHomeSpotCell.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

/// The cell class to display a single trend spot.
class NRHomeSpotCell: UITableViewCell {

    /// The default ideal height for the instance of `NRHomeSpotCell`
    static let defaultHeight: CGFloat = 70
    
    @IBOutlet internal weak var categoryIconImageView: UIImageView!
    @IBOutlet internal weak var storeNameLabel: UILabel!
    @IBOutlet internal weak var distanceLabel: UILabel!
    @IBOutlet internal weak var hereNowCountLabel: UILabel!
    @IBOutlet internal weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
}
