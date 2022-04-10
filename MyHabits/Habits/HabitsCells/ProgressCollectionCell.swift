//
//  ProgressCollectionCell.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 21.03.2022.
//

import UIKit

class ProgressCollectionCell: UICollectionViewCell {

    lazy var motivationBar: UILabel = {
        let motivationBar = UILabel()
        motivationBar.text = "Все получится!"
        motivationBar.font = .systemFont(ofSize: 13, weight: .semibold)
        motivationBar.textColor = .systemGray
        return motivationBar
    }()

    lazy var progressBar: UILabel = {
        let progressBar = UILabel()
        progressBar.font = .systemFont(ofSize: 13, weight: .semibold)
        progressBar.textColor = .systemGray
        return progressBar
    }()

    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = ColorSet.colorBar
        progressView.progressTintColor = ColorSet.colorPurple
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        return progressView
    }()

    private func setupConstraints() {
        contentView.addSubViews(view: motivationBar, progressBar, progressView)

        NSLayoutConstraint.activate([
            motivationBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.contentTopMargin),
            motivationBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.contentLeadingMargin),

            progressBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.contentTopMargin),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.contentTrailingMargin),

            progressView.topAnchor.constraint(equalTo: motivationBar.bottomAnchor, constant: Constants.contentTopMargin),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.contentBotoomMargin),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.contentLeadingMargin),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.contentTrailingMargin)

        ])
    }

    func dateProgressView() {
        progressView.progress = HabitsStore.shared.todayProgress
        progressBar.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        setupConstraints()
    }


    
}
