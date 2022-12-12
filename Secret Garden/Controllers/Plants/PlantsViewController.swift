//
//  PlantsViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

final class PlantsViewController: BaseViewController {
    
    private let tableView = UITableView()
    
    private let garden = Garden()
    
    private let placeholder = UIImageView(image: Resources.Images.Common.emptyCollection)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppearence()
        setDelegates()
        addNavBarButton()
        configureTableView()
        configurePlaceholder()
    }
    
    private func setAppearence() {
        title = Resources.Strings.TabBar.garden
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
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
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
        APIManager.shared.delegate = self
    }
}

// MARK: - Placeholder Configuration

extension PlantsViewController {
    
    private func isItEmpty() {
        if garden.isItEmpty {
            tableView.isHidden = true
            placeholder.isHidden = false
        } else {
            tableView.isHidden = false
            placeholder.isHidden = true
        }
    }
    
    private func configurePlaceholder() {
        view.addSubview(placeholder)
        placeholder.isHidden = true
        placeholder.contentMode = .scaleAspectFit
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholder.topAnchor.constraint(equalTo: view.topAnchor),
            placeholder.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            placeholder.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            placeholder.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - NavBar Button

extension PlantsViewController {
    
    private func addNavBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navBarRightButtonHandler))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func navBarRightButtonHandler() {
        let addPlantController = AddPlantController()
        addPlantController.completionHandler = { [weak self] addedPlant in
            DispatchQueue.main.async {
                self?.garden.addNewPlant(addedPlant)
                self?.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                self?.isItEmpty()
            }
            self?.fetchData(for: addedPlant, index: 0)
        }
        navigationController?.pushViewController(addPlantController, animated: true)
    }
}

// MARK: - Fetching Data

extension PlantsViewController: APIManagerDelegate {
    
    private func fetchData(for plant: Plant, index: Int) {
        APIManager.shared.performRequest(namePlant: plant.name, index: index)
    }
    
    func didUpdate(with characteristics: PlantCharacteristics, index: Int) {
        DispatchQueue.main.async {
            self.garden.plants[index].characteristics = characteristics
            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
}

// MARK: - UITableViewDelegate
extension PlantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isItEmpty()
        return garden.plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.plantCell, for: indexPath)
        
        if let plantCell = cell as? PlantCell {
            let plant = garden.plants[indexPath.row]
            plantCell.set(plant: plant)
            plantCell.buttonCompletionHandler = { [weak self, unowned plantCell] in
                let optionsVC = OptionsPlantTableViewController()
                optionsVC.modalPresentationStyle = .popover
                let popoverVC = optionsVC.popoverPresentationController
                popoverVC?.delegate = self
                popoverVC?.sourceView = plantCell.settingsButton
                popoverVC?.sourceRect = CGRect(x: plantCell.settingsButton.bounds.minX - 70,
                                               y: plantCell.settingsButton.bounds.midY + 7,
                                               width: 0,
                                               height: 0
                )
                popoverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)

                optionsVC.preferredContentSize.width = self!.view.bounds.width / 3.0
                
                optionsVC.actualCell = plantCell
                optionsVC.editPlantCompletionHandler = { actualCell in
                    let actualIndexPath = self?.tableView.indexPath(for: actualCell!)
                    let editVC = EditPlantViewController(plant, actualIndexPath!)
                    editVC.saveEditedPlantHandler = { editedPlant, actualIndexPath in
                        DispatchQueue.main.async {
                            self?.garden.plants[actualIndexPath.row] = editedPlant
                            self?.tableView.reloadRows(at: [actualIndexPath], with: .automatic)
                        }
                    }
                    self?.present(editVC, animated: true)
                }
                optionsVC.deletePlantCompletionHandler = { actualCell in
                    let actualIndexPath = self?.tableView.indexPath(for: actualCell!)
                    DispatchQueue.main.async {
                        self?.garden.removePlant(at: actualIndexPath!.row)
                        self?.tableView.deleteRows(at: [actualIndexPath!], with: .automatic)
                        self?.isItEmpty()
                    }
                }
                self?.present(optionsVC, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let plant = garden.plants[indexPath.row]
        
        let detailVC = DetailPlantController(plant)
        
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
