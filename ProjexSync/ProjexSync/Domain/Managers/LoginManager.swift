//
//  LoginManager.swift
//  ProjexSync
//
//  Created by Boray Chen on 2023/9/23.
//

import Foundation
import FirebaseAuth

class LoginManager: AuthClient {
    static let shared = LoginManager()
    
    func auth(email: String, password: String, completion: @escaping AuthCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
}
