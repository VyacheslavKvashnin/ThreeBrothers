//
//  ViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 18.05.2022.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "3brataImage.jpg"))
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 50, y: 400, width: 300, height: 30))
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10
        textField.placeholder = "Enter Your Number"
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: 500, width: 300, height: 50))
        button.backgroundColor = .purple
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private func addSubviews() {
        view.addSubview(iconImage)
        view.addSubview(loginTextField)
        view.addSubview(loginButton)
    }
}

