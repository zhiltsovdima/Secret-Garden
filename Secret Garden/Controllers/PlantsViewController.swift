//
//  PlantsViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

class PlantsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Resources.Strings.TabBar.garden
        addNavBarButton()
    }
    
    @objc func navBarRightButtonHandler() {
        print("right button")
    }

}

extension PlantsViewController {
    func addNavBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navBarRightButtonHandler))
        button.tintColor = Resources.Colors.active
        navigationItem.rightBarButtonItem = button
    }
}
