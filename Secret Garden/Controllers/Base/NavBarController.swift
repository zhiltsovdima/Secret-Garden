//
//  NavBarController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 30.10.2022.
//

import UIKit

final class NavBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.backgroundColor
        view.tintColor = Resources.Colors.accent
        navigationBar.isTranslucent = false
    }
}
