//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 14.03.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    public static let habitSingl: HabitsViewController = .init()

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
        habitCollectionView.register(ProgressCollectionCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionCell.self))
        habitCollectionView.dataSource = self
        habitCollectionView.delegate = self

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


    // переход на экран создания привычки
    
    @objc func addNewHabit() {
        let newHabit = HabitViewController(nil)
        let newHabitNC = UINavigationController(rootViewController: newHabit)
        newHabitNC.modalPresentationStyle = .fullScreen
        navigationController?.present(newHabitNC, animated: true)

    }

}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // количество секций
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    // количество ячеек в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionCell.self), for: indexPath) as? ProgressCollectionCell else { return UICollectionViewCell() }

            cell.dateProgressView()

            return cell
        }

        return UICollectionViewCell()
    }

    // координаты ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 18, right: 16)
        } else {
            return UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
        }
    }

    // размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let width = collectionView.bounds.width - 32
            return CGSize(width: width, height: 60)
        } else {
            let width = collectionView.bounds.width - 32
            return CGSize(width: width, height: 130)
        }
    }



}
