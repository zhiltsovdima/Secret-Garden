//
//  BaseViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 30.10.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        view.backgroundColor = Resources.Colors.backgroundColor
        navigationController?.navigationBar.backgroundColor = Resources.Colors.backgroundColor
    }
}
