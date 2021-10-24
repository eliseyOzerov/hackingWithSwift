//
//  CityDetailsViewController.swift
//  CapitalCities_p16
//
//  Created by Elisey Ozerov on 24/10/2021.
//

import UIKit
import WebKit

class CapitalDetailsViewController: UIViewController {
    let webview = WKWebView()
    var capital: Capital!
    
    override func viewDidLoad() {
        setupViews()
        view.backgroundColor = .systemBackground
        if let url = URL(string: "https://en.wikipedia.org/wiki/\(capital.title!.capitalized)") {
            webview.load(URLRequest(url: url))
        }
    }
}

extension CapitalDetailsViewController {
    func setupViews() {
        view.addSubview(webview)
        webview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
