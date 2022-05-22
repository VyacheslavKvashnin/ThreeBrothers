//
//  SMSCodeViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 18.05.2022.
//

import UIKit

final class SMSCodeViewController: UIViewController {
    
    private let stackView = UIStackView()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ThreeBrother.jpg"))
        return imageView
    }()
    
    private let smsCodeTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter SMS Code"
        textField.keyboardType = .asciiCapableNumberPad
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton.customButton()
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        return button
    }()
    
    @objc func pressedButton() {
        guard let code = smsCodeTextField.text, !code.isEmpty else {
            return
        }
        verifyCodePressed(code: code)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureStackView()
        smsCodeTextField.delegate = self
        setNotificationForKeyboard()
    }
    
    func verifyCodePressed(code: String) {
        AuthManager.shared.verifyCode(smsCode: code) { [weak self] success in
            guard success else {
                self?.showAlert(title: "Ошибка", message: "Некорректный код")
                return
            }
            DispatchQueue.main.async {
                let mainVC = TabBarController()
                let navVC = UINavigationController(rootViewController: mainVC)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true)
                
            }
        }
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        stackView.addArrangedSubview(iconImage)
        stackView.addArrangedSubview(smsCodeTextField)
        stackView.addArrangedSubview(loginButton)
        
        setStackViewConstraints()
    }
    
    private func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            smsCodeTextField.heightAnchor.constraint(equalToConstant: 30),
            iconImage.heightAnchor.constraint(equalToConstant: 300),
            loginButton.topAnchor.constraint(equalTo: smsCodeTextField.bottomAnchor, constant: 30),
            smsCodeTextField.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 40)
        ])
    }
    
    private func gestureTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func setNotificationForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 3.2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension SMSCodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            let code = text
            verifyCodePressed(code: code)
        }
        return true
    }
}

