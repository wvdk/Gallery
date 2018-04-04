//
//  ArtPieceInfoView.swift
//  GoGA
//
//  Created by Kristina Gelzinyte on 4/4/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

protocol ArtPieceInfoViewDelegate: AnyObject {
    
    func artPieceInfoViewDidAppear(_ animated: Bool)
}

class ArtPieceInfoView: UIView, ArtPieceInfoViewDelegate {
        
//    convenience init() {
//        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//    }
    
    func artPieceInfoViewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 1.0,
                       delay: 5.0,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: { [weak self] in
                        
//                        guard let subviews = self?.subviews else { return }
//
//                        for view in subviews {
                            self?.alpha = 0.02
//                        }
                        
            },
                    
                       completion: { [weak self] _ in
//                        guard let subviews = self?.subviews else { return }
//
//                        for view in subviews {
                            self?.alpha = 0
//                        }
                       })
    }
}
