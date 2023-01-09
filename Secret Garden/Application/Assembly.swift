//
//  Assembly.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.01.2023.
//

import UIKit

protocol AssemblyProtocol {
    func createHome() -> UIViewController
    func createPlants() -> UIViewController
    func createShop() -> UIViewController
}

class Assembly: AssemblyProtocol {
    
    func createHome() -> UIViewController {
        return HomeViewController()
    }
    
    func createPlants() -> UIViewController {
        return PlantsViewController()
    }
    
    func createShop() -> UIViewController {
        return ShopViewController()
    }
}
