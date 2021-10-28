//
//  TableViewHeader.swift
//  NotesReplica_c8
//
//  Created by Elisey Ozerov on 28/10/2021.
//

import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {
    var button = UIButton()
    var label = UILabel()
    var chevron = UIImageView()
    var open = true
    
    @objc func onTap(sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: []) { [weak self] in
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
