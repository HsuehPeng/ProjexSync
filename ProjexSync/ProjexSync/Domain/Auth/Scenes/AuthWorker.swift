//
//  LoginWorker.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/17.
//

import Foundation

protocol AuthLogic {
	typealias AuthResult = Result<Bool, Error>
	
	func auth(email: String?, password: String?, completion: @escaping (AuthResult) -> Void)
}

final class AuthWorker: AuthLogic {
	let client: AuthClient
	let emailPasswordValidator: EmailPasswordValidation
	
	enum LoginError: Error, LocalizedError {
		case email
		case password
		case auth
		
		var errorDescription: String? {
			switch self {
			case .email:
				return NSLocalizedString("Invalid email address", comment: "")
			case .password:
				return NSLocalizedString("Invalid password", comment: "")
			case .auth:
				return NSLocalizedString("Authentication Failed", comment: "")
			}
		}
	}
	
	func auth(email: String?, password: String?, completion: @escaping (AuthResult) -> Void) {
		guard let email = email, emailPasswordValidator.isValidEmail(email) else {
			completion(.failure(LoginError.email))
			return
		}
		
		guard let password = password, emailPasswordValidator.isValidPassword(password) else {
			completion(.failure(LoginError.password))
			return
		}
		
        client.auth(email: email, password: password) { result in
			switch result {
			case .failure:
				completion(.failure(LoginError.auth))
			case .success:
				completion(.success(true))
			}
		}
	}
	
	init(client: AuthClient, emailPasswordValidator: EmailPasswordValidation) {
		self.client = client
		self.emailPasswordValidator = emailPasswordValidator
	}
}
