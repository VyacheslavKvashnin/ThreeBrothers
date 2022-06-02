//
//  TextFieldExtention.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import Foundation
import UIKit

extension UITextField {
    class func customTextField() -> UITextField {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        return textField
    }
}
