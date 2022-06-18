//
//  ProductCollectionViewCell.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 14.06.2022.
//

import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "productCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Some Text"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Some Text"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(
            x: 5,
            y: 0,
            width: 100,
            height: 100)
        nameLabel.frame = CGRect(
            x: 120,
            y: 5,
            width: contentView.frame.size.width - 10,
            height: 50)
        descriptionLabel.frame = CGRect(
            x: 120,
            y: 30,
            width: contentView.frame.size.width - 10,
            height: 50)
        priceLabel.frame = CGRect(
            x: 120,
            y: 50,
            width: contentView.frame.size.width - 10,
            height: 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(product: Product) {
        nameLabel.text = product.name
        descriptionLabel.text = product.description
        priceLabel.text = String(product.price)
        guard let url = URL(string: product.image) else { return }
        imageView.sd_setImage(with: url)
    }
}
