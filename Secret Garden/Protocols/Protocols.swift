//
//  Protocols.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.01.2023.
//

import UIKit

protocol ImagePickable {
    func showImagePicker(sourceType: UIImagePickerController.SourceType)
    func didFinishPicking(_ image: UIImage)
}