//
//  HabitDetailTableViewCell.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 09.04.2022.
//

import UIKit

class HabitDetailTableViewCell: UITableViewCell {

    lazy var labelDay: UILabel = {
        let day = UILabel()
        day.font = .systemFont(ofSize: 17, weight: .regular)
        return day
    }()

    lazy var imageChecker: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "checkmark")
        image.tintColor = ColorSet.colorPurple
        return image
    }()

    private func setupConstraintsCell() {
        contentView.addSubViews(view: labelDay, imageChecker)

        NSLayoutConstraint.activate([

            labelDay.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topMarginTV),
            labelDay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottomMarginTV),
            labelDay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),

            imageChecker.centerXAnchor.constraint(equalTo: labelDay.centerXAnchor),
            imageChecker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMarginChecker)

        ])
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraintsCell()
    }
}
