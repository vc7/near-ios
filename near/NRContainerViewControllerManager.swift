//
//  NRContainerViewControllerManager.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

class NRContainerViewControllerManager: NSObject {
    
    // MARK: - Singleton
    
    static let `default` = NRContainerViewControllerManager()
    
    private override init() {
        super.init()
    }
    
    // MARK: - Basic
    
    let containerViewController = NRContainerViewController()
    
    func presetPreparingViewController() {
        self.containerViewController.loadViewIfNeeded()
        self.containerViewController.currentViewController = NRPreparingViewController()
    }
}
