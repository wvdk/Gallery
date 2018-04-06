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
        }
        
        artPieceInfoBarView.delegate = self
        
        artPieceInfoBarView.backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.bringSubview(toFront: artPieceInfoBarView)
    }
    
    func artPieceInfoViewDidAppear() {
        
        artPieceInfoBarView.animateDisappearingView()
    }
    
    func artPieceInfoViewWillAppear() {
        
        artPieceInfoBarView.animateAppearingView()
    }
}
