//
//  PlantsViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

final class PlantsViewController: BaseViewController {
    
    var tableView = UITableView()
    
    let garden = Garden()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Resources.Strings.TabBar.garden
        addNavBarButton()
        
        configureTableView()
        
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 200
        tableView.separatorStyle = .none
        tableView.register(PlantCell.self, forCellReuseIdentifier: Resources.Cells.plantCell)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func navBarRightButtonHandler() {
        let addPlantController = AddPlantController()
        addPlantController.completionHandler = { [weak self] addedPlant in
            self?.tableView.performBatchUpdates ({
                DispatchQueue.main.async {
                    self?.garden.plants.insert(addedPlant, at: 0)
                    self?.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                }
            }) { (result) in
                self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
        navigationController?.pushViewController(addPlantController, animated: true)
    }
}

extension PlantsViewController {
    func addNavBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navBarRightButtonHandler))
        navigationItem.rightBarButtonItem = button
    }
}

// MARK: - UITableViewDelegate
extension PlantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return garden.plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Cells.plantCell, for: indexPath)
        
        if let plantCell = cell as? PlantCell {
            let plant = garden.plants[indexPath.row]
            plantCell.set(plant: plant)
            plantCell.buttonCompletionHandler = { [weak self] in
                let optionsPopVC = PlantOptionsTableViewController()
                optionsPopVC.modalPresentationStyle = .popover
                let popoverVC = optionsPopVC.popoverPresentationController
                popoverVC?.delegate = self
                popoverVC?.sourceView = plantCell.settingsButton
                popoverVC?.sourceRect = CGRect(x: Int(plantCell.settingsButton.bounds.minX),
                                               y: Int(plantCell.settingsButton.bounds.midY),
                                               width: 0,
                                               height: 0
                )
                optionsPopVC.deletePlantCompletionHandler = { [weak self] in
                    self?.tableView.performBatchUpdates {
                        DispatchQueue.main.async {
                            self?.garden.removePlant(at: indexPath.row)
                            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                        }
                    }
                }
                self?.present(optionsPopVC, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let plant = garden.plants[indexPath.row]
        let detailVC = DetailPlantController(of: plant)
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension PlantsViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
