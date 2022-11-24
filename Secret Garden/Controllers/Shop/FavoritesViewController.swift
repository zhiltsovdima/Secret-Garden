//
//  FavoritesViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 22.11.2022.
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    private let shop: Shop
    
    private let tableView = UITableView()
    
    init(_ shop: Shop) {
        self.shop = shop
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"
        navigationItem.largeTitleDisplayMode = .never
        
        configureTableView()
        
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

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shop.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.favoriteCell, for: indexPath) as! FavoriteCell
        
        let favItem = shop.favorites[indexPath.row]
        cell.setFavorite(favItem)
        cell.unfavoriteCompletion = { [weak self] unfavCell in
            let unfavIndexPath = self?.tableView.indexPath(for: unfavCell)
            DispatchQueue.main.async {
                self?.shop.favorites.remove(at: unfavIndexPath!.row)
                self?.tableView.deleteRows(at: [unfavIndexPath!], with: .fade)
            }
            self?.shop.favoriteItem(withId: favItem.id!, false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopItemId = shop.favorites[indexPath.row].id
        let shopItem = shop.items[shopItemId!]
        
        let itemDetailVC = ItemDetailController(shopItem)
        itemDetailVC.favoriteCompletion = { [weak self] isFavorite in
            self?.shop.favoriteItem(withId: shopItemId!, isFavorite)
            if isFavorite {
                let item = self?.shop.items[shopItemId!]
                self?.shop.favorites.append(item!)
            } else {
                self?.shop.favorites.remove(at: indexPath.row)
            }
            tableView.reloadData()
        }
        navigationController?.pushViewController(itemDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
