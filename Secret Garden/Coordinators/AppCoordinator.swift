//
//  AppCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
    func childDidFinish(_ childCoordinator: Coordinator)
}

extension Coordinator {
    func childDidFinish(_ childCoordinator: Coordinator) {
        childCoordinators.removeAll(where: {$0 === childCoordinator})
    }
}

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarController = UITabBarController()
        let tabCoordinator = TabCoordinator(tabBarController)
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
