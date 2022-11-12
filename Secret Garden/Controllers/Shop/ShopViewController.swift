//
//  ShopViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

final class ShopViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Resources.Strings.TabBar.shop
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionView()
        
    }
    
    private func configureCollectionView() {
        
        setDelegates()
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: Resources.Cells.itemCell)
        
        view.addSubview(collectionView)
        flowLayout.scrollDirection = .vertical
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

// MARK: - UICollectionViewDelegate

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.Cells.itemCell, for: indexPath)
        
        cell.contentView.backgroundColor = .systemPink
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShopViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (boundsCollectionWidth - gapItems - gapSection) / Resources.Constants.shopVC.columnCount
        return CGSize(width: width, height: width / Resources.Constants.shopVC.aspectRatio)
    }
}
