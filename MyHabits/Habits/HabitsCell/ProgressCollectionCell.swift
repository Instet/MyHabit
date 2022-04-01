//
//  ProgressCollectionCell.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 21.03.2022.
//

import UIKit

class ProgressCollectionCell: UICollectionViewCell {

    var motivationBar: UILabel = {
        let motivationBar = UILabel()
        motivationBar.text = "Все получится!"
        motivationBar.font = .systemFont(ofSize: 13, weight: .semibold)
        motivationBar.textColor = .systemGray
        return motivationBar
    }()

    var progressBar: UILabel = {
        let progressBar = UILabel()
        progressBar.font = .systemFont(ofSize: 13, weight: .semibold)
        progressBar.textColor = .systemGray
        return progressBar
    }()

    var progressView: UIProgressView = {
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
            motivationBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            motivationBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            progressBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            progressView.topAnchor.constraint(equalTo: motivationBar.bottomAnchor, constant: 10),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)

        ])
    }

    func dateProgressView() {
        progressView.progress = HabitsStore.shared.todayProgress
        progressBar.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
    }


    // настройка внешнего вида ячйки прогресса (подпредставление)
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        setupConstraints()
    }


    
}
