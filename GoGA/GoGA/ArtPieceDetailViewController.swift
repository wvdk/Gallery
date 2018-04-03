//
//  ArtPieceDetailViewController.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceDetailViewController: UIViewController {
    
    let backButton = UIButton()
    let infoView = UIView()
    var idLabel = UILabel()
    var nameAndDateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        backButton.with { it in
            view.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            it.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            it.widthAnchor.constraint(equalToConstant: 45).isActive = true
            it.heightAnchor.constraint(equalToConstant: 45).isActive = true
            it.setImage(#imageLiteral(resourceName: "closeButton"), for: UIControlState.normal)
            it.alpha = 0.75
            it.addTarget(self, action: #selector(close), for: .touchUpInside)
        }
        
        infoView.with { it in
            view.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
            it.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70).isActive = true
            it.widthAnchor.constraint(equalToConstant: 360).isActive = true
            it.heightAnchor.constraint(equalToConstant: 30).isActive = true
            it.backgroundColor = .black
            it.alpha = 0.7
            it.layer.cornerRadius = 8
        }
        
        idLabel.text = "my id"
        idLabel.with { it in
            infoView.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10).isActive = true
            it.centerYAnchor.constraint(equalTo: infoView.centerYAnchor).isActive = true
            it.textColor = .white
        }
        
        nameAndDateLabel.text = "my id"
        nameAndDateLabel.with { it in
            infoView.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10).isActive = true
            it.centerYAnchor.constraint(equalTo: infoView.centerYAnchor).isActive = true
            it.textColor = .white
        }
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.bringSubview(toFront: backButton)
        view.bringSubview(toFront: infoView)
        
        UIView.animate(withDuration: 1.0,
                       delay: 5.0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: { [weak self] in
                        self?.backButton.alpha = 0
                        self?.infoView.alpha = 0 },
                       
                       completion: { finished in
                        print("done")
        })
    }
}
