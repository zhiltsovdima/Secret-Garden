//
//  FavoritesViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 22.11.2022.
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    let shop: Shop
    
    private lazy var favoriteItems = shop.items.filter { item in
        item.isFavorite == true
    }
    
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
        
        configureTableView()
        
    }
    
    private func configureTableView() {
        setTableViewDelegates()
        tableView.rowHeight = 100
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
        return favoriteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.favoriteCell, for: indexPath) as! FavoriteCell
        
        cell.setFavorite(favoriteItems[indexPath.row])
        
        return cell
    }
    
}
