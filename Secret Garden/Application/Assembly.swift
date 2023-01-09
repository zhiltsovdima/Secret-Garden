//
//  Assembly.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.01.2023.
//

import UIKit

protocol AssemblyProtocol {
    func createHome() -> UIViewController
    func createPlants(output: PlantsOutput) -> UIViewController
    func createShop() -> UIViewController
    
    func createAddNewPlant() -> UIViewController
    func createDetailPlant(_ plant: Plant) -> UIViewController

}

class Assembly: AssemblyProtocol {
    
    var garden = Garden()
    
    func createHome() -> UIViewController {
        return HomeViewController()
    }
    
    func createPlants(output: PlantsOutput) -> UIViewController {
        let viewModel = PlantsViewModel(output: output, garden: garden)
        let view = PlantsViewController1(viewModel: viewModel)
        return view
    }
    
    func createShop() -> UIViewController {
        return ShopViewController()
    }
    
    func createAddNewPlant() -> UIViewController {
        let addNewPlantView = AddPlantController()
        return addNewPlantView
    }
    
    func createDetailPlant(_ plant: Plant) -> UIViewController {
        let detailPlantView = DetailPlantController()
        detailPlantView.setPlant(plant)
        return detailPlantView
    }
}
