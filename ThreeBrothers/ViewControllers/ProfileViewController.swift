//
//  ProfileViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    var user: User!
    
    private let db = Firestore.firestore()
    private let phoneNumber = Auth.auth().currentUser?.phoneNumber
    
    private let stackView = UIStackView()
    
    private var nameTextField: UITextField = {
        let textField = UITextField.customTextField()
        textField.placeholder = "Ваше имя"
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField.customTextField()
        textField.placeholder = "Ваш имэил"
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton.customButton()
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return button
    }()
    
    @objc func saveData() {
        setUser()
        print(self.user ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Профиль"
        getUser()
        
        phoneLabel.text = phoneNumber
        
        configureItems()
        configureStackView()
    }
    
    func getAllField(user: User) {
        
        nameTextField.text = user.userName
    }
    
    func getUser() {
        DatabaseServices.shared.getUser { [unowned self] users in
            self.user = users
        }
    }
    
    func setUser() {
        DatabaseServices.shared.setUser(user: user) { result in
            switch result {
            case .success(_):
                print("success")
            case .failure(_):
                print("Error")
            }
        }
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(phoneLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(saveButton)
        
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
        downLoadSheet()
    }
    
    private func downLoadSheet() {
        let alert = UIAlertController(title: "Вы действительно хотите выйти?", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Выйти", style: .default, handler: { _ in
            AuthManager.shared.logOut()
            exit(0)
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
