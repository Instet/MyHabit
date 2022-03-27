//
//  InfoTableViewCell.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 17.03.2022.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

     lazy var infoText: UILabel = {
        let textView = UILabel()
        textView.font = .systemFont(ofSize: 17, weight: .regular)
         textView.numberOfLines = 0
         textView.textAlignment = .left
        return textView
    }()

    private func setupInfoCell() {
        self.contentView.addSubViews(view: infoText)
        NSLayoutConstraint.activate([

            infoText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            infoText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22)

        ])
    }

    func setupInfoText(text: String) {
        infoText.text = text
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none // Отключаем выделение
        setupInfoCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
