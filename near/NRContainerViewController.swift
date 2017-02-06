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
    
    var currentConstraints: [NSLayoutConstraint] = []
    var currentViewController: UIViewController? {
        willSet {
            // TODO: remove old one
            if let viewController = currentViewController {
                self.view.removeConstraints(self.currentConstraints)
                self.currentConstraints = []
                
                viewController.removeFromParentViewController()
                viewController.view.removeFromSuperview()
                viewController.didMove(toParentViewController: nil)
            }
        }
        didSet {
            self.updateStatus()
            
            if let viewController = currentViewController {
                self.addChildViewController(viewController)
                
                viewController.loadViewIfNeeded()
                let childView = viewController.view!
                childView.translatesAutoresizingMaskIntoConstraints = false
                
                self.view.addSubview(childView)
                
                self.currentConstraints = [
                    NSLayoutConstraint(item: childView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: childView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: childView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: childView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
                ]
                self.view.addConstraints(self.currentConstraints)
                
                viewController.didMove(toParentViewController: self)
            }
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            } else if viewController.isKind(of: NRMessageViewController.self) {
                self.status = .error
            } else {
                self.status = .default
            }
        } else {
            self.status = .default
        }
    }
}
