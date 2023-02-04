//
//  FavoritesViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 22.11.2022.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    private let viewModel: FavoritesViewModelProtocol
    
    private let tableView = UITableView()
    
    private let placeholder = UIImageView(image: Resources.Images.Common.emptyCollection)
    
    init(viewModel: FavoritesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        setupAppearance()
        setupTableView()
        setupPlaceholder()
        showPlaceholder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisappear()
    }
    
    private func updateUI() {
        viewModel.updateCellCompletion = { [weak self] indexPath in
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
            self?.showPlaceholder()
        }
    }
    
    private func setupAppearance() {
        title = "Favorites"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = Resources.Colors.backgroundColor
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = Resources.Colors.backgroundColor
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: Resources.Identifiers.favoriteCell)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - Placeholder Settings

extension FavoritesViewController {
    
    private func setupPlaceholder() {
        view.addSubview(placeholder)
        placeholder.contentMode = .scaleAspectFit
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholder.topAnchor.constraint(equalTo: view.topAnchor),
            placeholder.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            placeholder.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            placeholder.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func showPlaceholder() {
        if viewModel.isEmptyTableData {
            tableView.isHidden = true
            placeholder.isHidden = false
        } else {
            tableView.isHidden = false
            placeholder.isHidden = true
        }
    }
}

// MARK: - TableView Delegate & DataSource

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.favoriteCell, for: indexPath) as! FavoriteCell
        
        let id = viewModel.tableData[indexPath.row].id
        cell.setup(with: viewModel.tableData[indexPath.row])
        cell.unfavoriteCompletion = { [weak self] unfavCell in
            guard let actualIndexPath = tableView.indexPath(for: unfavCell) else { return }
            self?.viewModel.unfavoriteButtonTapped(id: id, indexPath: actualIndexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let shopItem = favorites[indexPath.row]
//        let shopItemId = shopItem.id!
//
//        let itemDetailVC = ItemDetailController(shopItem)
//        itemDetailVC.favoriteCompletion = { [weak self] in
//            self?.shop.makeFavoriteItem(withId: shopItemId)
//            self?.tableView.reloadData()
//        }
//        itemDetailVC.cartCompletion = { [weak self] in
//            self?.shop.makeAddedToCart(withId: shopItemId)
//        }
//        itemDetailVC.goToCartCompletion = { [weak self] updateCompletion in
//            let cartVC = CartViewController(self!.shop)
//            cartVC.updateDetailVCHandler = updateCompletion
//            self?.navigationController?.pushViewController(cartVC, animated: true)
//        }
//        navigationController?.pushViewController(itemDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
