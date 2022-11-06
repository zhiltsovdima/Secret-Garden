//
//  Plant.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 01.11.2022.
//

import UIKit

struct Plant {
    var name: String
    var image: UIImage?
}

struct Garden {
    var plants = [Plant]()
    
    init() {
        setup()
    }
    
    mutating func addNewPlant(name: String, image: UIImage) {
        let plant = Plant(name: name, image: image)
        plants.insert(plant, at: 0)
    }
    
    mutating func removePlant(at index: Int) {
        plants.remove(at: index)
    }
    
    mutating func setup() {
        let names = ["Ficus", "Croton", "Another one", "One more"]
        let images = [UIImage(named: "plant1"),
                      UIImage(named: "plant2"),
                      UIImage(named: "plant3"),
                      UIImage(named: "plant22")
        ]
        
        for index in 0...3 {
            plants.append(Plant(name: names[index], image: images[index]))
        }
    }
}
