//
//  NRPreparingViewController.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit
import CoreLocation

class NRPreparingViewController: UIViewController {
    
    lazy internal var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            let viewController = NRLocationRequestExplanationViewController()
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
            return
        case .authorizedWhenInUse:
            self.presentHomeViewController()
            break
        case .denied, .restricted:
            self.presentMessageViewController()
            break
        default:
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - CLLocationManagerDelegate
extension NRPreparingViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            self.presentHomeViewController()
            break
        case .denied, .restricted:
            self.presentMessageViewController()
            break
        default:
            break
        }
    }
}

// MARK: - NRLocationRequestExplanationViewControllerDelegate
extension NRPreparingViewController: NRLocationRequestExplanationViewControllerDelegate {
    func didConfirmInExplanationViewController(_ explanationViewController: NRLocationRequestExplanationViewController) {
        explanationViewController.dismiss(animated: true) {
            if !CLLocationManager.locationServicesEnabled() {
                self.presentMessageViewController()
                return
            }
            
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
}

// MARK: - Redirection Helpers
extension NRPreparingViewController {
    internal func presentHomeViewController() {
        // TODO: redirect to home view controller
    }
    
    internal func presentMessageViewController() {
        // TODO: redirect to view controller with recommand message
    }
}
