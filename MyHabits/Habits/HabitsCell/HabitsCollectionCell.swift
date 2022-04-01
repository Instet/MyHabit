//
//  HabitsCollectionViewHeader.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 21.03.2022.
//

import UIKit

class HabitsCollectionCell: UICollectionViewCell {

    var nameHabit: UILabel = {
        let nameHabit =  UILabel()
        nameHabit.font = .systemFont(ofSize: 17, weight: .semibold)
        nameHabit.numberOfLines = 0
        return nameHabit
    }()

    var intervalHabit: UILabel = {
        let interval = UILabel()
        interval.font = .systemFont(ofSize: 12, weight: .regular)
        interval.textColor = .systemGray2
        return interval
    }()

    var counterHabit: UILabel = {
        let counter = UILabel()
        counter.font = .systemFont(ofSize: 13, weight: .regular)
        counter.textColor = .systemGray
        return counter
    }()

    var progressHabit: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 19
        button.addTarget(self, action: #selector(tapProgressHabit), for: .touchUpInside)
        return button
    }()

    private func setupConstraints() {
        contentView.addSubViews(view: nameHabit, intervalHabit, counterHabit, progressHabit)

        NSLayoutConstraint.activate([

            nameHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            intervalHabit.topAnchor.constraint(equalTo: nameHabit.bottomAnchor, constant: 4),
            intervalHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            progressHabit.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            progressHabit.heightAnchor.constraint(equalToConstant: 38),
            progressHabit.widthAnchor.constraint(equalToConstant: 38),
            progressHabit.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 25),
            progressHabit.leadingAnchor.constraint(equalTo: nameHabit.trailingAnchor, constant: 40),

            counterHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            counterHabit.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)


        ])

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
    }


    @objc func tapProgressHabit() {

    }

}
