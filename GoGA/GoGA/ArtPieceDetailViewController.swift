//
//  ArtPieceDetailViewController.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceDetailViewController: UIViewController, ArtPieceInfoBarViewDelegate {

    var delegate: ArtPieceDetailViewControllerDelegate? = nil

    let artPieceInfoBarView = ArtPieceInfoBarView()
    
    var originFrame: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        modalPresentationStyle = .custom

        artPieceInfoBarView.with { it in
            view.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            it.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            it.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            it.heightAnchor.constraint(equalToConstant: 100).isActive = true
            it.delegate = self
        }        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.bringSubview(toFront: artPieceInfoBarView)
        artPieceInfoBarView.show()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        artPieceInfoBarView.show()
        artPieceInfoBarView.animateDisappearingView()
    }
    
    func artPieceInfoViewDidAppear() {
        artPieceInfoBarView.animateDisappearingView()
    }
    
    func artPieceInfoViewWillAppear() {
        artPieceInfoBarView.show()
        artPieceInfoBarView.animateDisappearingView()
    }
    
    func shouldCloseArtPieceDetailViewController() {
        self.delegate?.artPieceDetailViewController(self, shouldBeDismissed: true)
    }
}

extension ArtPieceDetailViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return UIPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ArtPieceDetailPresentAnimationController(transitionDuration: 0.25, from: originFrame ?? .zero)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ArtPieceDetailDismissAnimationController(transitionDuration: 0.25, to: originFrame ?? .zero)
    }
}

protocol ArtPieceDetailViewControllerDelegate {
    
    func artPieceDetailViewController(_ controller: UIViewController, shouldBeDismissed: Bool)
}
