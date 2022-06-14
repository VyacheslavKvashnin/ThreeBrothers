//
//  DetailViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 10.06.2022.
//

import UIKit

protocol DetailViewControllerProtocol {
    
}

class DetailViewController: UIViewController {
    
    var product: Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        title = "Detail"
    }
}
