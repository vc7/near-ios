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
    @IBOutlet internal weak var locationInformationHUDBackground: UIView!
    @IBOutlet internal weak var locationInformationHUD: UIView!
    @IBOutlet internal weak var prefectureLabel: UILabel!
    @IBOutlet internal weak var cityNameLabel: UILabel!
    @IBOutlet internal weak var nearByStationsLabel: UILabel!
    @IBOutlet internal weak var currentTemperatureLabel: UILabel!
    @IBOutlet internal weak var additionInformationLabel: UILabel!
    
    @IBOutlet internal weak var locationInformationHUDTopConstraint: NSLayoutConstraint!
    @IBOutlet internal weak var locationInformationHUDHeightConstraint: NSLayoutConstraint! {
        didSet {
            locationInformationHUDHeight = locationInformationHUDHeightConstraint.constant
        }
    }
    internal var locationInformationHUDHeight: CGFloat = 0
    
    internal let galleryCell = Bundle.main.loadNibNamed("NRHomeGalleryCell", owner: nil, options: nil)?.first as? NRHomeGalleryCell ?? NRHomeGalleryCell()
    
    // MARK: - Data
    
    internal var locationInformation: NRNLocation? {
        didSet {
            self.updateLocationInformationHUD(locationInformation)
        }
    }
    internal var photos: [NRNPhoto]? {
        didSet {
            self.galleryCell.photos = photos
        }
    }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNotificationObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.removeNotificationObservers()
    }
    
    deinit {
        self.removeNotificationObservers()
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
            
            let spot = self.spots?[indexPath.row]
            cell.spot = spot
            
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
            self.locationInformationHUDBackground.alpha = 1
        } else if contentOffsetY > 0 {
            self.locationInformationHUDTopConstraint.constant = self.locationInformationHUDHeight
            self.locationInformationHUD.alpha = 0
            self.locationInformationHUDBackground.alpha = 0
        } else {
            self.locationInformationHUDTopConstraint.constant = (-self.locationInformationHUDHeight - contentOffsetY) / 2
            let alpha = (-contentOffsetY) / self.locationInformationHUDHeight
            self.locationInformationHUD.alpha = alpha
            self.locationInformationHUDBackground.alpha = alpha
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

// MARK: - Notification Actions
extension NRHomeViewController {
    
    internal func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(locationDidUpdate(_:)), name: .NRLocationDidUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(photosDidUpdate(_:)), name: .NRPhotosDidUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(spotsDidUpdate(_:)), name: .NRSpotsDidUpdate, object: nil)
    }
    
    internal func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: .NRLocationDidUpdate, object: nil)
        NotificationCenter.default.removeObserver(self, name: .NRPhotosDidUpdate, object: nil)
        NotificationCenter.default.removeObserver(self, name: .NRSpotsDidUpdate, object: nil)
    }
    
    internal func locationDidUpdate(_ sender: Notification) {
        self.locationInformation = sender.object as? NRNLocation
    }
    
    internal func photosDidUpdate(_ sender: Notification) {
        self.photos = sender.object as? [NRNPhoto]
        self.tableView.reloadSections(IndexSet(integer: NRHomeTableViewSection.gallery.rawValue) , with: .none)
    }
    
    internal func spotsDidUpdate(_ sender: Notification) {
        self.spots = sender.object as? [NRNSpot]
        self.tableView.reloadSections(IndexSet(integer: NRHomeTableViewSection.spots.rawValue) , with: .none)
    }
}

extension NRHomeViewController {
    internal func updateLocationInformationHUD(_ location: NRNLocation?) {
        DispatchQueue.main.async {
            
            self.prefectureLabel.text = location?.city?.prefecture ?? "--"
            self.cityNameLabel.text = location?.city?.name ?? "--"
            
            var formattedStationNames = "--"
            
            if let stations = location?.nearByStations {
                formattedStationNames = stations.joined(separator: " ")
            }
            
            self.nearByStationsLabel.text = "最寄駅 - " + formattedStationNames
            
            self.currentTemperatureLabel.text = location?.temperature?.current
            self.additionInformationLabel.text = "\(location?.temperature?.low ?? "--") / \(location?.temperature?.high ?? "--") °C"
            
            if let location = location {
                
            } else {
                // TODO: Add reload.
            }
        }
    }
}
