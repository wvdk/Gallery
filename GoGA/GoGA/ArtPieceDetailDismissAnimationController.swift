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
        
        let roundedCornerMaskView = UIView(frame: containerView.bounds)
        roundedCornerMaskView.clipsToBounds = true
        roundedCornerMaskView.layer.masksToBounds = true
        roundedCornerMaskView.layer.cornerRadius = 0
        
        roundedCornerMaskView.addSubview(fromViewController.view)

        containerView.addSubview(roundedCornerMaskView)
        
        UIView.animate(withDuration: self.transitionDuration,
                       delay: 0,
                       options: [.allowUserInteraction, .curveEaseInOut],
                       animations: { [weak self] in
                        
                        roundedCornerMaskView.frame = self?.transitionFrame ?? .zero
                        roundedCornerMaskView.layer.cornerRadius = 8
                        
        }) { completed in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
