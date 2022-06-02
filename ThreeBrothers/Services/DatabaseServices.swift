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
    
    func getUser(completion: @escaping(User) -> Void) {
        db.collection("users").getDocuments { snap, error in
            guard error == nil else { return }
            
            if let user = snap?.documents {
                print(user)
            }
        }
    }
}
