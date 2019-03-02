//
//  PieceDisplayViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// The object that acts as the delegate of the art piece view display controller.
///
/// The delegate must adopt the PieceDisplayViewControllerDelegate protocol.
///
/// The delegate object is responsible for managing view controller appearance.
protocol PieceDisplayViewControllerDelegate: class {
    
    /// Tells the delegate that an art piece view controller was selected to be closed.
    ///
    /// - Parameters:
    ///     - viewController: An object informing the delegate about the closing.
    func pieceDisplayViewControllerDidSelectClose(_ viewController: PieceDisplayViewController)
}

/// A subclass of `UIViewController`, which displays single art piece view `UIView` in full screen mode.
class PieceDisplayViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: PieceDisplayViewControllerDelegate?
    
    private var pieceMetadata: PieceMetadata
    
    // MARK: - Initalization
    
    /// Initializes and returns a newly allocated view object with the specified `artMetadata` art piece view.
    ///
    /// - Parameters:
    ///     - artMetadata: Metadata of the art piece which will to be presented.
    ///
    /// - Returns: `UIViewController` with child view of art piece.
    init(artMetadata: PieceMetadata) {
        self.pieceMetadata = artMetadata
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .black
        view.alpha = 0.9
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let artView = pieceMetadata.viewType.init(frame: view.bounds)
        view.addSubview(artView)
        artView.constraint(edgesTo: view)
        
        let menuTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeAction(_:)))
        menuTapGestureRecognizer.allowedPressTypes = [NSNumber(value: Int8(UIPress.PressType.menu.rawValue))]
        view.addGestureRecognizer(menuTapGestureRecognizer)
    }
    
    // MARK: - Actions

    @objc private func closeAction(_ sender: UIButton) {
        delegate?.pieceDisplayViewControllerDidSelectClose(self)
    }
}
