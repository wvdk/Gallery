//
//  ArtPieceDetailPresentAnimationController.swift
//  GoGA
//
//  Created by Kristina Gelzinyte on 4/23/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceDetailPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
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
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        let roundedCornerMaskView = UIView(frame: self.transitionFrame)
        roundedCornerMaskView.clipsToBounds = true
        roundedCornerMaskView.layer.masksToBounds = true
        roundedCornerMaskView.layer.cornerRadius = 8.0
        
        roundedCornerMaskView.addSubview(toViewController.view)

        containerView.addSubview(roundedCornerMaskView)
        
        UIView.animate(withDuration: self.transitionDuration,
                       delay: 0,
                       options: [.allowUserInteraction, .curveEaseIn],
                       animations: {
                        
                        roundedCornerMaskView.frame = containerView.bounds
                        roundedCornerMaskView.layer.cornerRadius = 0
                        
        }) { completed in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
