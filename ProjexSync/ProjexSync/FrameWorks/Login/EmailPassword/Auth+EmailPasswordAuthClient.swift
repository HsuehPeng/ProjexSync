//
//  Auth+EmailPasswordAuthClient.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import FirebaseAuth

extension Auth: EmailLoginClient {
	public func login(email: String, password: String, completion: @escaping LoginCompletion) {
		self.signIn(withEmail: email, password: password) { result, error in
			if let error = error {
				completion(.failure(error))
				return
			}
			completion(.success(true))
		}
	}
}
