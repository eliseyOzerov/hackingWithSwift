//
//  SearchResultsViewController.swift
//  NotesReplica_c8
//
//  Created by Elisey Ozerov on 28/10/2021.
//

import UIKit

class SearchResultsViewController: UIViewController {
    var tableView = UITableView()
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
        setupLabelView()
        setupTableView()
    }
    
    func setupLabelView() {
        view.addSubview(labelView)
        labelView.text = "Suggested"
        labelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: view.topAnchor),
            labelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: labelView.bottomAnchor),
        ])
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = UIListContentConfiguration.cell()
        let content = cells[indexPath.row]
        configuration.text = content.keys.first
        if let imageString = content.values.first {
            configuration.image = UIImage(systemName: imageString)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
}
