//
//  TabBarController.swift
//  GalleryTV
//
//  Created by Kristina Gelzinyte on 6/30/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import GalleryCore_tvOS

class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let membershipViewController = UIViewController()
        membershipViewController.view.backgroundColor = .blue
        membershipViewController.tabBarItem = UITabBarItem(title: "Membership", image: nil, tag: 0)
        membershipViewController.tabBarItem.titlePositionAdjustment.horizontal = -100
        
        let allArtPieceViewController = AllArtPieceViewController()
        allArtPieceViewController.tabBarItem = UITabBarItem(title: "ALL", image: nil, tag: 1)
        
        let purchasedArtPieceViewController = UIViewController()
        purchasedArtPieceViewController.view.backgroundColor = .red
        purchasedArtPieceViewController.tabBarItem = UITabBarItem(title: "YOURS", image: nil, tag: 2)
        
        let artPiecePresentatioViewController = UIViewController()
        artPiecePresentatioViewController.view.backgroundColor = .black
        artPiecePresentatioViewController.tabBarItem = UITabBarItem(title: "Shuffle", image: nil, tag: 3)
        
        let tabBarViewControllerList = [membershipViewController, allArtPieceViewController, purchasedArtPieceViewController, artPiecePresentatioViewController]
        self.viewControllers = tabBarViewControllerList
        
        self.selectedIndex = 1
    }
}
