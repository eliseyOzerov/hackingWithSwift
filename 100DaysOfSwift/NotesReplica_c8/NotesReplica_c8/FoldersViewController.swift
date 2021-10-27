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
    
    override func loadView() {
        super.loadView()
        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
        cell.contentConfiguration = configuration
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

//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        if !scrollView.frame.isEmpty {
//            navigationItem.hidesSearchBarWhenScrolling = true
//        }
//    }
    
}

extension FoldersViewController: UITableViewDelegate, UITableViewDataSource {
    func setupViews() {
        setupTableView()
        setupNavigationView()
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
    
    func setupNavigationView() {
        title = "Folders"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(edit))
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.isHidden = false
        navigationController?.isToolbarHidden = false
        toolbarItems = [
            UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(addFolder)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(newNote)),
        ]
        
        // scroll the tableview for the height of the search bar so as to reveal it
        guard let height = navigationItem.searchController?.searchBar.intrinsicContentSize.height else { return }
        tableView.setContentOffset(CGPoint(x: 0, y: -height), animated: false)
    }
}


class CustomHeaderView: UITableViewHeaderFooterView {
    var button = UIButton()
    var label = UILabel()
    var chevron = UIImageView()
    var open = true
    
    @objc func onTap(sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, options: []) { [weak self] in
            if let self = self {
                if self.open {
                    self.chevron.transform = CGAffineTransform(rotationAngle: -90.degreesToRadians)
                } else {
                    self.chevron.transform = CGAffineTransform.identity
                }
            }
        } completion: { [weak self] _ in
            self?.open.toggle()
        }
        
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomHeaderView {
    func setupViews() {
        setupButtonView()
        setupLabelView()
        setupChevronView()
    }
    
    func setupButtonView() {
        addSubview(button)
        button.backgroundColor = .systemGroupedBackground
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    func setupLabelView() {
        button.addSubview(label)
        label.text = "iCloud"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
    }
    
    func setupChevronView() {
        button.addSubview(chevron)
        chevron.image = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold))
        chevron.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chevron.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -20),
            chevron.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
    }
}
