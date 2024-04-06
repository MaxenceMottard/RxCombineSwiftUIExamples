//
//  ClubsListCell.swift
//  ImplementSwiftUIInUIKitArchi
//
//  Created by Maxence Mottard on 05/04/2024.
//

import UIKit

class ClubsListCell: UITableViewCell {
    static let identifier = "ClubsListCell"

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: bounds)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = UIColor(named: "PrimaryTextColor")
        label.font = .systemFont(ofSize: 16, weight: .regular)

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 6
        label.textColor = UIColor(named: "SecondaryTextColor")
        label.font = .systemFont(ofSize: 12, weight: .light)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])

        stackView.addArrangedSubview(nameLabel)
    }

    func setup(with club: Club?) {
        guard let club else { return }

        nameLabel.text = club.name

        if let description = club.description {
            stackView.addArrangedSubview(descriptionLabel)
            descriptionLabel.text = description
        }
    }
}
