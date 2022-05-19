//
//  ButtonExtention.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit

extension UIButton {
    class func customButton(frame: CGRect) -> UIButton {
        let button = UIButton()
        button.frame = frame
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.systemGray4, for: .highlighted)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = button.frame.height / 2
        button.setTitle("Next", for: .normal)
        return button
    }
}
