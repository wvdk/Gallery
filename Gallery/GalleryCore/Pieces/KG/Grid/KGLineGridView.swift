//
//  KGLineGridView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/2/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGLineGridView: UIView {
    
    // MARK: - Properties

    private let containerView = UIView()
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(r: 0, g: 26, b: 40)
        
        addSubview(containerView)
        containerView.constraint(edgesTo: self, constant: margin * self.frame.height / 1119)
        
        setupLineGrid(rect: self.frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func willMove(toSuperview newSuperview: UIView?) {
//        super.willMove(toSuperview: newSuperview)
//
//        setupLineGrid(rect: self.frame)
//        rotate()
//    }
    
    private let columnNumber: CGFloat = 60.0
    private let rowNumber: CGFloat = 10.0
    private let margin: CGFloat = 150.0
    private let degreeConstant: CGFloat = -0.09
    
    // MARK: - Art piece setup
    
    private func setupLineGrid(rect: CGRect) {
        for index in 0...Int(rowNumber) {
            let origin = CGPoint(x: 0, y: CGFloat(rect.size.height - margin * 2 * rect.size.height / 1119) * CGFloat(index) / CGFloat(rowNumber + 1))
            setupLineRow(rect: CGRect(origin: origin, size: rect.size), angle: (-.pi / 4) - degreeConstant * 60.0 * CGFloat(index))
        }
    }

    private func setupLineRow(rect: CGRect, angle: CGFloat) {
        let row = UIView(frame: CGRect(origin: rect.origin, size: CGSize(width: 1, height: 100 * rect.size.height / 1119)))
        containerView.addSubview(row)

        row.transform = CGAffineTransform(rotationAngle: angle)
        row.backgroundColor = UIColor(r: 151, g: 151, b: 151, alpha: 1)
        row.alpha = 0.5
        
        row.loopInSuperview(duplicationCount: Int(columnNumber), with: [
            .rotateByDegrees(degreeConstant),
            .moveHorizontallyWithIncrement((rect.size.width - margin * 2 * rect.size.height / 1119) / columnNumber),
            ]
        )
    }
    
//    private func rotate() {
//        for subview in containerView.subviews {
//            subview.rotate(duration: 10.0)
//        }
//    }
}
