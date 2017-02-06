//
//  NRContainerViewController.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

enum NRContainerViewControllerStatus: Int {
    case `default` = 0
    case preparing = 1
    case normal = 2
    case error = 3
}

class NRContainerViewController: UIViewController {

    /// The current page status of this container view controller.
    var status: NRContainerViewControllerStatus = .default
    
    var currentViewController: UIViewController? {
        willSet {
            // TODO: remove old one
        }
        didSet {
            self.updateStatus()
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default is loading preparing view controller in.
        self.currentViewController = NRPreparingViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NRContainerViewController {
    internal func updateStatus() {
        if let viewController = self.currentViewController {
            if viewController.isKind(of: NRHomeViewController.self) {
                self.status = .normal
            } else if viewController.isKind(of: NRPreparingViewController.self) {
                self.status = .preparing
            } else {
                self.status = .error
            }
        } else {
            self.status = .default
        }
    }
}
