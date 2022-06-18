//
//  CartViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit

final class CartViewController: UIViewController {
    
    private let stackView = UIStackView()
    
    var databaseServices: DatabaseServices
    
    init(databaseServices: DatabaseServices) {
        self.databaseServices = databaseServices
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var user: User!
    var products: [Product] = []
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Корзина"
        setupUI()
    }
    
    private func setupUI() {
        getProductsToCar()
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func getProductsToCar() {
        databaseServices.getProductToCart { products in
            self.products = products
            self.collectionView.reloadData()
        }
    }
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let index = products[indexPath.item]
        cell.configure(product: index)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = products[indexPath.item]
        let detailVC = DetailViewController()
        detailVC.product = index
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: view.frame.width,
            height: 120
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
