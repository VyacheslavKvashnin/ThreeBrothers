//
//  MainViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 18.05.2022.
//

import UIKit

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Меню"
        view.backgroundColor = .white
        
        let product = Product(
            name: "Burger",
            description: "The burger is very tasty",
            price: 200
        )
//            image: UIImage.init())
        
        DatabaseServices.shared.setProduct(product: product) { productDB in
            print(productDB)
        }
    }
}
