//
//  NRHomeSpotCell.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit
import SDWebImage

/// The cell class to display a single trend spot.
class NRHomeSpotCell: UITableViewCell {

    /// The default ideal height for the instance of `NRHomeSpotCell`
    static let defaultHeight: CGFloat = 70
    
    var spot: NRNSpot? {
        didSet {
            
            let imageURL = URL(string: spot?.categoryIconUrlString ?? "")
            self.categoryIconImageView.sd_setImage(with: imageURL, placeholderImage: nil)
            
            self.storeNameLabel.text = spot?.name ?? "--"
            
            if let hereCount = spot?.hereCount {
                self.hereNowCountLabel.text = "\(hereCount) 人"
            } else {
                self.hereNowCountLabel.text = "-- 人"
            }
            self.hereNowCountLabel.layoutIfNeeded()
            
            if let distance = spot?.access?.distance {
                self.distanceLabel.text = "\(String(format: "%.0f", distance)) m"
            } else {
                self.distanceLabel.text = "-- m"
            }
            self.distanceLabel.layoutIfNeeded()
        }
    }
    
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
