//
//  ViewController.swift
//  WorldFlags_c1
//
//  Created by Elisey Ozerov on 01/10/2021.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let path = Bundle.main.resourcePath!
        let flags = try! FileManager.default.contentsOfDirectory(atPath: path)
        print(flags)
    }
}

