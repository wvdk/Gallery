//
//  AppDelegate.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/1/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit
import GalleryCore_iOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainViewController = MainViewController()
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

