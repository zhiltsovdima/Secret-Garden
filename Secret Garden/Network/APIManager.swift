//
//  APIManager.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.11.2022.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabaseSwift

protocol APIManagerDelegate {
    func didUpdate(with characteristics: PlantCharacteristics, index: Int)
}

struct APIManager {
    
    static var shared = APIManager()
    
    var delegate: APIManagerDelegate?
    
    private func configureFB() -> Firestore {
        let dataBase = Firestore.firestore()
        return dataBase
    }
    
    func getPost(collectionName: String, completion: @escaping ([ShopItem]) -> Void) {
        let db = configureFB()
        
        db.collection(collectionName).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            let items = documents.map { queryDocumentSnapshot in
                let data = queryDocumentSnapshot.data()
                
                let name = data["name"] as? String ?? ""
                let latinName = data["latinName"] as? String ?? ""
                let category = data["category"] as? String
                let description = data["description"] as? String
                let image = data["image"] as? String
                let price = data["price"] as? String
                let size = data["size"] as? String
                let petFriendly = data["petFriendly"] as? String
                let careLevel = data["careLevel"] as? String
                let origin = data["origin"] as? String
                let light = data["light"] as? String
                let humidity = data["humidity"] as? String
                let temperature = data["temperature"] as? String

                return ShopItem(name: name,
                                latinName: latinName,
                                category: category,
                                description: description,
                                price: price,
                                size: size,
                                petFriendly: petFriendly,
                                careLevel: careLevel,
                                origin: origin,
                                light: light,
                                humidity: humidity,
                                temperature: temperature,
                                imageString: image)
            }
            completion(items)
        }
    }
    
    func getImage(name: String?, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("pictures")
        
        var image = Resources.Images.Common.defaultPlant!
        
        guard let name else { completion(image); return }
        
        let fileRef = pathRef.child(name + ".jpg")
        fileRef.getData(maxSize: 1024*1024) { (data, error) in
            guard error == nil else {
                completion(image)
                print("Get Image error: \(error!)")
                return
            }
            image = UIImage(data: data!)!
            completion(image)
        }
    }
    
    // MARK: - Fetching Plant's Characteristics
    
    func performRequest(namePlant: String, index: Int) {
        
        let name = namePlant.lowercased().replacingOccurrences(of: " ", with: "")
        
        let headers = [
            "X-RapidAPI-Key": "b05530de65msh6cfb2133d9fa5bdp1b3829jsn681eaacbbab4",
            "X-RapidAPI-Host": "house-plants.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://house-plants.p.rapidapi.com/common/\(name)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("Request Error: \(error!)")
            }
            if (response != nil) {
                let httpResponse = response as? HTTPURLResponse
                print("Response: \(httpResponse!)")
            }
            if let safeData = data {
                if let characteristics = parseJSON(safeData) {
                    delegate?.didUpdate(with: characteristics, index: index)
                }
            }
        })

        dataTask.resume()
    }
    
    func parseJSON(_ plantData: Data) -> PlantCharacteristics? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([PlantData].self, from: plantData)
            
            guard decodedData.count > 0 else { return nil }
            
            let dataForPlant = decodedData.first!
            
            let latin = dataForPlant.latin
            let origin = dataForPlant.origin
            let temp = "From \(dataForPlant.tempmin.celsius)C to \(dataForPlant.tempmax.celsius)C"
            let idealLight = dataForPlant.ideallight
            let watering = dataForPlant.watering
            let insectsArray = dataForPlant.insects
            let insects = insectsArray.joined(separator: ", ")
            
            let characteristic = PlantCharacteristics(latinName: latin,
                                                      dictionary: [Resources.Strings.Common.Detail.origin: origin,
                                                                   Resources.Strings.Common.Detail.temperature: temp,
                                                                   Resources.Strings.Common.Detail.light: idealLight,
                                                                   Resources.Strings.Common.Detail.watering: watering,
                                                                   Resources.Strings.Common.Detail.insects: insects
                                                      ])
            return characteristic
        } catch {
            print("Decode Error: \(error)")
            return nil
        }
    }
}
