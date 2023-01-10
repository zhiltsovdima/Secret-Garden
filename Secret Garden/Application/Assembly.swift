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
    
    func createAddNewPlant(output: AddPlantOutput) -> UIViewController
    func createDetailPlant(_ plant: Plant) -> UIViewController
    func createOptions() -> UITableViewController 

}

class Assembly: AssemblyProtocol {
    
    var garden = Garden()
    
    func createHome() -> UIViewController {
        return HomeViewController()
    }
    
    func createPlants(output: PlantsOutput) -> UIViewController {
        let viewModel = PlantsViewModel(output: output, garden: garden)
        let view = PlantsViewController1(viewModel: viewModel)
        viewModel.view = view
        return view
    }
    
    func createShop() -> UIViewController {
        return ShopViewController()
    }
    
    func createAddNewPlant(output: AddPlantOutput) -> UIViewController {
        let viewModel = AddPlantViewModel(output: output, garden: garden)
        let addNewPlantView = AddPlantController(viewModel: viewModel)
        return addNewPlantView
    }
    
    func createDetailPlant(_ plant: Plant) -> UIViewController {
        let detailPlantView = DetailPlantController()
        detailPlantView.setPlant(plant)
        return detailPlantView
    }
    
    func createOptions() -> UITableViewController {
        let optionsView = OptionsPlantTableViewController()
        return optionsView
        
    }
}
