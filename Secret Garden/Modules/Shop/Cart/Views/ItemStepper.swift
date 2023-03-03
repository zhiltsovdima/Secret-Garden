//
//  ItemStepper.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 28.02.2023.
//

import UIKit

class ItemStepper: UIControl {
    
    struct ViewData {
      let minimum: Int
      let maximum: Int
      let stepValue: Int
    }
    
    lazy private var plusButton = createStepperButton(title: "+", value: 1)
    lazy private var minusButton = createStepperButton(title: "-", value: -1)
    lazy private var counterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Resources.Colors.blackOnWhite
        label.font = Resources.Fonts.generalBold
        return label
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private(set) var value = 1
    private let viewData: ViewData
    
    init(viewData: ViewData) {
        self.viewData = viewData
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        plusButton.layer.cornerRadius = 0.2 * bounds.height
        minusButton.layer.cornerRadius = 0.2 * bounds.height
    }
    
    func setup(value: Int) {
        self.value = value
        counterLabel.text = String(value)
        backgroundColor = Resources.Colors.backgroundColor
        addSubview(stackView)
        
        [minusButton, counterLabel, plusButton].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func updateValue(_ stepValue: Int) {
        guard (viewData.minimum...viewData.maximum) ~= (value + stepValue) else { return }
        value += stepValue
        counterLabel.text = String(value)
        sendActions(for: .valueChanged)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        updateValue(sender.tag * viewData.stepValue)
    }
    
    private func createStepperButton(title: String, value: Int) -> UIButton {
        let button = UIButton()
        button.backgroundColor = Resources.Colors.backgroundColor
        button.tintColor = Resources.Colors.blackOnWhite
        button.setTitleColor(Resources.Colors.blackOnWhite, for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = Resources.Fonts.generalBold
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.tag = value
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.makeSystemAnimation()
        return button
    }
}
