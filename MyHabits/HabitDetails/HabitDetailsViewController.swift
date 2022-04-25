//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 08.04.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    var habit: Habit

    lazy var detailsTableView: UITableView = {
        let details = UITableView(frame: .zero, style: .grouped)
        details.showsVerticalScrollIndicator = false
        details.dataSource = self
        details.delegate = self
        details.register(HabitDetailTableViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailTableViewCell.self))
        details.register(HabitDetailsTableViewHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: HabitDetailsTableViewHeader.self))
        
        return details
    }()

    lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Править",
                                     style: .plain,
                                     target: self,
                                     action: #selector(editHabit))

        return button
    }()

    private func setupTableView() {
        view.addSubViews(view: detailsTableView)

        NSLayoutConstraint.activate([
            detailsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    init(_ habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationItem.largeTitleDisplayMode = .never
       }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorSet.colorLightGray
        navigationItem.rightBarButtonItem = editButton
        self.title = habit.name
        setupTableView()
    }

    @objc func editHabit() {
        let habitEdit = HabitViewController(habit)
        navigationController?.pushViewController(habitEdit, animated: true)
    }

}

extension HabitDetailsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailTableViewCell.self), for: indexPath) as! HabitDetailTableViewCell
        let date = HabitsStore.shared.dates[indexPath.row]

        cell.configure(indexPath.item)

        if HabitsStore.shared.habit(habit, isTrackedIn: date) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: HabitDetailsTableViewHeader.self)) as? HabitDetailsTableViewHeader else { return nil }
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46.5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }


}

