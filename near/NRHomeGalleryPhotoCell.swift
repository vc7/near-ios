//
//  NRHomeGalleryPhotoCell.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit
import SDWebImage

/// The cell class to display a single photo in `NHRHomeGallery`'s collection view.
class NRHomeGalleryPhotoCell: UICollectionViewCell {

    /// The default ideal height for the instance of `NRHomeGalleryPhotoCell`
    static let defaultSize: CGSize = CGSize(width: 150.0, height: 185.0)
    
    var photo: NRNPhoto? {
        didSet {
            self.titleLabel.text = photo?.title ?? "--"
            
            if let imageURLString = photo?.media?.mediumUrlString {
                let url = URL(string: imageURLString)
                // TODO: add placeholder image
                self.photoImageView.sd_setImage(with: url, placeholderImage: nil)
            }
            
        }
    }
    
    @IBOutlet internal weak var photoImageView: UIImageView!
    @IBOutlet internal weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
