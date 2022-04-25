//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 28.03.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    weak var habit: Habit?

    var isEdit: Bool = false

    var colorHabit: UIColor = ColorSet.colorOrange! {
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
        name.addTarget(self, action: #selector(universalSaveButton), for: .editingChanged)
        name.returnKeyType = .done
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
        color.layer.cornerRadius = Constants.widthColorCircle / 2
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
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = ColorSet.colorPurple
        datePicker.addTarget(self, action: #selector(dateSetup), for: .valueChanged)
        return datePicker
    }()

    lazy var removeHabit: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(deletedHabit), for: .touchUpInside)
        return button
    }()

    init(_ editHabit: Habit?) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        habit = editHabit
        if let habitSource = habit {
            date = habitSource.date
            colorHabit = habitSource.color
            nameHabit = habitSource.name
            nameHabitTF.text = nameHabit
            removeHabit.isHidden = false
            self.title = "Править"
            navigationItem.rightBarButtonItem = saveHabit
            navigationItem.leftBarButtonItem = cancelSaveHabit
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


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(gesture)
        universalSaveButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }


    private func setupConstraints() {
        self.view.addSubViews(view: nameLabel, nameHabitTF, labelColor, colorSelection, dateLabel, timeLabel, dateValueLabel, datePicker, removeHabit)

        NSLayoutConstraint.activate([

            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topMargin),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingMargin),

            nameHabitTF.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.smallIndent),
            nameHabitTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingMargin),
            nameHabitTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingMargin),

            labelColor.topAnchor.constraint(equalTo: nameHabitTF.bottomAnchor, constant: Constants.indent),
            labelColor.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingMargin),

            colorSelection.topAnchor.constraint(equalTo: labelColor.bottomAnchor, constant: Constants.smallIndent),
            colorSelection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingMargin),
            colorSelection.heightAnchor.constraint(equalToConstant: Constants.widthColorCircle),
            colorSelection.widthAnchor.constraint(equalToConstant: Constants.widthColorCircle),

            dateLabel.topAnchor.constraint(equalTo: colorSelection.bottomAnchor, constant: Constants.indent),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingMargin),

            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constants.smallIndent),
            timeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingMargin),

            dateValueLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constants.smallIndent),
            dateValueLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),

            datePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: Constants.indent),
            datePicker.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            removeHabit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.bottomMargin),
            removeHabit.centerXAnchor.constraint(equalTo: view.centerXAnchor)


        ])
    }

    @objc func dateSetup( _ sender: UIDatePicker) {
        date = sender.date
        universalSaveButton()
    }

    @objc func tapGesture() {
        nameHabitTF.resignFirstResponder()
    }

    @objc func cancelSave() {

        if isEdit == false {
            navigationController?.popToRootViewController(animated: true)
        }
        dismiss(animated: true, completion: nil)
    }


    @objc func saveNewHabit() {
        if let oldHabit = habit {
            oldHabit.name = nameHabit
            oldHabit.date = date
            oldHabit.color = colorHabit
            HabitsStore.shared.save()
            navigationController?.popToRootViewController(animated: true)
        } else {
            let newHabit = Habit(name: nameHabit, date: date, color: colorHabit)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
            dismiss(animated: true, completion: nil)
        }
    }

    @objc func universalSaveButton() {
        if nameHabitTF.text?.isEmpty == true || equotable() == true{
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
            if let text = nameHabitTF.text {
                nameHabit = text
            }
        }
    }


    @objc func selectionColor() {
        let colorSet = UIColorPickerViewController()
        colorSet.selectedColor = colorHabit
        colorSet.delegate = self
        colorSet.title = "Выберите цвет привычки"
        self.present(colorSet, animated: true, completion: nil)

    }


    @objc func deletedHabit() {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы действительно хотите удалить привычку \"\(nameHabit)\"", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "Удалить", style: .destructive) { [self] _  in
            if let thisHabit = habit {
                HabitsStore.shared.habits.removeAll(where: {$0 == thisHabit})
            }
            navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(cancel)
        alert.addAction(delete)

        self.present(alert, animated: true, completion: nil)
    }

}


extension HabitViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorHabit = viewController.selectedColor
        universalSaveButton()
    }

    func equotable() -> Bool {
        return habit?.name == nameHabitTF.text &&
        habit?.date == datePicker.date &&
        habit?.color == colorSelection.backgroundColor

    }

}

