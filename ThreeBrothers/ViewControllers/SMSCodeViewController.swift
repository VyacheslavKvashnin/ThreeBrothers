//
//  SMSCodeViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 18.05.2022.
//

import UIKit

class SMSCodeViewController: UIViewController, UITextFieldDelegate {
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "3brataImage.jpg"))
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let smsCodeTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 50, y: 400, width: 300, height: 30))
        textField.layer.cornerRadius = 10
        textField.placeholder = "Enter SMS Code"
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let loginButton: UIButton = {
       let button = UIButton.customButton(frame: CGRect(x: 50, y: 500, width: 300, height: 50))
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
        setupUI()
        smsCodeTextField.delegate = self
    }
    
    private func setupUI() {
        view.addSubview(iconImage)
        view.addSubview(smsCodeTextField)
        view.addSubview(loginButton)
    }
    
    func verifyCodePressed(code: String) {
        AuthManager.shared.verifyCode(smsCode: code) { [weak self] success in
            guard success else { return }
            DispatchQueue.main.async {
                let mainVC = TabBarController()
                let navVC = UINavigationController(rootViewController: mainVC)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true)
               
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            let code = text
            verifyCodePressed(code: code)
        }
        return true
    }
    
    func getTabBarVC() {
        let tabBarVC = UITabBarController()
        
        let mainVC = MainViewController()
        let profileVC = ProfileViewController()
        let contactsVC = ContactsViewController()
        let cartVC = CartViewController()
        
        mainVC.title = "Меню"
        profileVC.title = "Профиль"
        contactsVC.title = "Котнакты"
        cartVC.title = "Корзина"
        
        tabBarVC.setViewControllers([mainVC, profileVC, contactsVC, cartVC], animated: false)
        
        guard let items = tabBarVC.tabBar.items else { return }
        
        for item in items {
            item.image = UIImage(systemName: "house")
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
        
        present(tabBarVC, animated: true)
    }
}

// experience  o
