//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 14.03.2022.
//

import UIKit

class InfoViewController: UIViewController {

    var header: UILabel = {
        let header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.text = InfoText.header
        header.font = .systemFont(ofSize: 20, weight: .bold)
        return header
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Информация"


    }
    
}
