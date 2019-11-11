//
//  FirestoreService.swift
//  FirebaseLesson2Iram
//
//  Created by C4Q on 11/11/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    private init () {}
    
    static let manager = FirestoreService()
    
    
    private let database = Firestore.firestore()
    
    
    func createAppUser(user: AppUser, completion: @escaping (Result<Void, Error>) -> Void) {
        database.collection("users").document(user.uid).setData(user.fieldsDict) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }
            completion(.success(()))
        }
        
    }
    
    
}
