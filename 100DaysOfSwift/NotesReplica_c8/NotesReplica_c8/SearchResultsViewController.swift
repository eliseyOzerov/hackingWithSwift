//
//  SearchResultsViewController.swift
//  NotesReplica_c8
//
//  Created by Elisey Ozerov on 28/10/2021.
//

import UIKit

class SearchResultsViewController: UIViewController {
    var tableView: UITableView!
    var labelView = UILabel()
    
    var cells = [
        ["Shared notes": "person.crop.circle"],
        ["Locked notes": "lock.fill"],
        ["Notes with Checklists": "checklist"],
        ["Notes with Drawings": "pencil.tip.crop.circle"],
        ["Notes with Scanned Documents": "doc.viewfinder"],
        ["Notes with Attachments": "paperclip"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // results view controller is superimposed over the original tableViewController,
        // so it's important to make it opaque
        view.backgroundColor = .systemBackground
        setupViews()
    }
}

// MARK: - View setup
extension SearchResultsViewController {
    func setupViews() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.frame, style: .grouped)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0 // also removes bottom separator for the header for .plain tableView style
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - TableView Delegates
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = UIListContentConfiguration.cell()
        let content = cells[indexPath.row]
        configuration.text = content.keys.first
        if let imageString = content.values.first {
            configuration.image = UIImage(systemName: imageString)
        }
        cell.contentConfiguration = configuration
        let separator = UIView()
        separator.backgroundColor = .separator
        cell.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            separator.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5), // eyeballing the default separator height
            separator.widthAnchor.constraint(equalTo: cell.widthAnchor, constant: -cell.separatorInset.left * 3)
        ])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        52
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        view.addSubview(label)
        label.text = "Suggested"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
}
