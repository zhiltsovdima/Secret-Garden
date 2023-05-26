//
//  ArticleModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 26.05.2023.
//

import Foundation
import RxSwift
import RxCocoa

final class ArticleModel {
    let title: String
    let category: String
    let textId: String
    let imageString: String
    let date: String
    
    var image = BehaviorRelay<UIImage?>(value: nil)
    var fullText = BehaviorRelay<String?>(value: nil)
        
    init(title: String, category: String, textId: String, imageString: String, date: String) {
        self.title = title
        self.category = category
        self.textId = textId
        self.imageString = imageString
        self.date = date
    }
}
