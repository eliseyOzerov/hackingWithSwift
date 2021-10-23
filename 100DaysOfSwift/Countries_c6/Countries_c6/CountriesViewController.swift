//
//  ViewController.swift
//  Countries_c6
//
//  Created by Elisey Ozerov on 22/10/2021.
//

import UIKit

struct Country: Codable {
    let name: String!
    let capital: String!
    let size: Double!
    let population: Int!
    let currency: String!
}

class CountriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var countries = [Country]()
    var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            if let countriesURL = Bundle.main.url(forResource: "Countries", withExtension: "json") {
                if let countriesData = try? String(contentsOf: countriesURL).data(using: .utf8) {
                    do {
                        let countries = try JSONDecoder().decode([Country].self, from: countriesData)
                        DispatchQueue.main.async { [weak self] in
                            self?.countries = countries
                            self?.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CountryDetailsViewController()
        vc.country = countries[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

