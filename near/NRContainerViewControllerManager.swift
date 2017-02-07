//
//  NRContainerViewControllerManager.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

enum NRFailure: Error {
    case withoutAuthorization
    case withoutLocationService
    case fetchingLocationFailure
    case offlineFailure
    
    var localizedDescription: String {
        switch self {
        case .withoutAuthorization, .withoutLocationService:
            return "このアプリは、GPS データが必要なんです。「設定」でオンしてくださいね。"
        case .fetchingLocationFailure:
            return "位置情報ゲット失敗しちゃった、「リロード」を押す、もう一度ゲットしてみてくださいね。"
        case .offlineFailure:
            return "やばい、通信出来ない。ちょっとチェックしてみてくださいね。"
        }
    }
}

class NRContainerViewControllerManager: NSObject {
    
    // MARK: - Singleton
    
    static let `default` = NRContainerViewControllerManager()
    
    private override init() {
        super.init()
    }
    
    // MARK: - Basic
    
    let containerViewController = NRContainerViewController()
}

// MARK: - View Controller Presenting Helpers
extension NRContainerViewControllerManager {
    
    func presetPreparingViewController() {
        DispatchQueue.main.async {
            self.containerViewController.loadViewIfNeeded()
            self.containerViewController.currentViewController = NRPreparingViewController()
        }
    }
    
    func presentMessageViewController(with failure: NRFailure) {
        DispatchQueue.main.async {
            self.containerViewController.loadViewIfNeeded()
            let messageViewController = NRMessageViewController()
            messageViewController.message = failure.localizedDescription
            messageViewController.delegate = self
            self.containerViewController.currentViewController = messageViewController
        }
    }
    
    func presentHomeViewControllerIfNeeded() {
        if self.containerViewController.status == .normal {
            return
        }
        
        DispatchQueue.main.async {
            self.containerViewController.loadViewIfNeeded()
            let homeViewContorller = NRHomeViewController()
            self.containerViewController.currentViewController = homeViewContorller
        }
    }
}

extension NRContainerViewControllerManager: NRMessageViewControllerDelegate {
    func didSelectConfirmButton(in messageViewController: NRMessageViewController) {
        self.presetPreparingViewController()
    }
}
