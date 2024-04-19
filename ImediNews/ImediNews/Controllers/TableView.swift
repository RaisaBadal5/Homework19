//
//  TableView.swift
//  ImediNews
//
//  Created by Default on 19.04.24.
//

import UIKit

class TableView: UITableViewDataSource {
  
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return fruit.count
        } else {
            return numbers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") as? PersonCell
            
            let currentFruit = fruit[indexPath.row]
            
            cell?.updateCell(with: currentFruit, imageName: "person.fill")
            print("row: \(indexPath.row), section: \(indexPath.section) is creating")

            if indexPath.section == 0 {
                cell?.backgroundColor = .green
            } else if indexPath.section == 1 {
                cell?.backgroundColor = .orange
            } else {
                cell?.backgroundColor = .purple
            }
            
            return cell ?? UITableViewCell()
        } else {
            let cell = UITableViewCell()
            let currentNumber = numbers[indexPath.row]

            cell.textLabel?.text = "\(currentNumber)"
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "ABC") { _, _,_  in
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


}
