//
//  ArtPieceDetailDismissAnimationController.swift
//  GoGA
//
//  Created by Kristina Gelzinyte on 4/23/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceDetailDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    var transitionDuration: TimeInterval = 0.5
    var transitionFrame: CGRect = .zero
    
    convenience init(transitionDuration: TimeInterval, transitionFrame: CGRect) {
        self.init()
        
        self.transitionDuration = transitionDuration
        self.transitionFrame = transitionFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView        
        containerView.bringSubview(toFront: fromViewController.view)
        
        let scaleTransition = CGAffineTransform(scaleX: self.transitionFrame.size.width / containerView.frame.size.width,
                                                y: self.transitionFrame.size.height / containerView.frame.size.height)
        
        let translationTransition = CGAffineTransform(translationX: 0,
                                                      y: (self.transitionFrame.size.height - containerView.frame.size.height) / 2 + self.transitionFrame.origin.y)
        
        fromViewController.view.alpha = 1
        
        UIView.animate(withDuration: self.transitionDuration,
                       delay: 0,
                       options: [.allowUserInteraction, .curveEaseInOut],
                       animations: {
                        
                        fromViewController.view.transform = scaleTransition.concatenating(translationTransition)
                        fromViewController.view.alpha = 0
                        
        }) { completed in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromViewController.view.alpha = 1
        }
    }
}
