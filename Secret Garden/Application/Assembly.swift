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
    func createDetailPlant(output: DetailPlantOutput, _ index: Int) -> UIViewController
    func createOptions(output: PlantOptionsOutput, _ vc: UIViewController?, _ cell: PlantCell) -> UIViewController
    
    func createEditPlantVC(output: EditPlantOutput, _ indexPath: IndexPath) -> UIViewController

}

class Assembly: AssemblyProtocol {
    
    var garden = Garden()
    
    func createHome() -> UIViewController {
        return HomeViewController()
    }
    
    func createPlants(output: PlantsOutput) -> UIViewController {
        let viewModel = PlantsViewModel(output: output, garden: garden)
        let view = PlantsViewController(viewModel: viewModel)
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
    
    func createDetailPlant(output: DetailPlantOutput, _ index: Int) -> UIViewController {
        let viewModel = DetailPlantViewModel(output: output, garden, index)
        let detailPlantView = DetailPlantController(viewModel: viewModel)
        return detailPlantView
    }
    
    func createOptions(output: PlantOptionsOutput, _ vc: UIViewController?, _ cell: PlantCell) -> UIViewController {
        let vc = vc as! PlantsViewController
        let indexPath = vc.tableView.indexPath(for: cell)
        
        let viewModel = PlantOptionsViewModel(output: output, garden, indexPath!)
        let optionsView = PlantOptionsTableViewController(viewModel: viewModel)
        
        optionsView.modalPresentationStyle = .popover
        let popoverVC = optionsView.popoverPresentationController
        popoverVC?.delegate = vc
        popoverVC?.sourceView = cell.settingsButton
        popoverVC?.sourceRect = CGRect(x: cell.settingsButton.bounds.minX - 70,
                                       y: cell.settingsButton.bounds.midY + 7,
                                       width: 0,
                                       height: 0
        )
        popoverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        
        optionsView.preferredContentSize.width = vc.view.bounds.width / 3.0
        
        return optionsView
    }
    
    func createEditPlantVC(output: EditPlantOutput, _ indexPath: IndexPath) -> UIViewController {
        let viewModel = EditPlantViewModel(output: output, garden, indexPath)
        let editVC = EditPlantViewController(viewModel: viewModel)
        return editVC
    }
}
