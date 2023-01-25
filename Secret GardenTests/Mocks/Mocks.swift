//
//  Mocks.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 16.01.2023.
//

import UIKit
@testable import Secret_Garden

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedVC = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

struct FeaturesMock {
    let latinName: String = "latin"
    let origin: String = "new zeeland"
    let idealLight: String = "bright"
    let watering: String = "hight"
    let insects: [String] = ["bug", "scary bug"]
    var temperature: String = "From 23 to 30"
}

class MockNetworkManager: NetworkManagerProtocol {
    
    func getPlant(by name: String?, completion: @escaping (Result<Features, NetworkError>) -> Void) {
        switch name {
        case "Failure":
            completion(.failure(NetworkError.failed))
        default:
            break
        }
    }
}

class MockGarden: GardenProtocol {
    
    func downloadFeatures(for plant: Secret_Garden.Plant, completion: ((Secret_Garden.Features?, String?) -> Void)?) {
        
    }
    
    
    var plants: [Plant] = [
        Plant(name: "Baz", image: PlantImageData(Resources.Images.Common.defaultPlant!)),
        Plant(name: "Bar", image: PlantImageData(Resources.Images.Common.defaultPlant!)),
        Plant(name: "Foo", image: PlantImageData(Resources.Images.Common.defaultPlant!))
    ]
    
    func getAllPlants() -> [Plant] {
        return plants
    }
    
    var updatePlantsCompletion: ((Secret_Garden.TypeOfChangeModel, Int?) -> Void)?
    
    func updatePlant(name: String?, image: UIImage?, _ rowInt: Int) {
        
    }
    
    func addNewPlant(name: String, image: UIImage) {
        
    }
    
    func removePlant(at index: Int) {
        
    }
    
    func saveToFile() {
        
    }
    
    func loadFromFile() {
        
    }
    
}
