//
//  EditPlantCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

protocol EditPlantCoordinatorProtocol: AnyObject {
    func successEditing()
    func editPlantFinish()
    func showAddNewPhotoAlert(completion: @escaping (UIImage) -> Void)
}

final class EditPlantCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    private var completion: ((UIImage) -> Void)?
    
    private let navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    private let garden: Garden
    private let index: Int
        
    init(_ navigationController: UINavigationController, _ garden: Garden, index: Int) {
        self.navigationController = navigationController
        self.garden = garden
        self.index = index
    }
    
    func start() {
        navigationController.dismiss(animated: true)
        modalNavigationController = UINavigationController()
        
        let viewModel = EditPlantViewModel(coordinator: self, garden, index: index)
        let editView = EditPlantViewController(viewModel: viewModel)
        modalNavigationController?.setViewControllers([editView], animated: false)
        guard let modalNavigationController else { return }
        navigationController.present(modalNavigationController, animated: true)
    }
}

// MARK: - ImagePickableProtocol

extension EditPlantCoordinator: ImagePickable {
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard let modalNavigationController else { return }
        let imagePickerCoordinator = ImagePickerCoordinator(modalNavigationController, sourceType: sourceType)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.start()
        childCoordinators.append(imagePickerCoordinator)
    }

    func didFinishPicking(_ image: UIImage) {
        completion?(image)
    }
}

// MARK: - EditPlantCoordinatorProtocol

extension EditPlantCoordinator: EditPlantCoordinatorProtocol {
    
    func showAddNewPhotoAlert(completion: @escaping (UIImage) -> Void) {
        self.completion = completion
        let choosePhotoAlertCoordinator = AlertCoordinator(navigationController)
        choosePhotoAlertCoordinator.parentCoordinator = self
        choosePhotoAlertCoordinator.start()
        childCoordinators.append(choosePhotoAlertCoordinator)
    }
    
    func successEditing() {
        navigationController.dismiss(animated: true)
    }
    
    func editPlantFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
