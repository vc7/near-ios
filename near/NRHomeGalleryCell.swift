//
//  NRHomeGalleryCell.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

/// The cell to be display the nearby photos.
class NRHomeGalleryCell: UITableViewCell {

    static let defaultHeight: CGFloat = 250
    @IBOutlet internal weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension NRHomeGalleryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension NRHomeGalleryCell: UICollectionViewDelegate {
}
