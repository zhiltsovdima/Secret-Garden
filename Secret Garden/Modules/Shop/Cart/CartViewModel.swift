//
//  CartViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 02.02.2023.
//

import Foundation

protocol CartViewModelProtocol: AnyObject {
    var tableData: [CartCellModel] { get }
    var isEmptyTableData: Bool { get }
    var subTotalPrice: String? { get }
    var totalPrice: String? { get }
    var updateCellCompletion: ((IndexPath) -> Void)? { get set }

    func removeButtonTapped(id: Int, indexPath: IndexPath)
    func backToShopButtonTapped()
    func viewWillDisappear()
}

// MARK: - CartViewModel

final class CartViewModel {
    
    var tableData = [CartCellModel]() {
        didSet {
            isEmptyTableData = tableData.isEmpty
            getPrice()
        }
    }
    var isEmptyTableData = true
    var subTotalPrice: String?
    var totalPrice: String?
    private var deliveryPrice = 10.0
    
    private weak var coordinator: CartCoordinatorProtocol?
    private let shop: Shop
    
    var updateCellCompletion: ((IndexPath) -> Void)?
    
    init(coordinator: CartCoordinatorProtocol, shop: Shop) {
        self.coordinator = coordinator
        self.shop = shop
        self.getTableData()
    }
    
    private func getTableData() {
        tableData = shop.items
            .filter { $0.isAddedToCart == true }
            .compactMap { CartCellModel(
                id: $0.id!,
                name: $0.name!,
                price: $0.price!,
                image: $0.image
            )}
    }
    
    private func getPrice() {
        var price = 0.0
        tableData.forEach { item in
            let priceStr = item.price.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)
            price += Double(priceStr) ?? 0.0 
        }
        subTotalPrice = "$\(price)"
        totalPrice = "$\(price + deliveryPrice)"
    }
    
}

// MARK: - CartViewModelProtocol

extension CartViewModel: CartViewModelProtocol {
    
    func removeButtonTapped(id: Int, indexPath: IndexPath) {
        shop.makeAddedToCart(withId: id)
        tableData.remove(at: indexPath.row)
        updateCellCompletion?(indexPath)
    }
    
    func backToShopButtonTapped() {
        coordinator?.backToShop()
    }
    
    func viewWillDisappear() {
        coordinator?.cartDidFinish()
    }
}
