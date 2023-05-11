//
//  DetailBaseController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.11.2022.
//

import UIKit

class DetailBaseController: UIViewController{
    
    let plantImageView = UIImageView()
    let detailView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = Resources.Colors.backgroundColor
        view.addSubview(plantImageView)
        plantImageView.contentMode = .scaleAspectFill
        
        view.addSubview(detailView)
        detailView.backgroundColor = Resources.Colors.backgroundColor
        detailView.layer.cornerRadius = 20
    }
    
    func setupConstraints() {
        plantImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plantImageView.topAnchor.constraint(equalTo: view.topAnchor),
            plantImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            plantImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            plantImageView.heightAnchor.constraint(equalToConstant: (view.bounds.height / 3) + 20)
        ])
        
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.heightAnchor.constraint(equalToConstant: view.bounds.height * 2/3),
            detailView.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    func createLabel(text: String?, textColor: UIColor?, font: UIFont?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = font
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        detailView.addSubview(label)
        return label
    }
    func createButton(isBase: Bool, title: String, selector: Selector) -> UIButton {
        guard isBase else { return createNormalButton(title: title, selector: selector) }
        let button = BaseButton()
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        detailView.addSubview(button)
        return button
    }
    private func createNormalButton(title: String, selector: Selector) -> UIButton {
        let button = UIButton()
        button.backgroundColor = Resources.Colors.backgroundFields
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(Resources.Colors.blackOnWhite, for: .normal)
        button.titleLabel?.font = Font.general
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.makeSystemAnimation()
        detailView.addSubview(button)
        return button
    }
    func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.textColor = Resources.Colors.blackOnWhite
        textField.font = Font.general
        textField.backgroundColor = Resources.Colors.backgroundFields
        textField.placeholder = placeholder
        textField.adjustsFontSizeToFitWidth = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        detailView.addSubview(textField)
        return textField
    }
}
