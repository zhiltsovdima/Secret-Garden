//
//  CategoriesView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.11.2022.
//

import UIKit

final class CategoriesView: UICollectionReusableView {
    
    private let categories: [ShopCategory] = [
        .all,
        .indoor,
        .outdoor,
        .fertilizer
    ]
    
    private lazy var startedCategory = categories[0]
    
    lazy var collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
    private let flowLayout = UICollectionViewFlowLayout()

    var selectCategoryHandler: ((ShopCategory) -> Void)?
    
    func congifure() {
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Resources.Colors.backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: Resources.Identifiers.categoryCell)
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset.right = Resources.Constants.shopVC.itemsSpacing
        flowLayout.sectionInset.left = Resources.Constants.shopVC.itemsSpacing
        flowLayout.minimumInteritemSpacing = Resources.Constants.shopVC.itemsSpacing
        flowLayout.minimumLineSpacing = Resources.Constants.shopVC.itemsSpacing
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
        if categories[indexPath.item] == startedCategory {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            cell.isSelected = true
            selectCategoryHandler?(categories[indexPath.item])
        } else {
            cell.isSelected = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isUserInteractionEnabled = false
        let selectedCategory = categories[indexPath.item]
        selectCategoryHandler?(selectedCategory)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isUserInteractionEnabled = true
    }
}

// MARK: - UICollectionView FlowLayout
extension CategoriesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: bounds.height - 10)
    }
}
