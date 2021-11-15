//
//  ViewController.swift
//  NotesReplica_c8
//
//  Created by Elisey Ozerov on 26/10/2021.
//

import UIKit

class FoldersViewController: UIViewController {
    var tableView: CustomTableView!
    
    var searchController: UISearchController!
    var resultsController: SearchResultsViewController!
    
    var tableViewDelegate: FoldersTableViewDelegate!
    var tableViewDataSource: FoldersTableViewDataSource!
    
    override func loadView() {
        super.loadView()
        tableViewDelegate = FoldersTableViewDelegate()
        tableViewDataSource = FoldersTableViewDataSource()
        tableViewDelegate.dataSource = tableViewDataSource
        
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotes()
    }
}

// MARK: - Selectors and other methods
extension FoldersViewController {
    // Selectors
    @objc func edit() {
        
    }
    
    @objc func newNote() {
        let vc = EditNoteViewController(note: Note(), otherNotes: tableViewDataSource.notes)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addFolder() {
        
    }
    
    // Other
    func loadNotes() {
        DispatchQueue.global().async {
            let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            guard let jsonData = try? String(contentsOf: docUrl.appendingPathComponent("notes")).data(using: .utf8) else {
                print("No notes have been created just yet")
                return
            }
            guard let notes = try? JSONDecoder().decode([Note].self, from: jsonData) else {
                fatalError("Could not decode data into a Note array")
            }
            DispatchQueue.main.async { [ weak self ] in
                self?.tableViewDataSource.notes = notes
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - Views Setup
private extension FoldersViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        setupTableView()
        setupTitleView()
        setupSearchBarView()
        setupToolbarView()
        revealSearchBar()
    }
    
    func setupTableView() {
        tableView = CustomTableView(frame: view.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewDelegate.tableView = tableView
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    func revealSearchBar() {
        guard let height = navigationItem.searchController?.searchBar.intrinsicContentSize.height else { return }
        tableView.setContentOffset(CGPoint(x: 0, y: -height), animated: false)
    }
    
    func setupTitleView() {
        title = "Folders"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupSearchBarView() {
        resultsController = SearchResultsViewController()
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.isHidden = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.returnKeyType = .done
        navigationItem.searchController = searchController
    }
    
    func setupToolbarView() {
        navigationController?.isToolbarHidden = false
        toolbarItems = [
            UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(addFolder)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(newNote)),
        ]
    }
}

// MARK: - SearchBar delegate methods
extension FoldersViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        searchController.searchResultsController?.view.isHidden = false
    }
    
    func presentSearchController(_ searchController: UISearchController) {
        searchController.showsSearchResultsController = true
    }
}

// this is needed to be able to scroll the tableView if used pressed and dragged the tableview header,
// considering it's a button. if [touchesShouldCancel] returns false, it doesn't work.
class CustomTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        true
    }
}
