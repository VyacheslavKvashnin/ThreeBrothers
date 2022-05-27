//
//  ProfileViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: UIViewController {
    
    private let stackView = UIStackView()
    
    private let nameTextField: UITextField = {
        let textField = UITextField.customTextField()
        textField.placeholder = "Ваше имя"
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField.customTextField()
        textField.placeholder = "Ваш номер телефона"
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField.customTextField()
        textField.placeholder = "Ваш имэил"
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Профиль"
        configureItems()
        
        configureStackView()
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(phoneTextField)
        stackView.addArrangedSubview(emailTextField)
        
        setStackViewConstraints()
    }
    
    private func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
    }
    
    private func configureItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.lefthalf.inset.filled.arrow.left"),
            style: .plain,
            target: self, action: #selector(logOut))
    }
    
    @objc func logOut() {
        AuthManager.shared.logOut()
        downLoadSheet()
    }
    
    private func downLoadSheet() {
        let alert = UIAlertController(title: "Вы действительно хотите выйти?", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Выйти", style: .default, handler: { [unowned self] _ in
            AuthManager.shared.logOut()
            dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
            
        }))
        present(alert, animated: true)
    }
}

class customUITextField: UITextField {

        func setup() {
            let border = CALayer()
            let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
