//
//  GardenCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

protocol GardenCoordinatorProtocol: AnyObject {
    func showAddNewPlant()
    func showPlantDetail(_ plant: Plant)
    func showOptions(_ cell: PlantCell)
}

final class GardenCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController
    
    lazy private var garden = Garden(networkManager: networkManager)
    private let networkManager = NetworkManager()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = GardenViewModel(coordinator: self, garden: garden)
        let plantViewController = GardenViewController(viewModel: viewModel)
        navigationController.setViewControllers([plantViewController], animated: false)
    }
    
    func getController() -> UINavigationController {
        return navigationController
    }

}

// MARK: - GardenCoordinatorProtocol

extension GardenCoordinator: GardenCoordinatorProtocol {
    
    func showAddNewPlant() {
        let addNewPlantCoordinator = AddNewPlantCoordinator(navigationController, garden)
        addNewPlantCoordinator.start()
        addNewPlantCoordinator.parentCoordinator = self
        childCoordinators.append(addNewPlantCoordinator)
    }
    
    func showPlantDetail(_ plant: Plant) {
        let detailPlantCoordinator = DetailPlantCoordinator(navigationController, garden, plant: plant)
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
