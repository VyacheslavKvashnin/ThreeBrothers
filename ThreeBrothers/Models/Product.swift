//
//  Product.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 03.06.2022.
//

import Foundation

struct Product {
    var id = UUID().uuidString
    let name: String
    let description: String
    let image: String
    let price: Int
    let count: Int
}
