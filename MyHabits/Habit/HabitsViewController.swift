//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 14.03.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
    

        return layout
    }()

    lazy var habitCollectionView: UICollectionView = {
        let habit = UICollectionView(frame: .zero, collectionViewLayout: layout)
        habit.translatesAutoresizingMaskIntoConstraints = false
        habit.backgroundColor = ColorSet.colorLightGray
        return habit
    }()


    lazy var addHabit: UIBarButtonItem = {
        let add = UIBarButtonItem()
        add.image = UIImage(systemName: "plus")
        add.target = self
        add.action = #selector(addNewHabit)
        return add
    }()


    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupConstraints()

    }



    private func setupConstraints() {
        view.addSubViews(view: habitCollectionView)

        NSLayoutConstraint.activate([
            habitCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = ColorSet.colorPurple
        self.title = "Сегодня"
        // проверка на версию
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationItem.rightBarButtonItem = addHabit
    }



    @objc func addNewHabit() {
        print("Hello")
    }

}
