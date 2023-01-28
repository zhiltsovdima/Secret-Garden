//
//  DBManager.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.11.2022.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabaseSwift

struct DBManager {
            
    private func configureFB() -> Firestore {
        let dataBase = Firestore.firestore()
        return dataBase
    }
    
    func getPost(completion: @escaping ([ShopItem]) -> Void) {
        let db = configureFB()
        let collectionName = Resources.Strings.DataBase.collectionNameInDataBase
        
        db.collection(collectionName).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            let items = documents.map { queryDocumentSnapshot in
                let data = queryDocumentSnapshot.data()
                
                let name = data["name"] as? String
                let latinName = data["latinName"] as? String
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
}
