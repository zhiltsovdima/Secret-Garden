//
//  FavoritesViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 22.11.2022.
//

import UIKit

final class FavoritesViewController: BaseViewController {
    
    private let shop: Shop
    
    private let tableView = UITableView()
    
    private let placeholder = UIImageView(image: Resources.Images.Common.emptyCollection)
    
    init(_ shop: Shop) {
        self.shop = shop
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppearance()
        configureTableView()
        configurePlaceholder()
        isItEmpty()
    }
    
    private func updateUI(_ indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .fade)
        isItEmpty()
    }
    
    private func setAppearance() {
        title = "Favorites"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureTableView() {
        setTableViewDelegates()
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: Resources.Identifiers.favoriteCell)
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
// MARK: - Placeholder Configuration

extension FavoritesViewController {
    
    private func isItEmpty() {
        if shop.favorites.isEmpty {
            tableView.isHidden = true
            placeholder.isHidden = false
        } else {
            tableView.isHidden = false
            placeholder.isHidden = true
        }
    }
    
    private func configurePlaceholder() {
        view.addSubview(placeholder)
        placeholder.isHidden = true
        placeholder.contentMode = .scaleAspectFit
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholder.topAnchor.constraint(equalTo: view.topAnchor),
            placeholder.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            placeholder.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            placeholder.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shop.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.favoriteCell, for: indexPath) as! FavoriteCell
        
        let favItem = shop.favorites[indexPath.row]
        let favItemId = favItem.id!
        cell.setFavorite(favItem)
        cell.unfavoriteCompletion = { unfavCell in
            let unfavIndexPath = self.tableView.indexPath(for: unfavCell)
            DispatchQueue.main.async {
                self.shop.makeFavoriteItem(withId: favItemId, to: false)
                self.updateUI(unfavIndexPath!)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopItemId = shop.favorites[indexPath.row].id!
        let shopItem = shop.items[shopItemId]
        
        let itemDetailVC = ItemDetailController(shopItem)
        itemDetailVC.favoriteCompletion = { isFavorite in
            DispatchQueue.main.async {
                self.shop.makeFavoriteItem(withId: shopItemId, to: isFavorite)
                self.updateUI(indexPath)
            }
        }
        itemDetailVC.cartCompletion = {
            self.shop.makeAddedToCart(withId: shopItemId, to: true)
        }
        itemDetailVC.goToCartCompletion = {
            let cartVC = CartViewController(self.shop)
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
        navigationController?.pushViewController(itemDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}