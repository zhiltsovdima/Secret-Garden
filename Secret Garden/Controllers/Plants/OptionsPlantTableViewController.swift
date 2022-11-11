//
//  PlantOptionsTableViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 05.11.2022.
//

import UIKit

final class OptionsPlantTableViewController: UITableViewController {
    
    private let options = [
        Resources.Strings.Options.edit,
        Resources.Strings.Options.delete
    ]
    
    var editPlantCompletionHandler: (() -> Void)?
    var deletePlantCompletionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Resources.Cells.plantOptionsCell)
        tableView.isScrollEnabled = false
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 150.0, height: tableView.contentSize.height)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Cells.plantOptionsCell, for: indexPath)
        
        let optionName = options[indexPath.row]
        cell.textLabel?.text = optionName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            dismiss(animated: true) {
                self.editPlantCompletionHandler?()
            }
        case 1:
            deletePlantCompletionHandler?()
            dismiss(animated: true)
        default:
            dismiss(animated: true)
        }
    }
}
