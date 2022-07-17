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
        let imageView = UIImageView(image: UIImage(named: "brotherImage"))
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.yellow.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let smsCodeTextField: UITextField = {
        let textField = UITextField.customTextField()
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 0, alpha: 0.2)
        textField.textColor = .white
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "123 456",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 1, blue: 1, alpha: 0.5)])
        textField.keyboardType = .asciiCapableNumberPad
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton.customButton()
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        configureStackView()
        smsCodeTextField.delegate = self
        setNotificationForKeyboard()
        addDoneButtonOnKeyboard()
        assignBackground()
    }
    
    private func assignBackground(){
        let background = UIImage(named: "background")
        let imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    @objc func pressedButton() {
        guard let code = smsCodeTextField.text, !code.isEmpty else {
            return
        }
        verifyCodePressed(code: code)
    }
    
    private func verifyCodePressed(code: String) {
        AuthManager.shared.verifyCode(smsCode: code) { [weak self] success in
            switch success {
            case .success(_):
                DispatchQueue.main.async {
                    let mainVC = TabBarController(container: AppDependency.init(
                        databaseServices: DatabaseServices.shared,
                        authManager: AuthManager.shared))
                    mainVC.modalPresentationStyle = .fullScreen
                    self?.present(mainVC, animated: true)
                }
            case .failure(_):
                self?.showAlert(title: "Ошибка", message: "Некорректный код")
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
            smsCodeTextField.heightAnchor.constraint(equalToConstant: 50),
            iconImage.heightAnchor.constraint(equalToConstant: 300),
            loginButton.topAnchor.constraint(equalTo: smsCodeTextField.bottomAnchor, constant: 30),
            smsCodeTextField.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 40)
        ])
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(
            title: "Далее",
            style: .done,
            target: self,
            action: #selector(pressedButton))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.smsCodeTextField.inputAccessoryView = doneToolbar
    }
}

extension SMSCodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            let code = text
            verifyCodePressed(code: code)
        }
        return true
    }
}

