//
//  NRNRequestsManager.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit
import CoreLocation

extension Notification.Name {
    static let NRLocationDidUpdate: Notification.Name = Notification.Name(rawValue: "NRLocationDidUpdate")
    static let NRPhotosDidUpdate: Notification.Name = Notification.Name(rawValue: "NRPhotosDidUpdate")
    static let NRSpotsDidUpdate: Notification.Name = Notification.Name(rawValue: "NRSpotsDidUpdate")
}

class NRNRequestsManager: NSObject {
    
    lazy internal var containerViewControllerManager = NRContainerViewControllerManager.default
    
    /// The location information used for request data.
    var coordinate: CLLocationCoordinate2D? {
        didSet {
            self.updateLocationInformation()
            self.updatePhotos()
            self.updateSpots()
        }
    }
    
    var locationInformation: NRNLocation?
    var photos: [NRNPhoto]?
    var spots: [NRNSpot]?
    
    static let `default` = NRNRequestsManager()
    
    private override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(currentLocationDidChange(_:)), name: .NRCurrentLocationDidChange, object: nil)
    }
    
    // MARK: - Actions
    
    func currentLocationDidChange(_ sender: Notification) {
        let location = sender.object as? CLLocation
        self.coordinate = location?.coordinate
    }
    
    // MARK: - Request Methods
    
    func updateLocationInformation() {
        if let coordinate = coordinate {
            let service = NRNFetchLocationInformationService()
            
            service.request(longitude: "\(coordinate.longitude)", latitude: "\(coordinate.latitude)", completionHandler: { (result) in
                switch result {
                case .success(let location):
                    self.locationInformation = location
                    NotificationCenter.default.post(name: .NRLocationDidUpdate, object: self.locationInformation)
                    self.containerViewControllerManager.presentHomeViewControllerIfNeeded()
                    break
                case .failure(let error):
                    break
                }
                
            })
        } else {
            // TODO: deal with no coordinate.
        }
    }
    
    func updatePhotos() {
        if let coordinate = coordinate {
            let service = NRNFetchPhotosService()
            
            service.request(longitude: "\(coordinate.longitude)", latitude: "\(coordinate.latitude)", completionHandler: { (result) in
                switch result {
                case .success(let photos):
                    self.photos = photos
                    NotificationCenter.default.post(name: .NRPhotosDidUpdate, object: self.photos)
                    self.containerViewControllerManager.presentHomeViewControllerIfNeeded()
                    break
                case .failure(let error):
                    break
                }
            })
        } else {
            // TODO: deal with no coordinate.
        }
    }
    
    func updateSpots() {
        if let coordinate = coordinate {
            let service = NRNFetchSpotsService()
            
            service.request(longitude: "\(coordinate.longitude)", latitude: "\(coordinate.latitude)", completionHandler: { (result) in
                
                switch result {
                case .success(let spots):
                    self.spots = spots
                    NotificationCenter.default.post(name: .NRSpotsDidUpdate, object: self.spots)
                    self.containerViewControllerManager.presentHomeViewControllerIfNeeded()
                    break
                case .failure(let error):
                    break
                }
            })
        } else {
            // TODO: deal with no coordinate.
        }
    }
}
