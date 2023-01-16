//
//  DetailPlantViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.01.2023.
//

import Foundation
import UIKit.UIImage

struct DetailPlantModel {
    var name: String
    var image: UIImage?
    var latinName: String?
    var errorMessage: String?
}

// MARK: - DetailPlantViewModelProtocol

protocol DetailPlantViewModelProtocol: AnyObject {
    var viewData: DetailPlantModel! { get }
    var tableData: [FeatureCellModel] { get }
    
    var updateCompletion: ((Bool) -> Void)? { get set }
    func viewWillDisappear()
}

// MARK: - DetailPlantViewModel

final class DetailPlantViewModel {
    
    var viewData: DetailPlantModel!
    var tableData = [FeatureCellModel]()
    
    var updateCompletion: ((Bool) -> Void)?
        
    private weak var coordinator: DetailPlantCoordinatorProtocol?
    private let garden: Garden
    private let index: Int
            
    init(coordinator: DetailPlantCoordinatorProtocol, _ garden: Garden, _ index: Int) {
        self.coordinator = coordinator
        self.garden = garden
        self.index = index
        self.getViewData()
    }
    
    private func getViewData() {
        let plant = garden.getAllPlants()[index]
        viewData = DetailPlantModel(name: plant.name, image: plant.imageData.image)
        
        plant.downloadFeatures { [weak self] features, errorMessage in
            guard let features else {
                self?.viewData.errorMessage = errorMessage
                self?.updateCompletion?(false)
                return
            }
            let insects = features.insects.joined(separator: ", ")
            let featuresData = [
                (Resources.Images.Features.light,
                 self?.convertString(name: Resources.Strings.Common.Detail.light,
                                     value: features.idealLight)
                ),
                (Resources.Images.Features.temperature,
                 self?.convertString(name: Resources.Strings.Common.Detail.temperature,
                                     value: features.temperature)
                ),
                (Resources.Images.Features.humidity,
                 self?.convertString(name: Resources.Strings.Common.Detail.watering,
                                     value: features.watering)
                ),
                (Resources.Images.Features.insects,
                 self?.convertString(name: Resources.Strings.Common.Detail.insects,
                                     value: insects)
                ),
                (Resources.Images.Features.origin,
                 self?.convertString(name: Resources.Strings.Common.Detail.origin,
                                     value: features.origin)
                )
            ]
            self?.tableData = featuresData.compactMap { FeatureCellModel(featureImage: $0.0, featureValue: $0.1)}
            self?.viewData.latinName = features.latinName
            self?.updateCompletion?(true)
        }
    }
    
    private func convertString(name: String, value: String) -> NSMutableAttributedString {
        let atrString1 = NSMutableAttributedString(string: name + ": ",
                                                   attributes: [NSAttributedString.Key.font: Resources.Fonts.generalBold!])
        let atrString2 = NSMutableAttributedString(string: value,
                                                   attributes: [NSAttributedString.Key.font: Resources.Fonts.general!])
        atrString1.append(atrString2)
        return atrString1
    }

}

// MARK: - DetailPlantViewModelProtocol

extension DetailPlantViewModel: DetailPlantViewModelProtocol {
    
    func viewWillDisappear() {
        coordinator?.detailPlantFinish()
    }
    
}
