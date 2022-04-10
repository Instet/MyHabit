//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 08.04.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    var habit: Habit

    lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Править",
                                     style: .plain,
                                     target: self,
                                     action: #selector(editHabit))

        return button
    }()



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
    }

    @objc func editHabit() {
        let habitEdit = HabitViewController(habit)
        navigationController?.pushViewController(habitEdit, animated: true)
        navigationController?.tabBarController?.tabBar.isHidden = true


    }


}
