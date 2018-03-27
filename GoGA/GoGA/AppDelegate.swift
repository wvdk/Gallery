//
//  AppDelegate.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    /// Set this value to whatever you want to open to automatically (only works for debug builds of course).
    var openTo: ArtPieceDetailViewController? = a565zViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let mainViewController = MainViewController()
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        
        #if DEBUG
            if let openTo = openTo {
                mainViewController.openArtPiece(viewController: openTo)
            }
        #endif
        
        print("Here's a fresh ID, if you happen to want one: \(IDGenerator().generateNewArtPieceID())")
        
        return true
    }

}

