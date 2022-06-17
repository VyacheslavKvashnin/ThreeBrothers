//
//  ProductCollectionViewCell.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 14.06.2022.
//

import UIKit

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
        label.text = "Some Text"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        nameLabel.frame = CGRect(
            x: 5,
            y: contentView.frame.size.height - 50,
            width: contentView.frame.size.width - 10,
            height: 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with image: UIImage, and name: String) {
        nameLabel.text = name
        imageView.image = image
    }
}
