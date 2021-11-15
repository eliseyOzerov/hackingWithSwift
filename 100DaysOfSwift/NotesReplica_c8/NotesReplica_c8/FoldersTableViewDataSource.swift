//
//  FoldersTableViewDataSource.swift
//  NotesReplica_c8
//
//  Created by Elisey Ozerov on 30/10/2021.
//

import Foundation
import UIKit

class FoldersTableViewDataSource: NSObject, UITableViewDataSource {
    var notes = [Note]()
    var folders: [String] {
        notes.map { $0.folder }
    }
    
    var collapsedSections = Set<Int>()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if collapsedSections.contains(section) {
            return 0
        }
        
        return folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = UIListContentConfiguration.cell()
        configuration.text = folders[indexPath.row]
        configuration.image = UIImage(systemName: "folder")
        cell.contentConfiguration = configuration
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}
