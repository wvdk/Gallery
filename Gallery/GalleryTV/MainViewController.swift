//
//  MainViewController.swift
//  GalleryTV
//
//  Created by Kristina Gelzinyte on 6/30/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.back))
        menuTapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.menu.rawValue)];
        view.addGestureRecognizer(menuTapRecognizer)
    }
    
    @objc func back() {
        exit(EXIT_SUCCESS)
    }
}

