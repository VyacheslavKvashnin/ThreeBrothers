//
//  User.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 28.05.2022.
//

import Foundation

struct User: Identifiable {
    let id: String
    var userName: String
    var email: String
    let phone: String
    
    var representation: [String: Any] {
        var representation = [String: Any]()
        representation["id"] = self.id
        representation["userName"] = self.userName
        representation["email"] = self.email
        representation["phone"] = self.phone
        return representation
    }
}
