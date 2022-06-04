//
//  MainViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 18.05.2022.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let myArray = ["First", "Second", "Third"]
    
    var products: [Product] = []
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Меню"
        view.backgroundColor = .white
        
        mainTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        view.addSubview(mainTableView)
        getProduct()
        print(products)
    }
    
    func getProduct() {
        DatabaseServices.shared.getProduct { [unowned self] products in
            self.products = products
            self.mainTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = products[indexPath.row].name
        return cell
    }
}
