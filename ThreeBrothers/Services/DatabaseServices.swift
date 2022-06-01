//
//  DatabaseServices.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 28.05.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class DatabaseServices {
    static let shared = DatabaseServices()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    func setUser(user: User, completion: @escaping(Result<User, Error>) -> Void) {
        db.collection("users").document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getUser(completion: @escaping(Result<User, Error>) -> Void) {
        db.document(Auth.auth().currentUser!.uid).getDocument { documentSnapshot, Error in
            guard let data = documentSnapshot?.data() else { return }
            let id = data["data"] as? String ?? ""
            let userName = data["userName"] as? String ?? ""
            let phone = data["phone"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            
            let user = User(id: id, userName: userName, email: email, phone: phone, date: Data())
            
            completion(.success(user))
        }
    }
}
