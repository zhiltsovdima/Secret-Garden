//
//  GardenViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

// MARK: - GardenViewController

final class GardenViewController: UIViewController {
    
    private let viewModel: GardenViewModelProtocol
    
    let tableView = UITableView()
    private let placeholder = UIImageView(image: Resources.Images.Common.emptyCollection)
    
    init(viewModel: GardenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupNavBarButton()
        updateUI()
        showPlaceholder()
    }
    
    private func updateUI() {
        viewModel.updateTabelData = { [weak self] rowInt in
            guard let rowInt else { self?.tableView.reloadData(); return }
            self?.tableView.reloadRows(at: [IndexPath(row: rowInt, section: 0)], with: .automatic)
        }
        viewModel.insertTabelData = { [weak self] in
            self?.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        viewModel.deleteTabelData = { [weak self] rowInt in
            self?.tableView.deleteRows(at: [IndexPath(row: rowInt, section: 0)], with: .fade)
            self?.showPlaceholder()
        }
    }
    
    private func showPlaceholder() {
        if viewModel.isEmptyTableData {
            tableView.isHidden = true
            placeholder.isHidden = false
        } else {
            tableView.isHidden = false
            placeholder.isHidden = true
        }
    }
    
    private func setupUI() {
        title = Resources.Strings.TabBar.garden
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = Resources.Colors.backgroundColor
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Resources.Colors.backgroundColor
        tableView.rowHeight = 200
        tableView.separatorStyle = .none
        tableView.register(PlantCell.self, forCellReuseIdentifier: Resources.Identifiers.plantCell)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navBarRightButtonAction))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func navBarRightButtonAction() {
        viewModel.addNewPlantTapped()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension GardenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.plantCell, for: indexPath) as? PlantCell else { return UITableViewCell() }
        cell.setup(with: viewModel.tableData[indexPath.row])
        cell.buttonCompletionHandler = { [weak self] in
            self?.viewModel.settingsTapped(cell)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableRowTapped(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
