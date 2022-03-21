//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 14.03.2022.
//

import UIKit

class InfoViewController: UIViewController {

    lazy var infoTableView: UITableView = {
        let info = UITableView(frame: .zero, style: .grouped)
        info.translatesAutoresizingMaskIntoConstraints = false
        info.separatorStyle = .none // удалил разделительные полосы ячеек
        info.dataSource = self
        info.delegate = self
        info.register(InfoHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: InfoHeaderView.self))
        info.register(InfoTableViewCell.self, forCellReuseIdentifier: String(describing: InfoTableViewCell.self))
        info.showsVerticalScrollIndicator = false
        info.sectionHeaderHeight = 46
        return info
    }()

    private func setupConstraints() {
        view.addSubview(infoTableView)
        NSLayoutConstraint.activate([

            infoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Информация"
        navigationController?.tabBarController?.tabBar.backgroundColor = ColorSet.colorLightGray
        navigationController?.tabBarController?.tabBar.barTintColor = ColorSet.colorLightGray
        navigationController?.navigationBar.backgroundColor = ColorSet.colorLightGray
        setupConstraints()


    }
    
}


extension InfoViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InfoText.textInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InfoTableViewCell.self), for: indexPath) as? InfoTableViewCell else { return UITableViewCell()}
        cell.setupInfoText(text: InfoText.textInfo[indexPath.row])

        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.backgroundColor = .white
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: InfoHeaderView.self)) as? InfoHeaderView else { return nil }
        return header
    }


}
