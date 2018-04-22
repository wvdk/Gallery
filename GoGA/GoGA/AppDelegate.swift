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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let mainViewController = MainViewController()
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        
        #if DEBUG
        
            let piece: Piece = Piece(id: "a565z", author: "Wes <3", date: Date(), image: #imageLiteral(resourceName: "InDevelopment"), viewController: a565zViewController())
            mainViewController.openArtPiece(piece, fromView: a565zViewController().view)
        
        #endif
        
        print("Here's a fresh ID, if you happen to want one: \(IDGenerator().generateNewArtPieceID())")
        
        return true
    }

}

