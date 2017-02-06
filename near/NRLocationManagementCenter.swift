//
//  NRLocationManagementCenter.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit
import CoreLocation

extension Notification.Name {
    static let NRCurrentLocationDidChange: Notification.Name = Notification.Name("NRCurrentLocationDidChange")
}

class NRLocationManagementCenter: NSObject {
    
    var shouldDeterminAuthorizationStatus: Bool {
        get {
            return currentStatus == .notDetermined
        }
    }
    internal(set) var currentLocation: CLLocation? {
        didSet {
            NotificationCenter.default.post(name: .NRCurrentLocationDidChange, object: currentLocation)
        }
    }
    internal var currentStatus = CLLocationManager.authorizationStatus()
    
    lazy internal var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    // MARK: - Life cycle
    
    static let `default` = NRLocationManagementCenter()
    
    private override init() {
        super.init()
    }
}

extension NRLocationManagementCenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.processStatus(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.currentLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}

extension NRLocationManagementCenter {
    
    func processCurrentStatus() {
        self.processStatus(self.currentStatus)
    }
    
    func processStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // TODO: Notification or delegate
            return
        case .authorizedWhenInUse:
            self.updateLocation()
            break
        case .denied, .restricted:
            // TODO: Notification or delegate
            break
        default:
            break
        }
    }
    
    func requestAuthorization() {
        if !CLLocationManager.locationServicesEnabled() {
            // TODO: Reaction for open location service
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func updateLocation() {
        if !CLLocationManager.locationServicesEnabled() {
            // TODO: Reaction for open location service
        } else {
            self.locationManager.requestLocation()
        }
    }
}
