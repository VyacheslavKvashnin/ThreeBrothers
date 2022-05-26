//
//  ViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 18.05.2022.
//

import UIKit

final class PhoneViewController: UIViewController {
    
    private let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private let stackView = UIStackView()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ThreeBrother.jpg"))
        return imageView
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField.customTextField()
        textField.placeholder = "Enter Your Number"
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
        title = "Enter Phone Number"
        view.backgroundColor = .white
        phoneTextField.delegate = self
        configureStackView()
        setNotificationForKeyboard()
        gestureTap()
        addDoneButtonOnKeyboard()
        //        assignBackground()
    }
    
    //   private func assignBackground(){
    //        let background = UIImage(named: "background")
    //
    //        var imageView: UIImageView!
    //        imageView = UIImageView(frame: view.bounds)
    //        imageView.contentMode =  .scaleToFill
    //        imageView.clipsToBounds = true
    //        imageView.image = background
    //        imageView.center = view.center
    //        view.addSubview(imageView)
    //        self.view.sendSubviewToBack(imageView)
    //    }
    
    @objc func pressedButton(sender: UIButton) {
        guard let text = phoneTextField.text, !text.isEmpty else {
            return
        }
        startAuthPressed(text: text)
    }
    
    private func gestureTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        stackView.addArrangedSubview(iconImage)
        stackView.addArrangedSubview(phoneTextField)
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
            phoneTextField.heightAnchor.constraint(equalToConstant: 30),
            iconImage.heightAnchor.constraint(equalToConstant: 300),
            loginButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 30),
            phoneTextField.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 40)
        ])
    }
    
    private func startAuthPressed(text: String) {
        let number = "+1\(text)"
        AuthManager.shared.startAuth(phoneNumber: number, completion: { [weak self] success in
            guard success else {
                self?.showAlert(title: "Ошибка", message: "Некорректный телефонный номер")
                return
            }
            DispatchQueue.main.async {
                let smsCodeVC = SMSCodeViewController()
                smsCodeVC.title = "Enter Code"
                self?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: nil)
                self?.navigationController?.pushViewController(smsCodeVC, animated: true)
            }
        })
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
        
        self.phoneTextField.inputAccessoryView = doneToolbar
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension PhoneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            startAuthPressed(text: text)
        }
        return true
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
