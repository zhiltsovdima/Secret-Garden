//
//  CartViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 22.11.2022.
//

import UIKit

final class CartViewController: BaseViewController {
    
    private let shop: Shop
    
    private var cart: [ShopItem] {
        return shop.items.filter { $0.isAddedToCart }
    }
    
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
    
    private let emptyCartImage = UIImageView()
    private let emptyCartLabel = UILabel()
    private let emptyCartButton = BaseButton()
    
    private var totalSubPrice: Double {
        var price = 0.0
        cart.forEach { item in
            let wordForRemove = "$"
            var priceStr = item.price
            if let range = priceStr?.range(of: wordForRemove) {
                priceStr?.removeSubrange(range)
            }
            price += Double(priceStr ?? "0.0")!
        }
        return price
    }
    
    private var totalPrice: Double {
        totalSubPrice + 10.0
    }
    
    var updateDetailVCHandler: ((Int) -> Void)?
    
    init(_ shop: Shop) {
        self.shop = shop
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppearance()
        addViews()
        configureTableView()
        configureViews()
        setConstraints()
        checkingCartEmpty()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        totalPriceView.addUpperBorder(with: .lightGray, height: 1.0)
    }
    
    private func updateUI(_ indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .fade)
        checkingCartEmpty()
    }
    
    private func checkingCartEmpty() {
        if cart.isEmpty {
            tableView.isHidden = true
            checkoutStack.isHidden = true
            
            emptyCartImage.isHidden = false
            emptyCartLabel.isHidden = false
            emptyCartButton.isHidden = false
        } else {
            tableView.isHidden = false
            checkoutStack.isHidden = false
            
            emptyCartImage.isHidden = true
            emptyCartLabel.isHidden = true
            emptyCartButton.isHidden = true
            
            subTotalValue.text = "$\(totalSubPrice)"
            totalValue.text = "$\(totalPrice)"
        }
    }
    
    @objc private func emptyCartButtonAction() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Views Settings

extension CartViewController {
    
    private func setAppearance() {
        title = "My Cart"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureTableView() {
        setTableViewDelegates()
        tableView.backgroundColor = Resources.Colors.backgroundColor
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.register(CartCell.self, forCellReuseIdentifier: Resources.Identifiers.cartCell)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addViews() {
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
        
        view.addSubview(emptyCartImage)
        view.addSubview(emptyCartLabel)
        view.addSubview(emptyCartButton)
    }
    
    private func configureViews() {
        emptyCartImage.image = Resources.Images.Common.shopPlant
        emptyCartImage.contentMode = .scaleAspectFit
        emptyCartLabel.text = Resources.Strings.Shop.emptyLabel
        emptyCartLabel.font = Resources.Fonts.generalBold
        emptyCartLabel.textAlignment = .center
        
        emptyCartButton.setTitle(Resources.Strings.Shop.emptyButton, for: .normal)
        emptyCartButton.addTarget(self, action: #selector(emptyCartButtonAction), for: .touchUpInside)
        
        checkoutStack.axis = .vertical
        checkoutStack.distribution = .fill
        
        subTotalLabel.text = Resources.Strings.Shop.subTotal
        subTotalLabel.font = Resources.Fonts.general
        subTotalValue.text = "$\(totalSubPrice)"
        subTotalValue.font = Resources.Fonts.generalBold
        subTotalValue.textAlignment = .right
        shippingLabel.text = Resources.Strings.Shop.shipping
        shippingLabel.font = Resources.Fonts.general
        shippingValue.text = "$10.0"
        shippingValue.font = Resources.Fonts.generalBold
        shippingValue.textAlignment = .right
        
        totalLabel.text = Resources.Strings.Shop.total
        totalLabel.font = Resources.Fonts.general
        totalValue.text = "$\(totalPrice)"
        totalValue.font = Resources.Fonts.generalBold
        totalValue.textAlignment = .right

        checkoutButton.setTitle(Resources.Strings.Shop.checkout, for: .normal)
    }
    
    private func setConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        checkoutStack.translatesAutoresizingMaskIntoConstraints = false

        subTotalLabel.translatesAutoresizingMaskIntoConstraints = false
        subTotalValue.translatesAutoresizingMaskIntoConstraints = false
        shippingLabel.translatesAutoresizingMaskIntoConstraints = false
        shippingValue.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalValue.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        emptyCartImage.translatesAutoresizingMaskIntoConstraints = false
        emptyCartLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyCartButton.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
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

            checkoutButton.heightAnchor.constraint(equalToConstant: 60),
            
            emptyCartImage.bottomAnchor.constraint(equalTo: emptyCartLabel.topAnchor),
            emptyCartImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            emptyCartImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            emptyCartImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            emptyCartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyCartButton.topAnchor.constraint(equalTo: emptyCartLabel.bottomAnchor, constant: 20),
            emptyCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptyCartButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

// MARK: - UITableView Delegate

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.cartCell, for: indexPath) as! CartCell
        let shopItem = cart[indexPath.row]
        let shopItemId = shopItem.id!
        cell.setCart(shopItem)
        cell.removeFromCartCompletion = { [weak self] cellForRemove in
            let actualIndexPath = self?.tableView.indexPath(for: cellForRemove)
            DispatchQueue.main.async {
                self?.shop.makeAddedToCart(withId: shopItemId)
                self?.updateUI(actualIndexPath!)
                self?.updateDetailVCHandler?(shopItemId)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopItem = cart[indexPath.row]
        let shopItemId = shopItem.id!
        
        let itemDetailVC = ItemDetailController(shopItem)
        itemDetailVC.favoriteCompletion = { [weak self] in
            self?.shop.makeFavoriteItem(withId: shopItemId)
            self?.updateDetailVCHandler?(shopItemId)
        }
        itemDetailVC.goToCartCompletion = { completion in
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(itemDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
