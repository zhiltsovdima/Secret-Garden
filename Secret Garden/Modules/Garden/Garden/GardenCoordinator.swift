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
    func showOptions(_ cell: PlantCell, id: String)
}

final class GardenCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController
    
    private let networkManager: NetworkManagerProtocol
    private let plantsDataManager = PlantsDataManager()
    lazy private var garden = Garden(networkManager: networkManager, plantsDataManager: plantsDataManager)
    
    init(_ navigationController: UINavigationController, _ networkManager: NetworkManagerProtocol) {
        self.navigationController = navigationController
        self.networkManager = networkManager
    }
    
    func start() {
        let viewModel = GardenViewModel(coordinator: self, garden: garden)
        let plantViewController = GardenViewController(viewModel: viewModel)
        navigationController.setViewControllers([plantViewController], animated: false)
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
    
    func showOptions(_ cell: PlantCell, id: String) {
        let optionsCoordinator = PlantOptionsCoordinator(navigationController, garden, cell: cell, id: id)
        optionsCoordinator.start()
        optionsCoordinator.parentCoordinator = self
        childCoordinators.append(optionsCoordinator)
    }
    
}
