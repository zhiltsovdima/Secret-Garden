//
//  OptionsCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

final class PlantOptionsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: GardenCoordinator?
    
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
        
        let viewModel = PlantOptionsViewModel(output: self, garden, indexPath)
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
        
        navigationController.present(optionsView, animated: true)
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        childCoordinators.removeAll(where: {$0 === childCoordinator})
    }    
}

extension PlantOptionsCoordinator: PlantOptionsOutput {
    
    func showEdit(_ indexPath: IndexPath) {
        let editPlantCoordinator = EditPlantCoordinator(navigationController, garden, indexPath)
        editPlantCoordinator.start()
        editPlantCoordinator.parentCoordinator = self
        childCoordinators.append(editPlantCoordinator)
    }
    
    func deletePlant() {
        navigationController.dismiss(animated: true)
    }
    
    func plantOptionsFinish() {
        parentCoordinator?.childDidFinish(self)
    }

}
