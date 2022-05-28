//
//  DatabaseServices.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 28.05.2022.
//

import Foundation
import FirebaseFirestore

class DatabaseServices {
    static let shared = DatabaseServices()
    
    private let db = Firestore.firestore()
    
    private var userRef: CollectionReference {
        return db.collection("users")
    }
    
    private init() {}
}