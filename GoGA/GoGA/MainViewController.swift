//
//  MainViewController.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import ArtKit

class MainViewController: UIViewController {

    fileprivate enum Constants {
        static let tableViewCellHight: CGFloat = 150.0 / 768.0
    }
    
    let tableView = UITableView()
    
    fileprivate var originFrame: CGRect?
    
    private let idGenerator = IDGenerator()
    private var idList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 239, g: 239, b: 239)
        
        view.addSubview(headerView)
        
        tableView.with { it in
            view.addSubview(it)
            it.delegate = self
            it.dataSource = self
            it.allowsSelection = false
            it.backgroundColor = .clear
            it.register(ArtPieceTableViewCell.self, forCellReuseIdentifier: ArtPieceTableViewCell.identifier)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            it.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            it.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            it.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            it.separatorStyle = UITableViewCellSeparatorStyle.none
            it.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 86))
        }
    }
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 116)
        
        let imageView = UIImageView(image: UIImage(named: "logo")!)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        
        return view
    }()

    fileprivate func generateUniqueID() -> String {
        let id = idGenerator.generate(digits: 3, letters: 1)
        guard idList.contains(id) else {
            idList.append(id)
            return id
        }
        return generateUniqueID()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MasterList.pieces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArtPieceTableViewCell.identifier) as! ArtPieceTableViewCell
        
        cell.piece = MasterList.pieces[indexPath.row]
        cell.delegate = self
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension MainViewController: ArtPieceTableViewCellDelegate, UIViewControllerTransitioningDelegate {
    
    func openArtPiece(_ artPiece: Piece, at view: UIView) {
        originFrame = self.view.convert(view.bounds, from: view)
        
        artPiece.viewController.artPieceInfoBarView.idLabel.text = artPiece.id
        artPiece.viewController.artPieceInfoBarView.nameAndDateLabel.text = "\(artPiece.author) \(artPiece.prettyDate)"
        
        artPiece.viewController.modalPresentationStyle = .custom
        artPiece.viewController.transitioningDelegate = self
        
        present(artPiece.viewController, animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ArtPieceDetailPresentAnimationController(transitionDuration: 0.25, transitionFrame: originFrame ?? .zero)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ArtPieceDetailDismissAnimationController(transitionDuration: 0.25, transitionFrame: originFrame ?? .zero)
    }
}
