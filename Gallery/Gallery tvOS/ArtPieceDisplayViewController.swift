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
    
    private let artContainerView = UIView()

    private var artPieceMetadata: PieceMetadata
    private var timeLabel: UILabel?
    
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
        
        view.backgroundColor = .black
        view.alpha = 0.9
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let artView = artPieceMetadata.viewType.init(frame: view.bounds)
        
        view.addSubview(artContainerView)
        artContainerView.constraint(edgesTo: view)
        
        artContainerView.addSubview(artView)
        artView.constraint(edgesTo: artContainerView)
        
        let menuTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeAction(_:)))
        menuTapGestureRecognizer.allowedPressTypes = [NSNumber(value: Int8(UIPress.PressType.menu.rawValue))]
        view.addGestureRecognizer(menuTapGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showTimeLabel(_:)))
        tapGestureRecognizer.allowedPressTypes = [NSNumber(value: Int8(UIPress.PressType.select.rawValue))]
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Actions

    @objc private func closeAction(_ sender: UIButton) {
        delegate?.artPieceDisplayViewControllerDidSelectClose(self)
    }
    
    @objc private func showTimeLabel(_ gestureRecognizer: UITapGestureRecognizer) {
        if timeLabel == nil {
            showClock()
        } else {
            hideClock()
        }
        
        updateTime()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    // MARK: - Clock setup
    
    private func setupTimeLabel() {
        timeLabel = UILabel()

        guard let timeLabel = self.timeLabel else { return }
        
        let fontSize = 250 * view.frame.height / 1119
        timeLabel.font = UIFont(name: "Menlo", size: fontSize)
        timeLabel.textColor = .white
        timeLabel.alpha = 0
        
        view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Clock appearance
    
    private func showClock() {
        setupTimeLabel()

        guard let timeLabel = self.timeLabel else { return }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            timeLabel.alpha = 0.4
            self?.artContainerView.alpha = 0.4
        }
    }
    
    private func hideClock() {
        guard let timeLabel = self.timeLabel else { return }

        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            timeLabel.alpha = 0
            self?.artContainerView.alpha = 1
        }, completion: {[weak self]  _ in
            timeLabel.removeFromSuperview()
            self?.timeLabel = nil
        })
    }
    
    @objc private func updateTime() {
        guard let timeLabel = self.timeLabel else { return }

        let formatter = DateFormatter()
        formatter.dateFormat = "HH mm ss"
        timeLabel.text = formatter.string(from: Date())
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
