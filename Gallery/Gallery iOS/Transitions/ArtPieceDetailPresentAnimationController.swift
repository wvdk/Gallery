////
////  ArtPieceDetailPresentAnimationController.swift
////  Gallery
////
////  Created by Kristina Gelzinyte on 4/23/18.
////  Copyright © 2018 Gallery. All rights reserved.
////
//
//import UIKit
//
//class ArtPieceDetailPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
//    
//    private var transitionDuration: TimeInterval = 0.5
//    private var transitionFrame: CGRect = .zero
//    
//    convenience init(transitionDuration: TimeInterval, transitionFrame: CGRect) {
//        self.init()
//        
//        self.transitionDuration = transitionDuration
//        self.transitionFrame = transitionFrame
//    }
//    
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return transitionDuration
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
//        
//        let containerView = transitionContext.containerView
//        
//        let roundedCornerMaskView = UIView(frame: transitionFrame)
//        roundedCornerMaskView.clipsToBounds = true
//        roundedCornerMaskView.layer.masksToBounds = true
//        roundedCornerMaskView.layer.cornerRadius = 8.0
//        
//        roundedCornerMaskView.addSubview(toViewController.view)
//
//        containerView.addSubview(roundedCornerMaskView)
//        
//        UIView.animate(withDuration: transitionDuration,
//                       delay: 0,
//                       options: [.allowUserInteraction, .curveEaseIn],
//                       animations: {
//                        
//                        roundedCornerMaskView.frame = containerView.bounds
//                        roundedCornerMaskView.layer.cornerRadius = 0
//                        
//        }) { completed in
//            
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
//    }
//}
