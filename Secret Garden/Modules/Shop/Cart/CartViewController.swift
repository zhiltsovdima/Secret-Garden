//
//  CartViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 22.11.2022.
//

import UIKit

final class CartViewController: UIViewController {
    
    private let viewModel: CartViewModelProtocol

    private let tableView = UITableView()
    
    private let checkoutStack = UIStackView()
    private let upperView = UIView()
    private let subTotalLabel = UILabel()
    private let subTotalValue = UILabel()
    private let shippingLabel = UILabel()
    private let shippingValue = UILabel()
    
    private let totalPriceView = UIView()
    private let totalLabel = UILabel()
    private let totalValue = UILabel()
    private let checkoutButton = BaseButton()
    
    private let placeholderView = PlaceholderView()
    
    var updateDetailVCHandler: ((Int) -> Void)?
    
    init(viewModel: CartViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        setupAppearance()
        setupViews()
        configureViews()
        setupTableView()
        setupConstraints()
        showPlaceholder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        totalPriceView.addUpperBorder(with: .lightGray, height: 1.0)
    }
    
    private func updateUI() {
        viewModel.updateCellCompletion = { [weak self] indexPath in
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
            self?.showPlaceholder()
        }
        viewModel.updatePriceCompletion = { [weak self] in
            self?.showPlaceholder()
        }
    }
    
    private func showPlaceholder() {
        if viewModel.isEmptyTableData {
            tableView.isHidden = true
            checkoutStack.isHidden = true
            placeholderView.isHidden = false
        } else {
            tableView.isHidden = false
            checkoutStack.isHidden = false
            placeholderView.isHidden = true
            
            subTotalValue.text = viewModel.subTotalPrice
            totalValue.text = viewModel.totalPrice
        }
    }
    
    @objc private func emptyCartButtonAction() {
        viewModel.backToShopButtonTapped()
    }
}

// MARK: - Views Settings

extension CartViewController {
    
    private func setupAppearance() {
        title = "My Cart"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = Resources.Colors.backgroundColor
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = Resources.Colors.backgroundColor
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.register(CartCell.self, forCellReuseIdentifier: Resources.Identifiers.cartCell)
    }
    
    private func setupViews() {
        view.addSubview(placeholderView)
        
        view.addSubview(tableView)
        view.addSubview(checkoutStack)
        checkoutStack.addArrangedSubview(upperView)
        checkoutStack.addArrangedSubview(totalPriceView)
        checkoutStack.addArrangedSubview(checkoutButton)
        
        upperView.addSubview(subTotalLabel)
        upperView.addSubview(subTotalValue)
        upperView.addSubview(shippingLabel)
        upperView.addSubview(shippingValue)
        
        totalPriceView.addSubview(totalLabel)
        totalPriceView.addSubview(totalValue)
    }
    
    private func configureViews() {
        placeholderView.placeholderButton.addTarget(self, action: #selector(emptyCartButtonAction), for: .touchUpInside)
        
        checkoutStack.axis = .vertical
        checkoutStack.distribution = .fill
        
        subTotalLabel.text = Resources.Strings.Shop.subTotal
        subTotalLabel.font = Font.general
        subTotalValue.text = viewModel.subTotalPrice
        subTotalValue.font = Font.generalBold
        subTotalValue.textAlignment = .right
        shippingLabel.text = Resources.Strings.Shop.shipping
        shippingLabel.font = Font.general
        shippingValue.text = "$10.0"
        shippingValue.font = Font.generalBold
        shippingValue.textAlignment = .right
        
        totalLabel.text = Resources.Strings.Shop.total
        totalLabel.font = Font.general
        totalValue.text = viewModel.totalPrice
        totalValue.font = Font.generalBold
        totalValue.textAlignment = .right

        checkoutButton.setTitle(Resources.Strings.Shop.checkout, for: .normal)
    }
    
    private func setupConstraints() {
        
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        checkoutStack.translatesAutoresizingMaskIntoConstraints = false

        subTotalLabel.translatesAutoresizingMaskIntoConstraints = false
        subTotalValue.translatesAutoresizingMaskIntoConstraints = false
        shippingLabel.translatesAutoresizingMaskIntoConstraints = false
        shippingValue.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalValue.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            placeholderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            placeholderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            placeholderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: checkoutStack.topAnchor),
            
            checkoutStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            checkoutStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            checkoutStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            subTotalLabel.topAnchor.constraint(equalTo: upperView.topAnchor, constant: 20),
            subTotalLabel.leadingAnchor.constraint(equalTo: upperView.leadingAnchor),
            subTotalLabel.trailingAnchor.constraint(equalTo: subTotalValue.leadingAnchor),
            
            shippingLabel.topAnchor.constraint(equalTo: subTotalLabel.bottomAnchor, constant: 10),
            shippingLabel.leadingAnchor.constraint(equalTo: upperView.leadingAnchor),
            shippingLabel.trailingAnchor.constraint(equalTo: shippingValue.leadingAnchor),
            shippingLabel.bottomAnchor.constraint(equalTo: upperView.bottomAnchor, constant: -20),
            
            subTotalValue.topAnchor.constraint(equalTo: upperView.topAnchor, constant: 20),
            subTotalValue.trailingAnchor.constraint(equalTo: upperView.trailingAnchor),

            shippingValue.topAnchor.constraint(equalTo: subTotalValue.bottomAnchor, constant: 10),
            shippingValue.trailingAnchor.constraint(equalTo: upperView.trailingAnchor),
            shippingValue.bottomAnchor.constraint(equalTo: upperView.bottomAnchor, constant: -20),
            
            totalLabel.topAnchor.constraint(equalTo: totalPriceView.topAnchor, constant: 20),
            totalLabel.leadingAnchor.constraint(equalTo: totalPriceView.leadingAnchor),
            totalLabel.trailingAnchor.constraint(equalTo: totalValue.leadingAnchor),
            totalLabel.bottomAnchor.constraint(equalTo: totalPriceView.bottomAnchor, constant: -20),
            
            totalValue.topAnchor.constraint(equalTo: totalPriceView.topAnchor, constant: 20),
            totalValue.trailingAnchor.constraint(equalTo: totalPriceView.trailingAnchor),
            totalValue.bottomAnchor.constraint(equalTo: totalPriceView.bottomAnchor, constant: -20),

            checkoutButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

// MARK: - UITableView Delegate & DataSource

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.cartCell, for: indexPath) as! CartCell
        let id = viewModel.tableData[indexPath.row].id
        cell.setup(with: viewModel.tableData[indexPath.row])
        cell.removeFromCartCompletion = { [weak self] cellForRemove in
            guard let actualIndexPath = tableView.indexPath(for: cellForRemove) else { return }
            self?.viewModel.removeButtonTapped(id: id, indexPath: actualIndexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableRowTapped(indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
