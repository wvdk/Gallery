//
//  AppDelegate.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/1/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import GalleryCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        Auth.auth().signInAnonymously { (user, error) in
            guard let user = user else { return }
            let userRef = Database.database().reference().child("users/\(user.uid)")
            userRef.child("latestAppLaunch").setValue([".sv": "timestamp"])
            guard let deviceUUID = UIDevice.current.identifierForVendor?.uuidString else { return }
            userRef.child("deviceUUID").setValue(deviceUUID)
        }
        
        let mainViewController = MainViewController()
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        
        #if DEBUG // open directly to the following art piece:
//            let piece = MasterList.shared.activePieces.first!
//            mainViewController.openArtPiece(piece, at: piece.view!)
        #endif
        
        print("Here's a fresh art piece ID, if you happen to want one: \(IDGenerator.generateNewArtPieceID())")
        
        return true
    }

}

