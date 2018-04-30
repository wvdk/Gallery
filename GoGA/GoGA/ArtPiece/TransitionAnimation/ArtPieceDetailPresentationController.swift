//
//  ArtPieceDetailPresentationController.swift
//  GoGA
//
//  Created by Kristina Gelzinyte on 4/30/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceDetailPresentationController: UIPresentationController {
    
    private var originFrame: CGRect?
    private var presentationWrappingView = UIViewController()

    convenience init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, originFrame: CGRect) {
        self.init(presentedViewController: presentedViewController,
                  presenting: presentingViewController)
        
        self.originFrame = originFrame
        
        if self.presentedViewController != presentedViewController {
             print("You didn't initialize \(self) with the correct presentedViewController.  Expected \(presentedViewController), got \(self.presentedViewController).")
        }
       
        presentedViewController.modalPresentationStyle = .custom
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
}

extension ArtPieceDetailPresentationController: UIViewControllerTransitioningDelegate {
    
    //MARK: - UIViewControllerTransitioning delegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ArtPieceDetailPresentAnimationController(transitionDuration: 0.5, transitionFrame: originFrame ?? .zero)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ArtPieceDetailDismissAnimationController(transitionDuration: 0.5, transitionFrame: originFrame ?? .zero)
    }
}
