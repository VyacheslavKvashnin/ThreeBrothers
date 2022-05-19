//
//  ViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 18.05.2022.
//

import UIKit

class PhoneViewController: UIViewController, UITextFieldDelegate {
    
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "3brataImage.jpg"))
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 50, y: 400, width: 300, height: 30))
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Your Number"
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let loginButton: UIButton = {
    let button = UIButton.customButton(frame: CGRect(x: 50, y: 500, width: 300, height: 50))
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        return button
    }()
    
    @objc func pressedButton(sender: UIButton) {
        guard let text = phoneTextField.text, !text.isEmpty else {
            return
        }
        startAuthPressed(text: text)
        self.animatedView(newViewAnimated: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Enter Phone Number"
        view.backgroundColor = .white
        setupUI()
        phoneTextField.delegate = self
    }
    
    private func setupUI() {
        view.addSubview(iconImage)
        view.addSubview(phoneTextField)
        view.addSubview(loginButton)
    }
    
    func startAuthPressed(text: String) {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            startAuthPressed(text: text)
        }
        return true
    }
    
    private func animatedView(newViewAnimated: UIView) {
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseIn) {
            
        } completion: { _ in
            
        }
    }
}