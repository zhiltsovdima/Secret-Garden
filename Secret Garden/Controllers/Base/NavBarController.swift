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
        
        navigationBar.prefersLargeTitles = true
        configureAppearance()
    }
    
    private func configureAppearance() {
        view.tintColor = Resources.Colors.accent
        navigationBar.isTranslucent = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Resources.Images.Common.back,
                                                           style: .done,
                                                           target: self,
                                                           action: nil)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Resources.Images.Common.back,
                                                                               style: .done,
                                                                               target: self,
                                                                              action: #selector(backToVC))
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func backToVC() {
        self.popViewController(animated: true)
    }
}
