//
//  Garden.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.11.2022.
//

import UIKit

class Garden {
    var plants = [Plant]()
    
    private let networkManager: NetworkManagerProtocol
    private let plantsDataManager: PlantsDataManagerProtocol
    
    var updatePlantsCompletion: ((TypeOfChangeModel, Int?) -> Void)?
    
    init(networkManager: NetworkManagerProtocol, plantsDataManager: PlantsDataManagerProtocol) {
        self.networkManager = networkManager
        self.plantsDataManager = plantsDataManager
    }
    
    func updatePlant(id: String, name: String, image: UIImage, at index: Int) {
        guard let plant = plants.first(where: { $0.id == id }) else { return }
        plant.name = name
        plant.imageData = PlantImageData(image)
        plant.isFetched = false
        updatePlantsCompletion?(.update, index)
    }
    
    func addNewPlant(name: String, image: UIImage) {
        let imageData = PlantImageData(image)
        let plant = Plant(name: name, image: imageData)
        plants.insert(plant, at: 0)
        updatePlantsCompletion?(.insert, nil)
    }
    
    func removePlant(id: String, at index: Int) {
        plants.removeAll(where: { $0.id == id })
        updatePlantsCompletion?(.delete, index)
    }
    
    func downloadFeatures(for plant: Plant, completion: ((Features?, NetworkError?) -> Void)?) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            completion?(nil, NetworkError.noDataForThisName)
//            return
//        }
        if let features = plant.features {
            completion?(features, nil)
            return
        }
        let name = plant.name
        let endpoint = APIEndpoints.plants(.common(name))
        
        guard !plant.isFetched else { completion?(nil, NetworkError.noDataForThisName); return }
        networkManager.fetchData(by: endpoint) { [weak plant] (result: Result<[Features], NetworkError>) in
            switch result {
            case .success(let features):
                guard let features = features.first else {
                    completion?(nil, NetworkError.noDataForThisName)
                    return
                }
                plant?.features = features
                plant?.isFetched = true
                completion?(plant?.features, nil)
            case .failure(let error):
                if error == NetworkError.noDataForThisName {
                    plant?.isFetched = true
                } else {
                    plant?.isFetched = false
                }
                completion?(nil, error)
            }
        }
    }
    
    func uploadPlants() {
        let result = plantsDataManager.loadFromFile()
        switch result {
        case .success(let loadedPlants):
            plants = loadedPlants
        case .failure(let error):
            print("Failed loadFromFile: \(error)")
        }
    }
    
    func savePlants() {
        plantsDataManager.saveToFile(plants: plants)
    }
}
