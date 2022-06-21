//
//  DatabaseServices.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 28.05.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol DataManagerProtocol {
    var databaseServices: DatabaseServices {get}
}

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
            
            if let users = snap?.documents {
                for user in users {
                    let email = user["email"] as! String
                    let id = user["id"] as! String
                    let phone = user["phone"] as! String
                    let userName = user["userName"] as! String
                    
                    let user = User(id: id, userName: userName, email: email, phone: phone)
                    
                    completion(user)
                }
            }
        }
    }
    
    func setProduct(product: Product, completion: @escaping(Product) -> Void) {
        db.collection("products").document(product.name).setData([
            "id": product.id,
            "name": product.name,
            "description": product.description,
            "price": product.price
        ])
    }
    
    func setProductToCart(product: Product, user: User, completion: @escaping(Product) -> Void) {
        db.collection("users").document(user.id).collection("cart").document(product.name).setData([
            "id": product.id,
            "name": product.name,
            "description": product.description,
            "image": product.image,
            "price": product.price,
            "count": product.count
        ])
    }
    
    func getProductToCart(completion: @escaping([Product]) -> Void) {
        DispatchQueue.global().async {
            self.db.collection("users").document(Auth.auth().currentUser!.uid).collection("cart").getDocuments { snap, error in
                guard error == nil else { return }
                var productsCart = [Product]()
                if let products = snap?.documents {
                    for product in products {
                        let name = product["name"] as! String
                        let description = product["description"] as! String
                        let image = product["image"] as? String
                        let price = product["price"] as! Int
                        let count = product["count"] as! Int
                        
                        let product = Product(name: name, description: description, image: image ?? "", price: price, count: count)
                        
                        productsCart.append(product)
                    }
                    DispatchQueue.main.async {
                        completion(productsCart)
                    }
                }
            }
        }
        
    }
    
    func getProduct(completion: @escaping([Product]) -> Void) {
        DispatchQueue.global().async {
            self.db.collection("products").getDocuments { snap, error in
                if let products = snap?.documents {
                    var productsArray = [Product]()
                    for product in products {
                        let name = product["name"] as! String
                        let description = product["description"] as! String
                        let image = product["image"] as? String
                        let price = product["price"] as! Int
                        let count = product["count"] as! Int
                        
                        let product = Product(name: name, description: description, image: image ?? "", price: price, count: count)
                        
                        productsArray.append(product)
                        
                    }
                    DispatchQueue.main.async {
                        completion(productsArray)                        
                    }
                }
            }
        }
        
    }
}
