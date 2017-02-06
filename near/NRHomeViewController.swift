//
//  NRHomeViewController.swift
//  near
//
//  Created by vincent on 2017/02/04.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

fileprivate let kNRHomeSpotCellIdentifier = "NRHomeSpotCellIdentifier"

fileprivate enum NRHomeTableViewSection: Int {
    case gallery = 0
    case spots = 1
}

class NRHomeViewController: UIViewController {
    
    lazy internal var requestsManager = NRNRequestsManager.default
    
    /// The main table view to hold data
    @IBOutlet internal weak var tableView: UITableView!
    
    /// The HUD to display the basic weather information
    @IBOutlet internal weak var locationInformationHUD: UIView!
    
    @IBOutlet internal weak var locationInformationHUDTopConstraint: NSLayoutConstraint!
    @IBOutlet internal weak var locationInformationHUDHeightConstraint: NSLayoutConstraint! {
        didSet {
            locationInformationHUDHeight = locationInformationHUDHeightConstraint.constant
        }
    }
    internal var locationInformationHUDHeight: CGFloat = 0
    
    internal let galleryCell = Bundle.main.loadNibNamed("NRHomeGalleryCell", owner: nil, options: nil)?.first as? NRHomeGalleryCell ?? NRHomeGalleryCell()
    
    // MARK: - Data
    
    internal var locationInformation: NRNLocation?
    internal var photos: [NRNPhoto]?
    internal var spots: [NRNSpot]?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationInformation = self.requestsManager.locationInformation
        self.photos = self.requestsManager.photos
        self.spots = self.requestsManager.spots
        
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.locationInformationHUDHeightConstraint.constant, 0, 0, 0)
        self.tableView.contentInset = UIEdgeInsetsMake(self.locationInformationHUDHeightConstraint.constant, 0, 0, 0)
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UINib.init(nibName: "NRHomeSpotCell", bundle: nil), forCellReuseIdentifier: kNRHomeSpotCellIdentifier)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource
extension NRHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentSection = NRHomeTableViewSection(rawValue: section) else {
            return 0
        }
        
        switch currentSection {
        case .gallery:
            return 1
        case .spots:
            if let spots = self.spots {
                return spots.count
            } else {
                // TODO: Add placeholder view
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentSection = NRHomeTableViewSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch currentSection {
        case .gallery:
            if let photos = self.photos {
                // TODO: set photos to gallery cell
                return self.galleryCell
            } else {
                // TODO: Add placeholder view
                return UITableViewCell()
            }
        case .spots:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: kNRHomeSpotCellIdentifier, for: indexPath) as! NRHomeSpotCell
            
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension NRHomeViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY < -self.locationInformationHUDHeight {
            self.locationInformationHUDTopConstraint.constant = 0
            self.locationInformationHUD.alpha = 1
        } else if contentOffsetY > 0 {
            self.locationInformationHUDTopConstraint.constant = self.locationInformationHUDHeight
            self.locationInformationHUD.alpha = 0
        } else {
            self.locationInformationHUDTopConstraint.constant = (-self.locationInformationHUDHeight - contentOffsetY) / 2
            self.locationInformationHUD.alpha = (-contentOffsetY) / self.locationInformationHUDHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let currentSection = NRHomeTableViewSection(rawValue: indexPath.section) else {
            return 0
        }
        
        switch currentSection {
        case .gallery:
            return NRHomeGalleryCell.defaultHeight
        case .spots:
            return NRHomeSpotCell.defaultHeight
        }
    }
}
