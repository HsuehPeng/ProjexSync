//
//  FirebaseAuthService.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/7.
//

import FirebaseAuth

public class EmailPasswordAuthService: AuthService {
	private let authClient: EmailPasswordAuthClient
	private let email: String
	private let password: String
		
	public enum Error: Swift.Error {
		case login
	}
	
	public func login(completion: @escaping LoginCompletion) {
		authClient.login(email: email, password: password) { result in
			switch result {
			case .failure:
				completion(Error.login)
			case .success:
				completion(nil)
			}
		}
	}
	
	public init(authClient: EmailPasswordAuthClient, email: String, password: String) {
		self.authClient = authClient
		self.email = email
		self.password = password
	}
}
