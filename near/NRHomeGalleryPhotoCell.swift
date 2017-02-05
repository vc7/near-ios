//
//  NRHomeGalleryPhotoCell.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

/// The cell class to display a single photo in `NHRHomeGallery`'s collection view.
class NRHomeGalleryPhotoCell: UICollectionViewCell {

    /// The default ideal height for the instance of `NRHomeGalleryPhotoCell`
    static let defaultSize: CGSize = CGSize(width: 150.0, height: 185.0)
    
    @IBOutlet internal weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
