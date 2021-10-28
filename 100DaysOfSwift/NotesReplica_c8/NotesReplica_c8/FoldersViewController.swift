//
//  ViewController.swift
//  NotesReplica_c8
//
//  Created by Elisey Ozerov on 26/10/2021.
//

import UIKit

class FoldersViewController: UIViewController {
    var tableView: UITableView!
    var sections = ["iCloud"]
    var collapsedSections = Set<Int>()
    
    let x = 4
    
    var searchController: UISearchController!
    var resultsController: SearchResultsViewController!
    
    override func loadView() {
        super.loadView()
        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Interaction methods
extension FoldersViewController {
    
    func indexPathsForSection(section: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        for row in 0..<x {
            indexPaths.append(IndexPath(row: row, section: section))
        }
        
        return indexPaths
    }

    @objc func edit() {
        
    }
    
    @objc func newNote() {
        
    }
    
    @objc func addFolder() {
        
    }
    
    @objc func hideSection(sender: UIButton) {
        let section = sender.tag
        let paths = indexPathsForSection(section: section)
        
        if !collapsedSections.contains(section) {
            collapsedSections.insert(section)
            tableView.deleteRows(at: paths, with: .top)
        } else {
            collapsedSections.remove(section)
            tableView.insertRows(at: paths, with: .top)
        }
    }
}

// MARK: - Views Setup
extension FoldersViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(edit))
        setupTableView()
        setupTitleView()
        setupSearchBarView()
        setupToolbarView()
        revealSearchBar()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.frame, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
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
        resultsController.tableView.delegate = self
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

// MARK: - TableView delegate methods
extension FoldersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if collapsedSections.contains(section) {
            return 0
        }
        
        return x
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        52
    }
    
    // apparently not using this callback fucks up the whole animation (unless it's .fade or .middle)
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        52
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var configuration = UIListContentConfiguration.cell()
        configuration.text = "Row \(indexPath.row)"
        configuration.image = UIImage(systemName: "folder")
        cell.contentConfiguration = configuration
        cell.accessoryType = .disclosureIndicator
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? CustomHeaderView {
            view.button.frame = CGRect(x: 20, y: 0, width: tableView.contentSize.width - 40, height: 52)
            view.button.tag = section
            view.button.addTarget(self, action: #selector(hideSection), for: .touchUpInside)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CustomHeaderView
    }
}
