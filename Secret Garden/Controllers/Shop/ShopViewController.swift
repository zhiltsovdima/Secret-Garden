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
        updateUI()
        
    }
    
    private func updateUI() {
        shop.updateCompletion = { index in
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
        }
    }
    
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
        
        if !isSelectedCategory {
            return shop.items.count
        } else {
            return filteredItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.Identifiers.itemCell, for: indexPath) as! ItemCell
        
        let shopItem = !isSelectedCategory ? shop.items[indexPath.item] : filteredItems[indexPath.item]
        let shopItemId = shopItem.id!
        cell.setItem(shopItem)
        
        cell.favoriteCompletion = { [weak self] isFavorite in
            self?.shop.makeFavoriteItem(withId: shopItemId, isFavorite)
            let changedItem = self?.shop.items[shopItemId]
            if isFavorite {
                self?.shop.favorites.insert(changedItem!, at: 0)
            } else {
                self?.shop.favorites.removeAll { item in
                    item.id == changedItem!.id
                }
            }
        }
        cell.cartCompletion = { [weak self] in
            self?.shop.items[shopItemId].isAddedToCart = true
            let newItem = self?.shop.items[shopItemId]
            self?.shop.cart.insert(newItem!, at: 0)
        }
        cell.goToCartCompletion = {
            let cartVC = CartViewController(self.shop)
            
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shopItem = !isSelectedCategory ? shop.items[indexPath.item] : filteredItems[indexPath.item]
        let shopItemId = shopItem.id!
        
        let itemDetailVC = ItemDetailController(shopItem)
        itemDetailVC.favoriteCompletion = { [weak self] isFavorite in
            self?.shop.makeFavoriteItem(withId: shopItemId, isFavorite)
            let changedItem = self?.shop.items[shopItemId]
            if isFavorite {
                self?.shop.favorites.insert(changedItem!, at: 0)
            } else {
                self?.shop.favorites.removeAll { item in
                    item.id == changedItem!.id
                }
            }
            collectionView.reloadItems(at: [IndexPath(item: shopItemId, section: 0)])
        }
        itemDetailVC.cartCompletion = { [weak self] in
            self?.shop.items[shopItemId].isAddedToCart = true
            let newItem = self?.shop.items[shopItemId]
            self?.shop.cart.insert(newItem!, at: 0)
            collectionView.reloadItems(at: [IndexPath(item: shopItemId, section: 0)])
        }
        itemDetailVC.goToCartCompletion = {
            let cartVC = CartViewController(self.shop)
            collectionView.reloadItems(at: [IndexPath(item: shopItemId, section: 0)])
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
        navigationController?.pushViewController(itemDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: Resources.Identifiers.categoriesView,
                                                                     for: indexPath) as! CategoriesView
        header.congifure()
        header.selectedCategoryHandler = { [weak self] selectedCategory in
            switch selectedCategory {
            case Resources.Strings.Shop.Categories.indoor:
                self?.isSelectedCategory = true
                self?.filteredItems = (self?.shop.items.filter({ item in
                    if item.category?.lowercased() == Resources.Strings.Shop.Categories.indoor.lowercased() {
                        return true
                    } else {
                        return false
                    }
                }))!
            case Resources.Strings.Shop.Categories.outdoor:
                self?.isSelectedCategory = true
                self?.filteredItems = (self?.shop.items.filter({ item in
                    if item.category?.lowercased() == Resources.Strings.Shop.Categories.outdoor.lowercased() {
                        return true
                    } else {
                        return false
                    }
                }))!
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
