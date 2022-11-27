//
//  CartViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 22.11.2022.
//

import UIKit

final class CartViewController: BaseViewController {
    
    private let shop: Shop
    
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
    
    private var totalSubPrice: Double {
        var price = 0.0
        shop.cart.forEach { item in
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
    
    init(_ shop: Shop) {
        self.shop = shop
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Cart"
        navigationItem.largeTitleDisplayMode = .never
        
        addViews()
        configureTableView()
        configureViews()
        setConstraints()
    }
    
    private func updateUI() {
        guard shop.cart.count != 0 else { checkoutStack.isHidden = true; return }
        subTotalValue.text = "$\(totalSubPrice)"
        totalValue.text = "$\(totalPrice)"
    }
    
    private func configureTableView() {
        setTableViewDelegates()
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
        
    }
    
    private func configureViews() {
        guard shop.cart.count != 0 else { checkoutStack.isHidden = true; return }
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
            
        ])
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shop.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.cartCell, for: indexPath) as! CartCell
        let shopItem = shop.cart[indexPath.row]
        cell.setCart(shopItem)
        cell.deleteCompletion = { [weak self] cellForRemove in
            self?.shop.removeFromCart(withId: shopItem.id!)
            let actualIndexPath = self?.tableView.indexPath(for: cellForRemove)
            DispatchQueue.main.async {
                self?.shop.cart.remove(at: actualIndexPath!.row)
                self?.tableView.deleteRows(at: [actualIndexPath!], with: .fade)
                self?.updateUI()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopItemId = shop.cart[indexPath.row].id
        let shopItem = shop.items[shopItemId!]
        
        let itemDetailVC = ItemDetailController(shopItem)
        itemDetailVC.favoriteCompletion = { [weak self] isFavorite in
            self?.shop.makeFavoriteItem(withId: shopItemId!, isFavorite)
            if isFavorite {
                let item = self?.shop.items[shopItemId!]
                self?.shop.favorites.append(item!)
            } else {
                self?.shop.favorites.remove(at: indexPath.row)
            }
        }
        navigationController?.pushViewController(itemDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
