//
//  ArtPieceInfoBarView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 4/4/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit

protocol ArtPieceInfoBarViewDelegate: class {

    func artPieceInfoBarViewWillAppear()
    
    func artPieceInfoBarViewDidSelectClose(_ view: UIView)
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
            self?.delegate?.artPieceInfoBarViewWillAppear()
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
            it.heightAnchor.constraint(equalToConstant: 30).isActive = true
            it.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            it.backgroundColor = .black
            it.alpha = 0.6
            it.layer.cornerRadius = 8
        }
        
        idLabel.text = "my id"
        idLabel.with { it in
            infoView.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10).isActive = true
            it.centerYAnchor.constraint(equalTo: infoView.centerYAnchor).isActive = true
            it.textColor = .white
            it.font = UIFont(name: "Avenir Next", size: 14)
        }
        
        nameAndDateLabel.text = "my id"
        nameAndDateLabel.with { it in
            infoView.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.leadingAnchor.constraint(greaterThanOrEqualTo: idLabel.trailingAnchor, constant: 30).isActive = true
            it.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10).isActive = true
            it.centerYAnchor.constraint(equalTo: infoView.centerYAnchor).isActive = true
            it.textColor = .white
            it.font = UIFont(name: "Avenir Next", size: 14)
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard self.frame.contains(point) else { return nil }
        
        if self.alpha > 0, backButton.frame.contains(point) {
            self.delegate?.artPieceInfoBarViewDidSelectClose(self)
            return backButton
        }
        
        return self
    }
    
    /// Fades the view's alpha after a specified delay.
    ///
    /// - Parameter delay: A `TimeInterval` indicating how to long to wait before fading out.
    private func fadeOut(after delay: TimeInterval) {
        UIView.animate(withDuration: 0.5, delay: delay, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.alpha = 0.03
        }, completion: { successful in
            if successful {
                self.alpha = 0.0
            }
        })
    }
    
    
    /// Instantly bring the view's alpha to 1.0.
    ///
    /// Will also trigger a fade out after 5 seconds.
    public func show() {
        self.alpha = 1.0
        fadeOut(after: 5.0)
    }
    
}
