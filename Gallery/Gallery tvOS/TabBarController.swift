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
        
        let allArtPieceViewController = AllArtPiecesViewController()
        allArtPieceViewController.tabBarItem = UITabBarItem(title: "ALL", image: nil, tag: 1)
        allArtPieceViewController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)], for: .normal)
     
        let purchasedArtPieceViewController = UIViewController()
        purchasedArtPieceViewController.tabBarItem = UITabBarItem(title: "YOURS", image: nil, tag: 2)
        purchasedArtPieceViewController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)], for: .normal)
        
        let tabBarViewControllerList = [allArtPieceViewController, purchasedArtPieceViewController]
        self.viewControllers = tabBarViewControllerList
    }
    
    // MARK: - UIFocusEnvironment update

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        guard let nextView = context.nextFocusedView, self.tabBar.contains(nextView) else { return }
        
        coordinator.addCoordinatedFocusingAnimations({ (animationContext) in
            nextView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: {
            nextView.transform = CGAffineTransform.identity
        })
    }
}
