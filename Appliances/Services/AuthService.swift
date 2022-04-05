//
//  AuthService.swift
//  Appliances
//
//  Created by Кристина Максимова on 31.03.2022.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    let auth = Auth.auth()
    var currentUser: User? { auth.currentUser }
    
    private init() { }
    
    func signUp(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> ()) {
        auth.createUser(withEmail: email,
                        password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                let user = Users(id: result.user.uid,
                                 name: "",
                                 phone: 0,
                                 address: "")
                DatabaseService.shared.setUser(user: user) { dbResult in
                    switch dbResult {
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> ()) {
        auth.signIn(withEmail: email,
                    password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                completion(.success(result.user))
            }
        }
    }
    
    func signOut(completion: () -> ()) {
        do {
            try auth.signOut()
            completion()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
