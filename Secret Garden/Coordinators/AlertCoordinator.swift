//
//  AlertCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.01.2023.
//

import UIKit

final class AlertCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    private var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        switch parentCoordinator {
        case is AddNewPlantCoordinator:
            createPhotoChooseAlert()
        default:
            break
        }
        
    }
    
    private func createPhotoChooseAlert() {
        let alertController = UIAlertController(title: Resources.Strings.AddPlant.titleAlert, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: Resources.Strings.AddPlant.camera, style: .default) { [weak self] _ in
            guard let parent = self?.parentCoordinator as? AddNewPlantCoordinator else { return }
            self?.navigationController.dismiss(animated: true)
            parent.showImagePicker(sourceType: .camera)
            parent.childDidFinish(self!)
        }
        let photoLibraryAction = UIAlertAction(title: Resources.Strings.AddPlant.photoLibrary, style: .default) { [weak self] _ in
            guard let parent = self?.parentCoordinator as? AddNewPlantCoordinator else { return }
            self?.navigationController.dismiss(animated: true)
            parent.showImagePicker(sourceType: .photoLibrary)
            parent.childDidFinish(self!)
        }
        let cancelAction = UIAlertAction(title: Resources.Strings.Common.cancel, style: .cancel) { [weak self] _ in
            self?.navigationController.dismiss(animated: true)
            self?.parentCoordinator?.childDidFinish(self!)
        }
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        navigationController.present(alertController, animated: true)
    }
}
