//
//  ShopViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

final class ShopViewController: UIViewController {
    
    private let viewModel: ShopViewModelProtocol
    
    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
    private let flowLayout = UICollectionViewFlowLayout()
    
    private var boundsCollectionWidth: CGFloat {
        return collectionView.bounds.width
    }
    private var gapItems: CGFloat {
        return flowLayout.minimumInteritemSpacing * (Resources.Constants.shopVC.columnCount - 1)
    }
    private var gapSection: CGFloat {
        return flowLayout.sectionInset.right * 2.0
    }
    private var width: CGFloat {
        return (boundsCollectionWidth - gapItems - gapSection) / Resources.Constants.shopVC.columnCount
    }
    
    init(viewModel: ShopViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        setupUI()
        setupCollectionView()
        addNavBarButtons()
    }
    
    private func setupUI() {
        title = Resources.Strings.TabBar.shop
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = Resources.Colors.blackOnWhite
        view.backgroundColor = Resources.Colors.backgroundColor
    }
    
    private func updateUI() {
        viewModel.updateCellCompletion = { [weak self] indexPath in
            guard let indexPath else { self?.collectionView.reloadData(); return }
            self?.collectionView.reloadItems(at: [indexPath])
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        collectionView.backgroundColor = Resources.Colors.backgroundColor
        collectionView.register(ItemCell.self,
                                forCellWithReuseIdentifier: Resources.Identifiers.itemCell)
        collectionView.register(CategoriesView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: Resources.Identifiers.categoriesView)
        
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: Resources.Constants.shopVC.itemsSpacing,
                                               left: Resources.Constants.shopVC.itemsSpacing,
                                               bottom: 0,
                                               right: Resources.Constants.shopVC.itemsSpacing)
        flowLayout.minimumInteritemSpacing = Resources.Constants.shopVC.itemsSpacing
        flowLayout.minimumLineSpacing = Resources.Constants.shopVC.itemsSpacing
    }
    
}

// MARK: - NavBar Buttons

extension ShopViewController {
    
    private func addNavBarButtons() {
        let buttons = [UIBarButtonItem(image: Resources.Images.Common.favorites,
                                       style: .done,
                                       target: self,
                                       action: #selector(navBarFavoritesButtonAction)),
                       UIBarButtonItem(image: Resources.Images.Common.cart,
                                       style: .done,
                                       target: self,
                                       action: #selector(navBarCartButtonAction))
        ]
        navigationItem.rightBarButtonItems = buttons
    }
    
    @objc private func navBarFavoritesButtonAction() {
        viewModel.navBarFavoritesButtonTapped()
    }
    
    @objc private func navBarCartButtonAction() {
        viewModel.navBarCartButtonTapped()
    }
}

// MARK: - UICollectionViewDelegate

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.Identifiers.itemCell, for: indexPath) as! ItemCell
        cell.setup(with: viewModel.collectionData[indexPath.item])
        viewModel.updateImage(with: indexPath)
        cell.favoriteCompletion = { [weak self] id in
            self?.viewModel.favoriteButtonTapped(id: id, indexPath: indexPath)
        }
        cell.cartCompletion = { [weak self] id in
            self?.viewModel.cartButtonTapped(id: id, indexPath: indexPath)
        }
        cell.goToCartCompletion = { [weak self] in
            self?.viewModel.navBarCartButtonTapped()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: - SupplementaryView
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: Resources.Identifiers.categoriesView,
                                                                     for: indexPath) as! CategoriesView
        header.congifure()
        header.selectCategoryHandler = { [weak self] selectedCategory in
            self?.viewModel.updateModel(by: selectedCategory)
        }
        return header
    }
}

// MARK: - UICollectionViewPrefetching

extension ShopViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShopViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: width, height: width / Resources.Constants.shopVC.aspectRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: width, height: 40)
    }
}


// MARK: ---------------------------


