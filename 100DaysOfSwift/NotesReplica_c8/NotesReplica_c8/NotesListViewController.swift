//
//  NotesListViewController.swift
//  NotesReplica_c8
//
//  Created by Elisey Ozerov on 15/11/2021.
//

import UIKit

class NotesListViewController: UIViewController {
    var tableView: UITableView!
    let emptyView = UILabel()
    var notes = [Note]() {
        didSet {
            setupFooter()
            emptyView.isHidden = !notes.isEmpty
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
    }

}

// MARK: - Setup views
extension NotesListViewController {
    func setupViews() {
        setupHeader()
        setupTableView()
        setupFooter()
        setupEmptyView()
    }
    
    func setupHeader() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(moreMenu))
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
        tableView.dataSource = self
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
        navigationController?.isToolbarHidden = false
        let opacity = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: nil)
        opacity.tintColor = .black.withAlphaComponent(0)
        let text = UIBarButtonItem(title: "\(notes.count) Notes", style: .plain, target: self, action: nil)
        text.setTitleTextAttributes([.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 12)], for: .normal)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [
            opacity,
            space,
            text,
            space,
            UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(addNote)),
        ]
    }
    
    func setupEmptyView() {
        emptyView.text = "You have no notes yet"
        emptyView.font = UIFont.systemFont(ofSize: 16)
        emptyView.textColor = .gray
        emptyView.isHidden = !notes.isEmpty
        view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Selectors and other methods
extension NotesListViewController {
    @objc func moreMenu() {
        
    }
    
    @objc func addNote() {
        let vc = EditNoteViewController(note: Note(), otherNotes: notes, vc: self)
        navigationController?.pushViewController(vc, animated: true)
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
        cell.contentConfiguration = config
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        var otherNotes = notes
        notes.remove(at: indexPath.row)
        let vc = EditNoteViewController(note: otherNotes[indexPath.row], otherNotes: otherNotes, vc: self)
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        false
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, _ in
            self?.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
            let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = docUrl.appendingPathComponent("notes")
            if let jsonData = try? JSONEncoder().encode(self?.notes) {
                do {
                    try jsonData.write(to: url)
                } catch {
                    fatalError("Failed to save data to url [\(url)]. Error: \(error)")
                }
            }
            
        }
        return UISwipeActionsConfiguration(actions: [delete])
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

// MARK: - Data loading
extension NotesListViewController {
    func loadData() {
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = docUrl.appendingPathComponent("notes")
        if let jsonData = try? String(contentsOf: url).data(using: .utf8) {
            if let data = try? JSONDecoder().decode([Note].self, from: jsonData) {
                notes = data
                emptyView.isHidden = !notes.isEmpty
                tableView.reloadData()
            }
        }
    }
}
