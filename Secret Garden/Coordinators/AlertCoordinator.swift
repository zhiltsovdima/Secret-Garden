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
        case is ImagePickable:
            createPhotoChooseAlert()
        default:
            break
        }
    }
    
    private func createPhotoChooseAlert() {
        let alertController = UIAlertController(title: Resources.Strings.AddPlant.titleAlert, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: Resources.Strings.AddPlant.camera, style: .default) { [weak self] _ in
            guard let parent = self?.parentCoordinator as? ImagePickable else { return }
            parent.showImagePicker(sourceType: .camera)
            self?.parentCoordinator?.childDidFinish(self!)
        }
        let photoLibraryAction = UIAlertAction(title: Resources.Strings.AddPlant.photoLibrary, style: .default) { [weak self] _ in
            guard let parent = self?.parentCoordinator as? ImagePickable else { return }
            parent.showImagePicker(sourceType: .photoLibrary)
            self?.parentCoordinator?.childDidFinish(self!)
        }
        let cancelAction = UIAlertAction(title: Resources.Strings.Common.cancel, style: .cancel) { [weak self] _ in
            self?.parentCoordinator?.childDidFinish(self!)
        }
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        navigationController.visibleViewController?.present(alertController, animated: true)
    }
}
