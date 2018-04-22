//
//  ArtPieceDetailViewController.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceDetailViewController: UIViewController, ArtPieceInfoBarViewDelegate {

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
        }
        
        artPieceInfoBarView.delegate = self
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
        dismiss(animated: true, completion: nil)
    }
}

extension ArtPieceDetailViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

//        return ArtPieceDetailPresentAnimationController(withDuration: 2.5, originFrame: self.view.frame)

        let defaultFrame = CGRect(x: 100, y: 100, width: 500, height: 100)
        return ArtPieceDetailPresentAnimationController(withDuration: 15, originFrame: originFrame ?? defaultFrame)

    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        //should be destination frame
        return ArtPieceDetailDismissAnimationController(withDuration: 0.5, originFrame: self.view.frame)
    }
}
