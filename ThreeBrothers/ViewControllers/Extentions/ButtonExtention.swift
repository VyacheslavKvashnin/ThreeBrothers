//
//  ButtonExtention.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit

extension UIButton {
    class func customButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.systemGray4, for: .highlighted)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return button
    }
}
