//
//  ViewController.swift
//  ShoppingList_c2
//
//  Created by Elisey Ozerov on 07/10/2021.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping list"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearList))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItem", for: indexPath)
        cell.textLabel?.text = shoppingItems[indexPath.row]
        return cell
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Enter the item name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            if let text = ac.textFields?[0].text {
                self?.shoppingItems.insert(text, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        })
        present(ac, animated: true)
    }
    
    @objc func clearList() {
        shoppingItems = []
        tableView.reloadData()
    }


}

