//
//  HabitDetailsTableViewHeader.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 09.04.2022.
//

import UIKit

class HabitDetailsTableViewHeader: UITableViewHeaderFooterView {

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Активность".uppercased()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()


    private func setupHeader() {
        contentView.addSubViews(view: headerLabel)
        NSLayoutConstraint.activate([

            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topMargin)

        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupHeader()
    }
}
