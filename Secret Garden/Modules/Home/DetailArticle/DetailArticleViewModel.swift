//
//  DetailArticleViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 25.05.2023.
//

import Foundation

protocol DetailArticleViewModelProtocol: AnyObject {
    var article: ArticleModel { get }
}

// MARK: - DetailArticleViewModel

final class DetailArticleViewModel {
    
    let article: ArticleModel
        
    private weak var coordinator: HomeCoordinatorProtocol?
    private let networkManager: NetworkManagerProtocol
    
    init(_ coordinator: HomeCoordinatorProtocol, _ networkManager: NetworkManagerProtocol,_ article: ArticleModel) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        self.article = article
    }
    
    
}

// MARK: - DetailArticleViewModelProtocol

extension DetailArticleViewModel: DetailArticleViewModelProtocol {
    
    
}
