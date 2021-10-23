//
//  CountryDetailsViewController.swift
//  Countries_c6
//
//  Created by Elisey Ozerov on 23/10/2021.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    let nameLabel = UILabel()
    let capitalLabel = UILabel()
    let sizeLabel = UILabel()
    let populationLabel = UILabel()
    let currencyLabel = UILabel()
    
    var country: Country!
    
    override func loadView() {
        super.loadView()
        title = country.name
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CountryDetailsViewController {
    func setupViews() {
        setupTitleView()
        setupCapitalView()
        setupSizeView()
        setupPopulationView()
        setupCurrencyView()
    }
    
    func setupTitleView() {
        nameLabel.text = country.name
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func setupCapitalView() {
        view.addSubview(capitalLabel)
        capitalLabel.text = country.capital
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            capitalLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            capitalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func setupSizeView() {
        view.addSubview(sizeLabel)
        sizeLabel.text = country.size.description
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sizeLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor, constant: 20),
            sizeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func setupPopulationView() {
        view.addSubview(populationLabel)
        populationLabel.text = country.population.description
        populationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            populationLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 20),
            populationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func setupCurrencyView() {
        view.addSubview(currencyLabel)
        currencyLabel.text = country.currency
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: populationLabel.bottomAnchor, constant: 20),
            currencyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
}
