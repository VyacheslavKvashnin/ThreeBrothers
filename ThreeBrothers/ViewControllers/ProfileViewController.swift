//
//  ProfileViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: UIViewController {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.borderStyle = .none
        textField.placeholder = "Enter Your Number"
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Профиль"
        configureItems()
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
