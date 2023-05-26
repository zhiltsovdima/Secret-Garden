//
//  DetailArticleViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 25.05.2023.
//

import Foundation

protocol DetailArticleViewModelProtocol: AnyObject {
    var article: ArticleModel { get }
    func fetchFullText()
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
    
    func fetchFullText() {
        guard article.fullText.value == nil else { return }
        let fullTextId = article.textId
        networkManager.fetchData(by: .fullText(fullTextId)) { [weak article] (result: Result<ArticleTextData, NetworkError>) in
            switch result {
            case .success(let articleTextData):
                let fullText = articleTextData.body
                article?.fullText.accept(fullText)
            case .failure(let netError):
                print("Full text fetching failure: \(netError.description)")
            }
        }
    }
    
}
