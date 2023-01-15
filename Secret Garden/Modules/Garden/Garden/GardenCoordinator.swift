//
//  GardenCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

final class GardenCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController
    
    private let garden = Garden()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = GardenViewModel(output: self, garden: garden)
        let plantViewController = GardenViewController(viewModel: viewModel)
        navigationController.setViewControllers([plantViewController], animated: false)
    }
    
    func getController() -> UINavigationController {
        return navigationController
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        childCoordinators.removeAll(where: {$0 === childCoordinator})
    }
}

extension GardenCoordinator: GardenOutput {
    
    func showAddNewPlant() {
        let addNewPlantCoordinator = AddNewPlantCoordinator(navigationController, garden)
        addNewPlantCoordinator.start()
        addNewPlantCoordinator.parentCoordinator = self
        childCoordinators.append(addNewPlantCoordinator)
    }
    
    func showPlantDetail(_ index: Int) {
        let detailPlantCoordinator = DetailPlantCoordinator(navigationController, garden, index: index)
        detailPlantCoordinator.start()
        detailPlantCoordinator.parentCoordinator = self
        childCoordinators.append(detailPlantCoordinator)
    }
    
    func showOptions(_ cell: PlantCell) {
        let optionsCoordinator = PlantOptionsCoordinator(navigationController, garden, cell: cell)
        optionsCoordinator.start()
        optionsCoordinator.parentCoordinator = self
        childCoordinators.append(optionsCoordinator)
    }
    
    
}
