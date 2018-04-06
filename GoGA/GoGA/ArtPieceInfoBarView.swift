//
//  ArtPieceInfoBarView.swift
//  GoGA
//
//  Created by Kristina Gelzinyte on 4/4/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

protocol ArtPieceInfoBarViewDelegate: class {

    func artPieceInfoViewWillAppear()
    func artPieceInfoViewDidAppear()
}

class ArtPieceInfoBarView: UIView {
    
    let backButton = UIButton()
    let infoView = UIView()
    var idLabel = UILabel()
    var nameAndDateLabel = UILabel()
    
    weak var delegate: ArtPieceInfoBarViewDelegate?
    
    convenience init() {
        self.init(frame: .zero)
        
        self.backgroundColor = .clear
        
        self.addSingleTapGestureRecognizer { [weak self] _ in
            self?.delegate?.artPieceInfoViewWillAppear()
        }
        
        backButton.with { it in
            self.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            it.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            it.widthAnchor.constraint(equalToConstant: 45).isActive = true
            it.heightAnchor.constraint(equalToConstant: 45).isActive = true
            it.setImage(#imageLiteral(resourceName: "closeButton"), for: UIControlState.normal)
            it.alpha = 0.75
        }
        
        infoView.with { it in
            self.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
            it.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70).isActive = true
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        animateDisappearingView()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard self.frame.contains(point) else { return nil }

        guard self.alpha > 0 else { return self }
        
        return super.hitTest(point, with: event)
    }
    
    func animateDisappearingView() {
        UIView.animate(withDuration: 1.0,
                       delay: 5.0,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.alpha = 0.02
            },
                       completion: { _ in
                        self.alpha = 0
        })
    }
    
    func animateAppearingView() {
        self.alpha = 1
        
        animateDisappearingView()
    }
}
