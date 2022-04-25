//
//  HabitsCollectionViewHeader.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 21.03.2022.
//

import UIKit

class HabitsCollectionCell: UICollectionViewCell {

    weak var habit: Habit?
    var habitReloadDate: (() -> ())?


    lazy var nameHabit: UILabel = {
        let nameHabit =  UILabel()
        nameHabit.font = .systemFont(ofSize: 17, weight: .semibold)
        nameHabit.numberOfLines = 0
        return nameHabit
    }()

    lazy var intervalHabit: UILabel = {
        let interval = UILabel()
        interval.font = .systemFont(ofSize: 12, weight: .regular)
        interval.textColor = .systemGray2
        return interval
    }()

    lazy var counterHabit: UILabel = {
        let counter = UILabel()
        counter.font = .systemFont(ofSize: 13, weight: .regular)
        counter.textColor = .systemGray
        return counter
    }()

    lazy var progressHabit: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.widthCircle / 2
        button.addTarget(self, action: #selector(tapProgressHabit), for: .touchUpInside)
        return button
    }()

    private func setupConstraints() {
        contentView.addSubViews(view: nameHabit, intervalHabit, counterHabit, progressHabit)

        NSLayoutConstraint.activate([

            nameHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topMarginCell),
            nameHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMarginCell),

            intervalHabit.topAnchor.constraint(equalTo: nameHabit.bottomAnchor, constant: Constants.overSmallIndent),
            intervalHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMarginCell),

            progressHabit.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            progressHabit.heightAnchor.constraint(equalToConstant: Constants.widthCircle),
            progressHabit.widthAnchor.constraint(equalToConstant: Constants.widthCircle),
            progressHabit.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingBigMarginCell),
            progressHabit.leadingAnchor.constraint(equalTo: nameHabit.trailingAnchor, constant: Constants.overBigMargin),

            counterHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMarginCell),
            counterHabit.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottonMarginCell)


        ])

    }

    func setupHabit(_ habit: Habit) {
        self.habit = habit
        nameHabit.text = habit.name
        nameHabit.textColor = habit.color
        intervalHabit.text = habit.dateString
        counterHabit.text = "Счетчик: \(String(habit.trackDates.count))"
        if habit.isAlreadyTakenToday {
            progressHabit.backgroundColor = habit.color
            progressHabit.layer.borderWidth = 2
            progressHabit.layer.borderColor = habit.color.cgColor
            progressHabit.setTitle("✔︎", for: .normal)
            progressHabit.isUserInteractionEnabled = false
        } else {
            progressHabit.backgroundColor = .white
            progressHabit.layer.borderWidth = 2
            progressHabit.layer.borderColor = habit.color.cgColor
            progressHabit.backgroundColor = .white
            progressHabit.setTitle("", for: .normal)
            progressHabit.isUserInteractionEnabled = true
        }
        setupConstraints()


    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
    }


    @objc func tapProgressHabit() {
        if let trackHabit = habit {
            HabitsStore.shared.track(trackHabit)
            habitReloadDate?()


        }

    }

}
