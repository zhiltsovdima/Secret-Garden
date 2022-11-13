//
//  CategoriesView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.11.2022.
//

import UIKit

final class CategoriesView: UICollectionReusableView {
    
    private var categories = ["All", "Outdoors", "Indoors", "test", "test", "test", "test", "test"]
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
    
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
        return cell
    }
}

extension CategoriesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: bounds.height - 10)
    }
}
