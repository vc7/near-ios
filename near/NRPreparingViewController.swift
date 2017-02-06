//
//  NRPreparingViewController.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

class NRPreparingViewController: UIViewController {
    
    lazy internal var locationManagementCenter = NRLocationManagementCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.locationManagementCenter.shouldDeterminAuthorizationStatus {
            let viewController = NRLocationRequestExplanationViewController()
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
        } else {
            self.locationManagementCenter.processCurrentStatus()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - NRLocationRequestExplanationViewControllerDelegate
extension NRPreparingViewController: NRLocationRequestExplanationViewControllerDelegate {
    func didConfirmInExplanationViewController(_ explanationViewController: NRLocationRequestExplanationViewController) {
        explanationViewController.dismiss(animated: true) {
            self.locationManagementCenter.requestAuthorization()
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
