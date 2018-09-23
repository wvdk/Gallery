//
//  ArtPieceDisplayViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// A subclass of `UIViewController`, which displays single art piece view `UIView` in full screen mode.
class ArtPieceDisplayViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: ArtPieceDisplayViewControllerDelegate?
    
    private var artPieceMetadata: PieceMetadata

    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let artView = artPieceMetadata.viewType.init(frame: view.bounds)
        
        view.addSubview(artView)
        artView.constraint(edgesTo: view)
        
        let menuTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeAction(_:)))
        menuTapGestureRecognizer.allowedPressTypes = [NSNumber(value: Int8(UIPress.PressType.menu.rawValue))]
        view.addGestureRecognizer(menuTapGestureRecognizer)
    }
    
    // MARK: - Initalization
    
    /// Initializes and returns a newly allocated view object with the specified `artMetadata` art piece view.
    ///
    /// - Parameters:
    ///     - artMetadata: Metadata of the art piece which will to be presented.
    ///
    /// - Returns: `UIViewController` with child view of art piece.
    init(artMetadata: PieceMetadata) {
        self.artPieceMetadata = artMetadata
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions

    @objc private func closeAction(_ sender: UIButton) {
        delegate?.artPieceDisplayViewControllerDidSelectClose(self)
    }
}

/// The object that acts as the delegate of the art piece view display controller.
///
/// The delegate must adopt the ArtPieceDisplayViewControllerDelegate protocol.
///
/// The delegate object is responsible for managing view controller appearance.
protocol ArtPieceDisplayViewControllerDelegate: class {
    
    /// Tells the delegate that an art piece view controller was selected to be closed.
    ///
    /// - Parameters:
    ///     - viewController: An object informing the delegate about the closing.
    func artPieceDisplayViewControllerDidSelectClose(_ viewController: ArtPieceDisplayViewController)
}
