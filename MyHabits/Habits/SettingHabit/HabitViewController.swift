//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 28.03.2022.
//

import UIKit

class HabitViewController: UIViewController {

    weak var habit: Habit?

    weak var colorHabit: UIColor? = ColorSet.colorOrange {
        didSet {
            nameHabitTF.textColor = colorHabit
            colorSelection.backgroundColor = colorHabit
        }
    }

    var date: Date = Date() {
        didSet {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "HH:mm a"
            dateValueLabel.text = dateFormat.string(from: date)
        }
    }

    var nameHabit: String = ""


    lazy var saveHabit: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Сохранить"
        button.tintColor = ColorSet.colorPurple
        button.target = self
        button.action = #selector(saveNewHabit)
        return button
    }()

     lazy var cancelSaveHabit: UIBarButtonItem = {
        let cancel = UIBarButtonItem()
        cancel.title = "Отменить"
        cancel.tintColor = ColorSet.colorPurple
        cancel.target = self
        cancel.action = #selector(cancelSave)
        return cancel
    }()

    var nameLabel: UILabel = {
        let name = UILabel()
        name.text = "НАЗВАНИЕ"
        name.font = .systemFont(ofSize: 13, weight: .semibold)
        name.textColor = .black
        return name
    }()

    lazy var nameHabitTF: UITextField = {
        let name = UITextField()
        name.leftViewMode = .always
        name.placeholder = "Бегать по утрам, спать 8 часов и т. п."
        name.font = .systemFont(ofSize: 17, weight: .regular)
        name.textColor = colorHabit
        name.addTarget(self, action: #selector(addNameHabit), for: .editingChanged)
        name.resignFirstResponder()
        return name
    }()

    var labelColor: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()

    lazy var colorSelection: UIButton = {
        let color = UIButton()
        color.layer.cornerRadius = 15
        color.backgroundColor = colorHabit
        color.addTarget(self, action: #selector(selectionColor), for: .touchUpInside)
        return color
    }()

    lazy var dateLabel: UILabel = {
        let date = UILabel()
        date.text = "ВРЕМЯ"
        date.font = .systemFont(ofSize: 13, weight: .semibold)
        return date
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в "
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()

    lazy var dateValueLabel: UILabel = {
        var value = UILabel()
        value.font = .systemFont(ofSize: 17, weight: .regular)
        value.textColor = ColorSet.colorPurple
        // cоздадим
        let dateFomat = DateFormatter()
        dateFomat.dateFormat = "HH:mm a"
        value.text = dateFomat.string(from: date)
        return value
    }()

    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.date = date
        datePicker.datePickerMode = .time
        return datePicker
    }()

    lazy var removeHabit: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        // алерт
        button.addTarget(self, action: #selector(deletedHabit), for: .touchUpInside)
        return button
    }()

    init(_ editHabit: Habit?) {
        super.init(nibName: nil, bundle: nil)
        habit = editHabit
        if let habitSource = habit {
            date = habitSource.date
            colorHabit = habitSource.color
            nameHabit = habitSource.name
            nameHabitTF.text = nameHabit
            removeHabit.isHidden = false
            self.title = "Править"
        } else {
            removeHabit.isHidden = true
            self.title = "Создать"
            navigationItem.rightBarButtonItem = saveHabit
            navigationItem.leftBarButtonItem = cancelSaveHabit
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        navigationItem.rightBarButtonItem = saveHabit
//        navigationItem.leftBarButtonItem = cancelSaveHabit
    }

    private func setupConstraints() {
        self.view.addSubViews(view: nameLabel, nameHabitTF, labelColor, colorSelection, dateLabel, timeLabel, dateValueLabel, datePicker, removeHabit)

        NSLayoutConstraint.activate([

            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }



    ///  отмена сохранения
    @objc func cancelSave() {
        dismiss(animated: true, completion: nil)
    }

    @objc func saveNewHabit() {

    }

    @objc func addNameHabit() {
        if let text = nameHabitTF.text {
            nameHabit = text
        }
    }

    @objc func selectionColor() {
        let colorSet = UIColorPickerViewController()
        // warning
        colorSet.selectedColor = colorHabit ?? UIColor()
        colorSet.delegate = self
        colorSet.present(self, animated: true, completion: nil)
    }

    @objc func deletedHabit() {

        let alert = UIAlertController(title: "Удалить привычку", message: "Вы действительно хотите удалить привычку \"\(nameHabit)\"", preferredStyle: .alert)

        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        let delete = UIAlertAction(title: "Удалить", style: .destructive) { (_)  in
            if let thisHabit = self.habit {
                HabitsStore.shared.habits.removeAll(where: {$0 == thisHabit})
                HabitsViewController.habitSingl.habitCollectionView.reloadData()
            } else {
                //
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(cancel)
        alert.addAction(delete)

        self.present(alert, animated: true, completion: nil)

    }









}


extension HabitViewController: UIColorPickerViewControllerDelegate {

    // изменяет цвет везде при выборе текущего
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorHabit = viewController.selectedColor
    }

}

