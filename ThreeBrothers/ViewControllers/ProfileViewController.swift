//
//  ProfileViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class ProfileViewController: UIViewController {
    
    private let database = Firestore.firestore()
    
    private let stackView = UIStackView()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Example"
        return label
    }()
    
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
        
        nameTextField.delegate = self
        
        saveData(text: "TeXT")
        
//        let docRef = database.document("users")
//        docRef.getDocument { [weak self] snap, error in
//            guard let data = snap?.data(), error == nil else { return }
//
//            guard let text = data["userName"] as? String else { return }
//
//            DispatchQueue.main.async {
//                self?.labelName.text = text
//            }
//        }
        configureItems()
        
        configureStackView()
    }
    
    private func saveData(text: String) {
        let docRef = database.document("users")
        docRef.setData(["userName": text])
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        stackView.addArrangedSubview(labelName)
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

extension UITextField {
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = nameTextField.text, !text.isEmpty {
            saveData(text: text)
        }
        return true
    }
}
