//
//  FirebaseAuthService.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/7.
//

import FirebaseAuth

public protocol AuthService {
	typealias LoginResult = Swift.Result<Bool, Error>
	typealias LoginCompletion = (LoginResult) -> Void
	
	func login(completion: @escaping LoginCompletion)
}

public protocol EmailPasswordAuthClient {
	typealias LoginResult = Swift.Result<Bool, Error>
	typealias LoginCompletion = (LoginResult) -> Void
	
	func login(email: String, password: String, completion: @escaping LoginCompletion)
}

public class EmailPasswordAuthService: AuthService {
	private let authClient: EmailPasswordAuthClient
	private let email: String
	private let password: String
	
	public typealias Result = AuthService.LoginResult
	
	public enum Error: Swift.Error {
		case login
	}
	
	public func login(completion: @escaping (Result) -> Void) {
		authClient.login(email: email, password: password) { result in
			switch result {
			case .failure(let error):
				completion(.failure(error))
			default:
				break
			}
		}
	}
	
	public init(authClient: EmailPasswordAuthClient, email: String, password: String) {
		self.authClient = authClient
		self.email = email
		self.password = password
	}
}
