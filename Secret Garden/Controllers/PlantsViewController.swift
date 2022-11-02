//
//  PlantsViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

final class PlantsViewController: BaseViewController {
    
    var tableView = UITableView()
    
    let plants = [
        Plant(image: UIImage(named: "plant1"), name: "Ficus"),
        Plant(image: UIImage(named: "plant2"), name: "Another one"),
        Plant(image: UIImage(named: "plant3"), name: "One more")
    ]

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
    
    @objc func navBarRightButtonHandler() {
        let addPlantController = AddPlantController()
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
        return plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Cells.plantCell, for: indexPath)
        
        if let plantCell = cell as? PlantCell {
            let plant = plants[indexPath.row]
            plantCell.set(plant: plant)
        }
        return cell
    }
}
