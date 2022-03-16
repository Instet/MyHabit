//
//  Extensions.swift
//  MyHabits
//
//  Created by Руслан Магомедов on 16.03.2022.
//

import UIKit

extension UIView {
    
    func addSubViews(view: UIView...) {
        view.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
