//
//  ArtPieceDetailPresentationController.swift
//  GoGA
//
//  Created by Kristina Gelzinyte on 4/30/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceDetailPresentationController: UIPresentationController {
    
    var originFrame: CGRect?
    var presentationWrappingView = UIViewController()

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
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
        return ArtPieceDetailPresentAnimationController(transitionDuration: 0.25, transitionFrame: originFrame ?? .zero)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ArtPieceDetailDismissAnimationController(transitionDuration: 0.25, transitionFrame: originFrame ?? .zero)
    }
}
