//
//  AppDelegate.swift
//  near
//
//  Created by vincent on 2017/02/03.
//  Copyright © 2017年 vc7. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let homeViewController = NRPreparingViewController()
        self.window?.rootViewController = homeViewController
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

