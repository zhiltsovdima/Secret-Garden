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
        if let parent = parentCoordinator as? (ImagePickable & Coordinator) {
            createPhotoChooseAlert(for: parent)
        }
    }
    
    private func showAlertController(title: String?, message: String?, preferredStyle: UIAlertController.Style, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach(alertController.addAction)
        navigationController.visibleViewController?.present(alertController, animated: true)
    }
    
    private func createPhotoChooseAlert(for parent: ImagePickable & Coordinator) {
        let cameraAction = UIAlertAction(title: Resources.Strings.AddPlant.camera, style: .default) { _ in
            parent.showImagePicker(sourceType: .camera)
            parent.childDidFinish(self)
        }
        let photoLibraryAction = UIAlertAction(title: Resources.Strings.AddPlant.photoLibrary, style: .default) { _ in
            parent.showImagePicker(sourceType: .photoLibrary)
            parent.childDidFinish(self)
        }
        let cancelAction = UIAlertAction(title: Resources.Strings.Common.cancel, style: .cancel) { _ in
            parent.childDidFinish(self)
        }
        showAlertController(
            title: Resources.Strings.AddPlant.titleAlert,
            message: nil,
            preferredStyle: .actionSheet,
            actions: [
                cameraAction,
                photoLibraryAction,
                cancelAction
            ]
        )
    }
}
