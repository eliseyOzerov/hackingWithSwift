//
//  NotesListViewController.swift
//  NotesReplica_c8
//
//  Created by Elisey Ozerov on 15/11/2021.
//

import UIKit

class NotesListViewController: UIViewController {
    var tableView: UITableView!
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

}

// MARK: - Setup views
extension NotesListViewController {
    func setupViews() {
        setupHeader()
        setupTableView()
        setupFooter()
    }
    
    func setupHeader() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "circle.ellipsis"), style: .plain, target: self, action: #selector(moreMenu))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.delegate = self
        title = "Notes"
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.frame, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupFooter() {
        navigationController?.toolbarItems = [
            UIBarButtonItem(image: UIImage(systemName: "square.and.pencil")?.withTintColor(UIColor.red.withAlphaComponent(0)), style: .plain, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "33 Notes", style: .plain, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(addNote)),
        ]
    }
}

// MARK: - Selectors and other methods
extension NotesListViewController {
    @objc func moreMenu() {
        
    }
    
    @objc func addNote() {
        
    }
}

// MARK: - TableView Delegate & Data source
extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        var config = UIListContentConfiguration.cell()
        let note = notes[indexPath.row]
        config.text = note.text
        config.secondaryText = note.lastChanged.format("dd/MM/yyyy")
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
}

// MARK: - SearchController Delegate
extension NotesListViewController: UISearchControllerDelegate {
    
}

extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: self)
    }
}
