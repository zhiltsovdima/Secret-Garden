//
//  Coordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.01.2023.
//

import UIKit

protocol CoordinatorProtocol {
    func start(window: UIWindow)
}

class Coordinator: CoordinatorProtocol {
    
    private let assembly: AssemblyProtocol
    
    private var tabViewController: TabBarController!
    
    init(_ assembly: AssemblyProtocol) {
        self.assembly = assembly
    }
    
    func start(window: UIWindow) {
        let homeView = assembly.createHome()
        let plantsView = assembly.createPlants()
        let shopView = assembly.createShop()
        
        let controllers = [
            homeView,
            NavBarController(rootViewController: plantsView),
            NavBarController(rootViewController: shopView)
        ]
        
        tabViewController = TabBarController(controllers)
        
        window.rootViewController = tabViewController
        window.makeKeyAndVisible()
    }
}
