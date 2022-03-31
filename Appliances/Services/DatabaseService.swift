//
//  DatabaseService.swift
//  Appliances
//
//  Created by Кристина Максимова on 31.03.2022.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    
    static let shared = DatabaseService()
    let db = Firestore.firestore()
    var usersRef: CollectionReference { db.collection("users") }
    
    private init() { }
    
    func createUser(user: Users,
                   completion: @escaping (Result<Users, Error>) -> ()) {
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
}
