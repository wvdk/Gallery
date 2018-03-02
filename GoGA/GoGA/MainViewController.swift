//
//  MainViewController.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.with { it in
            view.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            it.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            it.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            it.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }

}

public protocol WithProtocol {}

extension NSObject: WithProtocol {}

extension WithProtocol where Self: NSObject {
    
    public func with(closure: (Self) -> Void) {
        closure(self)
    }
    
}


