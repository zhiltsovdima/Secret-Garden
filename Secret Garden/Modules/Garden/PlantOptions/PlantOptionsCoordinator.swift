//
//  OptionsCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

protocol PlantOptionsCoordinatorProtocol: AnyObject {
    func showEdit(_ indexPath: IndexPath)
    func succesDeleting()
    func plantOptionsFinish()
}

final class PlantOptionsCoordinator: NSObject, Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    private let navigationController: UINavigationController
    private let garden: Garden
    private let cell: PlantCell
        
    init(_ navigationController: UINavigationController, _ garden: Garden, cell: PlantCell) {
        self.navigationController = navigationController
        self.garden = garden
        self.cell = cell
    }
    
    func start() {
        guard let vc = navigationController.topViewController as? GardenViewController else { return }
        guard let indexPath = vc.tableView.indexPath(for: cell) else { return }
        
        let viewModel = PlantOptionsViewModel(coordinator: self, garden, indexPath)
        let optionsView = PlantOptionsTableViewController(viewModel: viewModel)
        
        optionsView.modalPresentationStyle = .popover
        let popoverVC = optionsView.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = cell.settingsButton
        popoverVC?.sourceRect = CGRect(x: cell.settingsButton.bounds.minX - 70,
                                       y: cell.settingsButton.bounds.midY + 7,
                                       width: 0,
                                       height: 0
        )
        popoverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        
        optionsView.preferredContentSize.width = vc.view.bounds.width / 3.0
        
        navigationController.present(optionsView, animated: true)
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        childCoordinators.removeAll(where: {$0 === childCoordinator})
    }    
}

// MARK: - PlantOptionsCoordinatorProtocol

extension PlantOptionsCoordinator: PlantOptionsCoordinatorProtocol {
    
    func showEdit(_ indexPath: IndexPath) {
        let editPlantCoordinator = EditPlantCoordinator(navigationController, garden, indexPath)
        editPlantCoordinator.start()
        editPlantCoordinator.parentCoordinator = self
        childCoordinators.append(editPlantCoordinator)
    }
    
    func succesDeleting() {
        navigationController.dismiss(animated: true)
    }
    
    func plantOptionsFinish() {
        parentCoordinator?.childDidFinish(self)
    }

}

// MARK: - UIPopoverPresentationControllerDelegate

extension PlantOptionsCoordinator: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