//
//    private let shop = Shop()
//
//    private var filteredItems = [ShopItem]() {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
//    private var isSelectedCategory = false
//
//    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
//    private let flowLayout = UICollectionViewFlowLayout()
//
//    private var boundsCollectionWidth: CGFloat {
//        return collectionView.bounds.width
//    }
//    private var gapItems: CGFloat {
//        return flowLayout.minimumInteritemSpacing * (Resources.Constants.shopVC.columnCount - 1)
//    }
//    private var gapSection: CGFloat {
//        return flowLayout.sectionInset.right * 2.0
//    }
//    private var width: CGFloat {
//        return (boundsCollectionWidth - gapItems - gapSection) / Resources.Constants.shopVC.columnCount
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setNavbarAppearance()
//        addNavBarButtons()
//
//        configureCollectionView()
//        updateUIFromModel()
//
//    }
//}
//
//// MARK: - Updating UI
//
//extension ShopViewController {
//
//    private func updateUIFromModel() {
//        shop.updateViewCompletion = { [weak self] index, indexPath in
//            guard let isSelectedCategory = self?.isSelectedCategory else { return }
//            guard isSelectedCategory else {
//                DispatchQueue.main.async {
//                    self?.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
//                }
//                return
//            }
//            guard let indexPath else { self?.collectionView.reloadData(); return }
//            self?.collectionView.reloadItems(at: [indexPath])
//        }
//    }
//
//    private func updateFilteredItems(categoryName: String) {
//        filteredItems = shop.items.filter { $0.category?.lowercased() == categoryName.lowercased() }
//    }
//}
//
//// MARK: - Views Settings
//
//extension ShopViewController {
//
//    private func setNavbarAppearance() {
//        title = Resources.Strings.TabBar.shop
//        navigationItem.largeTitleDisplayMode = .always
//        navigationController?.navigationBar.tintColor = Resources.Colors.blackOnWhite
//        view.backgroundColor = Resources.Colors.backgroundColor
//    }
//
//    private func configureCollectionView() {
//
//        setDelegates()
//        collectionView.register(ItemCell.self,
//                                forCellWithReuseIdentifier: Resources.Identifiers.itemCell)
//        collectionView.register(CategoriesView.self,
//                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//                                withReuseIdentifier: Resources.Identifiers.categoriesView)
//        collectionView.backgroundColor = Resources.Colors.backgroundColor
//
//        view.addSubview(collectionView)
//        flowLayout.scrollDirection = .vertical
//        flowLayout.sectionInset = UIEdgeInsets(top: Resources.Constants.shopVC.itemsSpacing,
//                                               left: Resources.Constants.shopVC.itemsSpacing,
//                                               bottom: 0,
//                                               right: Resources.Constants.shopVC.itemsSpacing)
//        flowLayout.minimumInteritemSpacing = Resources.Constants.shopVC.itemsSpacing
//        flowLayout.minimumLineSpacing = Resources.Constants.shopVC.itemsSpacing
//
//    }
//
//    private func setDelegates() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.prefetchDataSource = self
//    }
//
//}
//
//// MARK: - NavBar Buttons
//
//extension ShopViewController {
//
//    private func addNavBarButtons() {
//        let buttons = [UIBarButtonItem(image: Resources.Images.Common.favorites,
//                                     style: .done,
//                                     target: self,
//                                     action: #selector(favoritesAction)),
//                       UIBarButtonItem(image: Resources.Images.Common.cart,
//                                       style: .done,
//                                       target: self,
//                                       action: #selector(cartAction))
//                       ]
//        navigationItem.rightBarButtonItems = buttons
//    }
//
//    @objc private func cartAction() {
//        let cartVC = CartViewController(shop)
//        navigationController?.pushViewController(cartVC, animated: true)
//    }
//    @objc private func favoritesAction() {
//        let favoritesVC = FavoritesViewController(shop)
//        navigationController?.pushViewController(favoritesVC, animated: true)
//    }
//}
//
//// MARK: - UICollectionViewDelegate
//
//extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if isSelectedCategory {
//            return filteredItems.count
//        } else {
//            return shop.items.count
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.Identifiers.itemCell, for: indexPath) as! ItemCell
//
//        let shopItem = isSelectedCategory ? filteredItems[indexPath.item] : shop.items[indexPath.item]
//        let shopItemId = shopItem.id!
//
//        cell.setItem(shopItem)
//
//        cell.favoriteCompletion = { [weak self] in
//            self?.shop.makeFavoriteItem(withId: shopItemId, at: indexPath)
//        }
//        cell.cartCompletion = { [weak self] in
//            self?.shop.makeAddedToCart(withId: shopItemId, at: indexPath)
//        }
//        cell.goToCartCompletion = { [weak self] in
//            let cartVC = CartViewController(self!.shop)
//            self?.navigationController?.pushViewController(cartVC, animated: true)
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let shopItem = isSelectedCategory ? filteredItems[indexPath.item] : shop.items[indexPath.item]
//        let shopItemId = shopItem.id!
//
//        let itemDetailVC = ItemDetailController(shopItem)
//        itemDetailVC.favoriteCompletion = { [weak self] in
//            self?.shop.makeFavoriteItem(withId: shopItemId, at: indexPath)
//        }
//        itemDetailVC.cartCompletion = { [weak self] in
//            self?.shop.makeAddedToCart(withId: shopItemId, at: indexPath)
//        }
//        itemDetailVC.goToCartCompletion = { [weak self] updateCompletion in
//            let cartVC = CartViewController(self!.shop)
//            cartVC.updateDetailVCHandler = updateCompletion
//            self?.navigationController?.pushViewController(cartVC, animated: true)
//        }
//        navigationController?.pushViewController(itemDetailVC, animated: true)
//    }
//
//    // MARK: - SupplementaryView
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
//                                                                     withReuseIdentifier: Resources.Identifiers.categoriesView,
//                                                                     for: indexPath) as! CategoriesView
//        header.congifure()
//        header.selectCategoryHandler = { [weak self] selectedCategory in
//            switch selectedCategory {
//            case Resources.Strings.Shop.Categories.indoor:
//                self?.isSelectedCategory = true
//                self?.updateFilteredItems(categoryName: Resources.Strings.Shop.Categories.indoor)
//            case Resources.Strings.Shop.Categories.outdoor:
//                self?.isSelectedCategory = true
//                self?.updateFilteredItems(categoryName: Resources.Strings.Shop.Categories.outdoor)
//            case Resources.Strings.Shop.Categories.fertilizer:
//                self?.isSelectedCategory = true
//                self?.updateFilteredItems(categoryName: Resources.Strings.Shop.Categories.fertilizer)
//            default:
//                self?.isSelectedCategory = false
//                self?.filteredItems = []
//            }
//        }
//        return header
//    }
//}
//
//// MARK: - UICollectionViewPrefetching
//
//extension ShopViewController: UICollectionViewDataSourcePrefetching {
//
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            let shopItem = shop.items[indexPath.item]
//            shopItem.downloadData(completion: nil)
//        }
//    }
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//extension ShopViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: width, height: width / Resources.Constants.shopVC.aspectRatio)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        return CGSize(width: width, height: 40)
//    }
//}
