//
//  InfoHeaderView.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 17.03.2022.
//

import UIKit

class InfoHeaderView: UITableViewHeaderFooterView {

    private lazy var header: UILabel = {
        let header = UILabel()
        header.text = InfoText.header
        header.font = .systemFont(ofSize: 20, weight: .semibold)
        return header
    }()

    private func setupHeader() {
        contentView.addSubViews(view: header)

        NSLayoutConstraint.activate([

            header.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

        ])
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHeader()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
