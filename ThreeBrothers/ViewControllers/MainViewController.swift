//
//  MainViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 18.05.2022.
//

import UIKit

class MainViewController: UIViewController, DataManagerProtocol {
    
    var databaseServices: DatabaseServices
    
    init(databaseServices: DatabaseServices) {
        self.databaseServices = databaseServices
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let myArray = ["First", "Second", "Third"]
    var products: [Product] = []
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Меню"
        view.backgroundColor = .white
        getProduct()
        mainTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        view.addSubview(mainTableView)
    }
    
    func getProduct() {
        databaseServices.getProduct { [unowned self] products in
            self.products = products
            self.mainTableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = products[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
    }
}
