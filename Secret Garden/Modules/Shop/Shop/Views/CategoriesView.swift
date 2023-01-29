//
//  CategoriesView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.11.2022.
//

import UIKit

enum ShopCategory: String {
    case all = "All"
    case indoor = "Indoor"
    case outdoor = "Outdoor"
    case fertilizer = "Fertilizer"
}

final class CategoriesView: UICollectionReusableView {
    
    private let categories: [ShopCategory] = [
        .all,
        .indoor,
        .outdoor,
        .fertilizer
    ]
    
    private var selectedCategory: ShopCategory = .all
    
    private let flowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
    
    var selectCategoryHandler: ((ShopCategory) -> Void)?
    
        
    func congifure(selectedCategory: ShopCategory) {
        self.selectedCategory = selectedCategory
        setDelegates()
        collectionView.backgroundColor = Resources.Colors.backgroundColor
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: Resources.Identifiers.categoryCell)
        
        addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset.right = Resources.Constants.shopVC.itemsSpacing
        flowLayout.sectionInset.left = Resources.Constants.shopVC.itemsSpacing
        flowLayout.minimumInteritemSpacing = Resources.Constants.shopVC.itemsSpacing
        flowLayout.minimumLineSpacing = Resources.Constants.shopVC.itemsSpacing
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDelegate

extension CategoriesView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.Identifiers.categoryCell, for: indexPath) as! CategoryCell
        
        cell.setCategory(categories[indexPath.item].rawValue)
        
        if categories[indexPath.item] == selectedCategory {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            //cell.isSelected = true
        } else {
            cell.isSelected = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory1 = categories[indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isUserInteractionEnabled = false
//        print("\(selectedCategory.rawValue) select")
        selectCategoryHandler?(selectedCategory1)

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isUserInteractionEnabled = true
//        let selectedCategory = categories[indexPath.item]
//        print("\(selectedCategory.rawValue) deselect")

    }
}

// MARK: - UICollectionView FlowLayout
extension CategoriesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: bounds.height - 10)
    }
}
