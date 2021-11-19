////
////  FoldersTableViewDelegate.swift
////  NotesReplica_c8
////
////  Created by Elisey Ozerov on 30/10/2021.
////
//
//import Foundation
//import UIKit
//
//class FoldersTableViewDelegate: NSObject, UITableViewDelegate {
//    var tableView: UITableView!
//    var dataSource: FoldersTableViewDataSource!
//    
//    // MARK: - Interaction
//    
//    @objc func toggleSectionExpanded(sender: UIButton) {
//        let section = sender.tag
//        var paths = [IndexPath]()
//        
//        for row in 0..<dataSource.folders[section].count {
//            paths.append(IndexPath(row: row, section: section))
//        }
//        
//        if !dataSource.collapsedSections.contains(section) {
//            dataSource.collapsedSections.insert(section)
//            tableView.deleteRows(at: paths, with: .top)
//        } else {
//            dataSource.collapsedSections.remove(section)
//            tableView.insertRows(at: paths, with: .top)
//        }
//    }
//    
//    // MARK: - Header methods
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        52
//    }
//    
//    // apparently not using this callback fucks up the whole animation (unless it's .fade or .middle)
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        52
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CustomHeaderView else { return nil }
//        header.button.frame = CGRect(x: 20, y: 0, width: tableView.contentSize.width - 40, height: 52)
//        header.button.tag = section
//        header.label.text = "iCloud"
//        header.button.addTarget(self, action: #selector(toggleSectionExpanded), for: .touchUpInside)
//        return header
//    }
//    
//    // MARK: - Footer methods
//    
//    // without this, .top insert and delete animation for cells flickers inside footer
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .systemGroupedBackground
//        return view
//    }
//}
