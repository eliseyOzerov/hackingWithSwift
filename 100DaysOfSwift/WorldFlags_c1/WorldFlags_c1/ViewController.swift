//
//  ViewController.swift
//  WorldFlags_c1
//
//  Created by Elisey Ozerov on 01/10/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Flags"
        let path = Bundle.main.resourcePath!
        let contents = try! FileManager.default.contentsOfDirectory(atPath: path)
        flags = contents.filter { $0.contains("png")}
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Details") as? DetailsViewController {
            vc.imagePath = flags[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

