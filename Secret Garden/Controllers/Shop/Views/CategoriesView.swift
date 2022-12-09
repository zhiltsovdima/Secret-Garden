//
//  CategoriesView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.11.2022.
//

import UIKit

final class CategoriesView: UICollectionReusableView {
    
    private var categories = [Resources.Strings.Shop.Categories.all,
                              Resources.Strings.Shop.Categories.indoor,
                              Resources.Strings.Shop.Categories.outdoor,
                              Resources.Strings.Shop.Categories.fertilizer,
                              "test",
                              "test",
                              "test",
                              "test"]
    private let flowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
    
    var selectedCategoryHandler: ((String) -> Void)?
    
        
    func congifure() {
        setDelegates()
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
        
        cell.setCategory(categories[indexPath.item])
        
        if indexPath.item == 0 {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            cell.isSelected = true
        } else {
            cell.isSelected = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCategoryName = categories[indexPath.item]
        selectedCategoryHandler?(selectedCategoryName)
    }

}

extension CategoriesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: bounds.height - 10)
    }
}
