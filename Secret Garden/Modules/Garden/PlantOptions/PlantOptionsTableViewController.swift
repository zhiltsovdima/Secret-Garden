//
//  PlantOptionsTableViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 05.11.2022.
//

import UIKit

final class PlantOptionsTableViewController: UITableViewController {
    
    private let viewModel: PlantOptionsViewModelProtocol
    
    init(viewModel: PlantOptionsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        preferredContentSize.height = tableView.contentSize.height - 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisappear()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Resources.Identifiers.plantOptionsCell)
        tableView.isScrollEnabled = false
        tableView.backgroundColor = Resources.Colors.backgroundFields
    }
}
 
// MARK: - TableView Delegate & DataSource

extension PlantOptionsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.plantOptionsCell, for: indexPath)
        cell.textLabel?.text = viewModel.tableData[indexPath.row]
        cell.backgroundColor = Resources.Colors.backgroundFields
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            viewModel.editButtonTapped()
        case 1:
            viewModel.deleteButtonTapped()
        default:
            break
        }
    }
}
