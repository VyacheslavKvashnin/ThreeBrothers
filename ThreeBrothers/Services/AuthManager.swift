//
//  AuthManager.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 18.05.2022.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    private var verificationId: String?
    
    func startAuth(phoneNumber: String, completion: @escaping(Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
            guard let verificationId = verificationId, error == nil else {
                completion(false)
                return
            }
            self?.verificationId = verificationId
            completion(true)
        }
    }
    
    func verifyCode(smsCode: String, completion: @escaping(Result<User, Error>) -> Void) {
        guard let verificationId = verificationId else {
            completion(.failure("error" as! Error))
            return
        }
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId,
            verificationCode: smsCode)
        
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                
                return
            }
            let user = User(
                id: result?.user.uid ?? "",
                userName: "pop",
                email: "",
                phone: ""
//                date: ""
            )
            
            DatabaseServices.shared.setUser(user: user) { resultDB in
                switch resultDB {
                    
                case .success(_):
                    completion(.success(user))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        }
    }
    
    func logOut() {
        try! auth.signOut()
    }
}
