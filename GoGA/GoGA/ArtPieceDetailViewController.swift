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
        
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    // MARK: - ArtPieceInfoBarView delegate
    
    func artPieceInfoBarViewWillAppear() {
        artPieceInfoBarView.show()
        artPieceInfoBarView.animateDisappearingView()
    }
    
    func artPieceInfoBarView(_ view: UIView, shouldCloseViewController: Bool) {
        dismiss(animated: true, completion: nil)
    }
}
