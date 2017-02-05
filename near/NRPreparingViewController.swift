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
        default:
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NRPreparingViewController: NRLocationRequestExplanationViewControllerDelegate {
    func didConfirmInExplanationViewController(_ explanationViewController: NRLocationRequestExplanationViewController) {
        explanationViewController.dismiss(animated: true, completion: nil)
    }
}
