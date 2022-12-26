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
    
    var actualCell: UITableViewCell?
    
    var editPlantCompletionHandler: ((UITableViewCell?) -> Void)?
    var deletePlantCompletionHandler: ((UITableViewCell?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        preferredContentSize.height = tableView.contentSize.height - 1
    }
    
    private func configureView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Resources.Identifiers.plantOptionsCell)
        tableView.isScrollEnabled = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.plantOptionsCell, for: indexPath)
        
        let optionName = options[indexPath.row]
        cell.textLabel?.text = optionName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            dismiss(animated: true) {
                self.editPlantCompletionHandler?(self.actualCell)
            }
        case 1:
            DispatchQueue.main.async {
                self.deletePlantCompletionHandler?(self.actualCell)
            }
            dismiss(animated: true)
        default:
            dismiss(animated: true)
        }
    }
}
