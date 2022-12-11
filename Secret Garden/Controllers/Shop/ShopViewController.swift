//
//  ShopViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

final class ShopViewController: BaseViewController {
    
    private let shop = Shop()
    
    private var filteredItems = [ShopItem]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private var isSelectedCategory = false
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavbarAppearance()
        addNavBarButtons()
        
        configureCollectionView()
        updateUIFromModel()
        
    }
}

// MARK: - Updating UI

extension ShopViewController {
    
    private func updateUIFromModel() {
        shop.updateViewCompletion = { [weak self] index in
            if self?.isSelectedCategory == true {
                let categoryName = self?.shop.items[index].category!
                self?.updateFilteredItems(categoryName: categoryName!)
            } else {
                DispatchQueue.main.async {
                    self?.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
                }
            }
        }
    }
    
    private func updateFilteredItems(categoryName: String) {
        filteredItems = shop.items.filter({ item in
            if item.category?.lowercased() == categoryName.lowercased() {
                return true
            } else {
                return false
            }
        })
    }
}

// MARK: - Views Settings

extension ShopViewController {
    
    private func setNavbarAppearance() {
        title = Resources.Strings.TabBar.shop
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureCollectionView() {
        
        setDelegates()
        collectionView.register(ItemCell.self,
                                forCellWithReuseIdentifier: Resources.Identifiers.itemCell)
        collectionView.register(CategoriesView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: Resources.Identifiers.categoriesView)
        
        view.addSubview(collectionView)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: Resources.Constants.shopVC.itemsSpacing,
                                               left: Resources.Constants.shopVC.itemsSpacing,
                                               bottom: 0,
                                               right: Resources.Constants.shopVC.itemsSpacing)
        flowLayout.minimumInteritemSpacing = Resources.Constants.shopVC.itemsSpacing
        flowLayout.minimumLineSpacing = Resources.Constants.shopVC.itemsSpacing
    
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

// MARK: - NavBar Buttons

extension ShopViewController {
    
    private func addNavBarButtons() {
        let buttons = [UIBarButtonItem(image: Resources.Images.Common.favorites,
                                     style: .done,
                                     target: self,
                                     action: #selector(favoritesAction)),
                       UIBarButtonItem(image: Resources.Images.Common.cart,
                                       style: .done,
                                       target: self,
                                       action: #selector(cartAction))
                       ]
        navigationItem.rightBarButtonItems = buttons
    }
    
    @objc private func cartAction() {
        let cartVC = CartViewController(shop)
        navigationController?.pushViewController(cartVC, animated: true)
    }
    @objc private func favoritesAction() {
        let favoritesVC = FavoritesViewController(shop)
        navigationController?.pushViewController(favoritesVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSelectedCategory {
            return filteredItems.count
        } else {
            return shop.items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.Identifiers.itemCell, for: indexPath) as! ItemCell
        
        let shopItem = isSelectedCategory ? filteredItems[indexPath.item] : shop.items[indexPath.item]
        let shopItemId = shopItem.id!
        
        cell.setItem(shopItem)
        
        cell.favoriteCompletion = { isFavorite in
            self.shop.makeFavoriteItem(withId: shopItemId, to: isFavorite)
        }
        cell.cartCompletion = {
            self.shop.makeAddedToCart(withId: shopItemId, to: true)
        }
        cell.goToCartCompletion = {
            let cartVC = CartViewController(self.shop)
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shopItem = isSelectedCategory ? filteredItems[indexPath.item] : shop.items[indexPath.item]
        let shopItemId = shopItem.id!
        
        let itemDetailVC = ItemDetailController(shopItem)
        itemDetailVC.favoriteCompletion = { isFavorite in
            self.shop.makeFavoriteItem(withId: shopItemId, to: isFavorite)
        }
        itemDetailVC.cartCompletion = {
            self.shop.makeAddedToCart(withId: shopItemId, to: true)
        }
        itemDetailVC.goToCartCompletion = {
            let cartVC = CartViewController(self.shop)
            cartVC.updateDetailVCHandler = { id in
                if itemDetailVC.shopItem.id == id {
                    itemDetailVC.shopItem = self.shop.items[id]
                }
            }
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
        navigationController?.pushViewController(itemDetailVC, animated: true)
    }
    
    // MARK: - SupplementaryView
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: Resources.Identifiers.categoriesView,
                                                                     for: indexPath) as! CategoriesView
        header.congifure()
        header.selectCategoryHandler = { [weak self] selectedCategory in
            switch selectedCategory {
            case Resources.Strings.Shop.Categories.indoor:
                self?.isSelectedCategory = true
                self?.updateFilteredItems(categoryName: Resources.Strings.Shop.Categories.indoor)
            case Resources.Strings.Shop.Categories.outdoor:
                self?.isSelectedCategory = true
                self?.updateFilteredItems(categoryName: Resources.Strings.Shop.Categories.outdoor)
            default:
                self?.isSelectedCategory = false
                self?.filteredItems = []
            }
        }
        return header
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
