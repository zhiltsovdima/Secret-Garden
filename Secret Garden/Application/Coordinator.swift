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
    private var plantsNavigationController: NavBarController!
    private var shopNavigationController: NavBarController!
    
    init(_ assembly: AssemblyProtocol) {
        self.assembly = assembly
    }
    
    func start(window: UIWindow) {
        let homeView = assembly.createHome()
        let plantsView = assembly.createPlants(output: self)
        let shopView = assembly.createShop()
        
        plantsNavigationController = NavBarController(rootViewController: plantsView)
        shopNavigationController = NavBarController(rootViewController: shopView)
        
        let controllers = [
            homeView,
            plantsNavigationController!,
            shopNavigationController!
        ]
        
        tabViewController = TabBarController(controllers)
        
        window.rootViewController = tabViewController
        window.makeKeyAndVisible()
    }
}

// MARK: - PlantOutput

extension Coordinator: PlantsOutput {
    
    func showAddNewPlant() {
        let addNewPlantView = assembly.createAddNewPlant(output: self)
        plantsNavigationController.pushViewController(addNewPlantView, animated: true)
    }
    
    func showPlantDetail(_ plant: Plant) {
        let detailPlantView = assembly.createDetailPlant(plant)
        plantsNavigationController.pushViewController(detailPlantView, animated: true)
    }
    
    func showOptions() {
        //let options = assembly.createOptions()
        
    }
}

// MARK: - AddPlantOutput

extension Coordinator: AddPlantOutput {
    
    func succesSaving() {
        plantsNavigationController.popViewController(animated: true)
    }
    
}
