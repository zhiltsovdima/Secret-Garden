//
//  SceneDelegate.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 28.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let assembly = Assembly()
    lazy private var coordinator = Coordinator(assembly)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        coordinator.start(window: window)
        self.window = window
    }

}

