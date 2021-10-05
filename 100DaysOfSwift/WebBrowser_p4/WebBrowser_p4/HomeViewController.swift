//
//  HomeViewController.swift
//  WebBrowser_p4
//
//  Created by Elisey Ozerov on 05/10/2021.
//

import Foundation
import UIKit

class HomeViewController: UITableViewController {
    
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "webview") as? WebViewController {
            vc.website = websites[indexPath.row]
            vc.websites = websites
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
