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
        let textField = UITextField.customTextField()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureStackView()
        smsCodeTextField.delegate = self
        setNotificationForKeyboard()
        addDoneButtonOnKeyboard()
    }
    
    @objc func pressedButton() {
        guard let code = smsCodeTextField.text, !code.isEmpty else {
            return
        }
        verifyCodePressed(code: code)
    }
    
    private func verifyCodePressed(code: String) {
        AuthManager.shared.verifyCode(smsCode: code) { [weak self] success in
            guard success else {
                self?.showAlert(title: "Ошибка", message: "Некорректный код")
                return
            }
            DispatchQueue.main.async {
                let mainVC = TabBarController()
                mainVC.modalPresentationStyle = .fullScreen
                self?.present(mainVC, animated: true)
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
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
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
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Далее", style: .done, target: self, action: #selector(pressedButton))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.smsCodeTextField.inputAccessoryView = doneToolbar
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

