//
//  DetailViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 10.06.2022.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var product: Product!
    var user: User!
    
    private let stackView = UIStackView()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let addInFavoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add To Favorite", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveInFavorite), for: .touchUpInside)
        return button
    }()
    
    @objc func saveInFavorite() {
        setDataFromFB()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = product.name
        
        setupUI()
    }
    
    private func setupUI() {
        configureStackView()
        configure()
        getUser()
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        
        stackView.addArrangedSubview(photoImageView)
        stackView.addArrangedSubview(productName)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(addInFavoriteButton)
        
        setStackViewConstraints()
    }
    
    private func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
    }
    
    func configure() {
        let url = URL(string: product.image)
        photoImageView.sd_setImage(with: url)
        productName.text = product.name
        descriptionLabel.text = product.description
        priceLabel.text = String(product.price)
    }
    
    private func getUser() {
        DatabaseServices.shared.getUser { user in
            self.user = user
        }
    }
    
    private func setDataFromFB() {
        DatabaseServices.shared.setProductToCart(product: product, user: user) { _ in
            print("success")
        }
    }
}
