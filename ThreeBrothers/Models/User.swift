//
//  User.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 28.05.2022.
//

import Foundation

struct User: Identifiable {
    let id: String
    let userName: String
    let email: String
    let phone: String
    let date: Data
    
    var representation: [String: Any] {
        var representation = [String: Any]()
        representation["id"] = self.id
        representation["userName"] = self.userName
        representation["email"] = self.email
        representation["phone"] = self.phone
        representation["date"] = self.date
        return representation
    }
}
