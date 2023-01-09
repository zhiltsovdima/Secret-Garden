//
//  DetailBaseController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.11.2022.
//

import UIKit

class DetailBaseController: UIViewController{
    
    let plantImageView = UIImageView()
    
    let detailInfoView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = Resources.Colors.backgroundColor
        view.addSubview(plantImageView)
        plantImageView.contentMode = .scaleAspectFill
        plantImageView.backgroundColor = .yellow
        
        view.addSubview(detailInfoView)
        detailInfoView.backgroundColor = Resources.Colors.backgroundColor
        detailInfoView.layer.cornerRadius = 20
    }
    
    func setConstraints() {
        plantImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plantImageView.topAnchor.constraint(equalTo: view.topAnchor),
            plantImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            plantImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            plantImageView.heightAnchor.constraint(equalToConstant: (view.bounds.height / 3) + 20)
        ])
        
        detailInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailInfoView.heightAnchor.constraint(equalToConstant: view.bounds.height * 2/3),
            detailInfoView.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailInfoView.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}
