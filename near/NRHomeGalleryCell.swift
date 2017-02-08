//
//  NRHomeGalleryCell.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

fileprivate let kNRHomeGalleryPhotoCellIdentifier = "NRHomeGalleryPhotoCellIdentifier"

/// The cell to be display the nearby photos.
class NRHomeGalleryCell: UITableViewCell {

    /// The default ideal height for the instance of `NRHomeGalleryCell`
    static let defaultHeight: CGFloat = 265
    
    var photos: [NRNPhoto]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet internal weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        self.collectionView.register(UINib.init(nibName: "NRHomeGalleryPhotoCell", bundle: nil), forCellWithReuseIdentifier: kNRHomeGalleryPhotoCellIdentifier)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension NRHomeGalleryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNRHomeGalleryPhotoCellIdentifier, for: indexPath) as! NRHomeGalleryPhotoCell
        
        let photo = self.photos?[indexPath.item]
        cell.photo = photo
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension NRHomeGalleryCell: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NRHomeGalleryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return NRHomeGalleryPhotoCell.defaultSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 40, 0, 40)
    }
}
