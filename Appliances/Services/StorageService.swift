//
//  StorageService.swift
//  Appliances
//
//  Created by Кристина Максимова on 07.04.2022.
//

import FirebaseStorage
import UIKit

class StorageService {
    static let shared = StorageService()
    let storage = Storage.storage().reference()
    
    var avatarsRef: StorageReference { storage.child("avatars") }
    var productsRef: StorageReference { storage.child("products") }
    
    private var currentUserId: String? {
        AuthService.shared.currentUser?.uid
    }
    
    private init() { }
    
    func upload(photo: UIImage, completion: @escaping (Result<String, Error>) -> ()) {
        guard let imadeData = photo.jpegData(compressionQuality: 0.03) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        avatarsRef.child(currentUserId!).putData(imadeData, metadata: metadata) {
            metadata, error in
            if let error = error {
                completion(.failure(error))
            } else if let metadata = metadata {
                completion(.success(String(metadata.size)))
            }
        }
    }
    
    func downloadProductImage(by id: String, completion: @escaping (Result<Data, Error>) -> ()) {
        let fileRef = productsRef.child(id)
        fileRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func downloadAvatar(completion: @escaping (Result<Data, Error>) -> ()) {
        let fileRef = avatarsRef.child(currentUserId!)
        fileRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func uploadProductImage(image: UIImage, by productID: String, completion: @escaping (Result<String, Error>) -> ()) {
        guard let imadeData = image.jpegData(compressionQuality: 0.03) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        productsRef.child(productID).putData(imadeData, metadata: metadata) {
            metadata, error in
            if let error = error {
                completion(.failure(error))
            } else if let metadata = metadata {
                completion(.success(String(metadata.size)))
            }
        }
    }
}
