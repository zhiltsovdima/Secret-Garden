//
//  Coordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.01.2023.
//

import UIKit

protocol CoordinatorProtocol {
    func start(window: UIWindow)
    
    func showAddNewPlant()
    func showPlantDetail(_ index: Int)
    func showOptions(_ cell: PlantCell)
    
    func succesAdding()
    
    func showEdit(_ indexPath: IndexPath)
    func deletePlant()
    
    func succesEditing()
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
    
    func showPlantDetail(_ index: Int) {
        let detailPlantView = assembly.createDetailPlant(output: self, index)
        plantsNavigationController.pushViewController(detailPlantView, animated: true)
    }
    
    func showOptions(_ cell: PlantCell) {
        let optionsView = assembly.createOptions(output: self,
                                                 plantsNavigationController.topViewController,
                                                 cell)
        plantsNavigationController.present(optionsView, animated: true)

    }
}

// MARK: - AddPlantOutput

extension Coordinator: AddPlantOutput {
    
    func succesAdding() {
        plantsNavigationController.popViewController(animated: true)
    }
}

// MARK: - PlantOptionsOutput

extension Coordinator: PlantOptionsOutput {
    
    func showEdit(_ indexPath: IndexPath) {
        let editView = assembly.createEditPlantVC(output: self, indexPath)
        plantsNavigationController.dismiss(animated: true)
        plantsNavigationController.present(editView, animated: true)
        
    }
    
    func deletePlant() {
        plantsNavigationController.dismiss(animated: true)
    }
}

// MARK: - EditPlantOutput

extension Coordinator: EditPlantOutput {
    
    func succesEditing() {
        plantsNavigationController.dismiss(animated: true)
    }
}

// MARK: - DetailPlantOutput

extension Coordinator: DetailPlantOutput {
    
}
