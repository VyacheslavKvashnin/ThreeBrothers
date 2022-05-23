//
//  CartViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit

final class CartViewController: UIViewController {
    
    private let stackView = UIStackView()
    
    private let cartLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваша корзина еще пуста"
        label.textAlignment = .center
        return label
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton.customButton()
        button.setTitle("Перейти в меню", for: .normal)
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        return button
    }()
    
    @objc func pressedButton() {
        tabBarController?.selectedIndex = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Корзина"
        setupUI()
        configureStackView()
    }
    
    private func setupUI() {
        view.addSubview(cartLabel)
        view.addSubview(cartButton)
    }

    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        
        stackView.addArrangedSubview(cartLabel)
        stackView.addArrangedSubview(cartButton)
        
        setStackViewConstraints()
    }
    
    private func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
    }
}
