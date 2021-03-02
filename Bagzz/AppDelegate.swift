//
//  AppDelegate.swift
//  Bagzz
//
//  Created by tasya on 01.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let homeVC: ViewController = ViewController()
        let vc1 = ViewController()
        let vc2 = ViewController()
        let vc3 = ViewController()
        
        let tabBarController = TabBarController()
        tabBarController.viewControllers = [homeVC, vc1, vc2, vc3]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
       
        return true
    }

}

