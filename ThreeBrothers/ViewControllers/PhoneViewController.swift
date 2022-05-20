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
        let imageView = UIImageView(image: UIImage(named: "3brataImage.jpg"))
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Your Number"
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton.customButton()
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        return button
    }()
    
    @objc func pressedButton(sender: UIButton) {
        guard let text = phoneTextField.text, !text.isEmpty else {
            return
        }
        startAuthPressed(text: text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Enter Phone Number"
        view.backgroundColor = .white
        phoneTextField.delegate = self
        configureStackView()
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        
        stackView.addArrangedSubview(iconImage)
        stackView.addArrangedSubview(phoneTextField)
        stackView.addArrangedSubview(loginButton)
        
        setStackViewConstraints()
    }
    
    private func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            iconImage.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func startAuthPressed(text: String) {
        let number = "+1\(text)"
        AuthManager.shared.startAuth(phoneNumber: number, completion: { [weak self] success in
            guard success else { return }
            DispatchQueue.main.async {
                let smsCodeVC = SMSCodeViewController()
                smsCodeVC.title = "Enter Code"
                self?.navigationController?.pushViewController(smsCodeVC, animated: true)
            }
        })
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
