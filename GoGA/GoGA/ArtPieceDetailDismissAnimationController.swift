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
    var frame: CGRect = .zero
    
    convenience init(transitionDuration: TimeInterval, to frame: CGRect) {
        self.init()
        
        self.transitionDuration = transitionDuration
        self.frame = frame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to), let fromView = transitionContext.view(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, belowSubview: fromView)
        
        let scaleTransition = CGAffineTransform(scaleX: self.frame.size.width / containerView.frame.size.width,
                                                y: self.frame.size.height / containerView.frame.size.height)
        let translationTransition = CGAffineTransform(translationX: 0,
                                                      y: containerView.frame.size.height / 2)
                
        UIView.animate(withDuration: self.transitionDuration, animations: { () -> Void in
            fromView.transform = translationTransition.concatenating(scaleTransition)
            
        }) { (completed: Bool) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
