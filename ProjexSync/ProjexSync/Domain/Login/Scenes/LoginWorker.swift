//
//  LoginWorker.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/17.
//

import Foundation

protocol LoginLogic {
	typealias LoginResult = Result<Bool, Error>
	
	func login(email: String?, password: String?, completion: @escaping (LoginResult) -> Void)
}

final class LoginWorker: LoginLogic {
	let emailLoginClient: EmailLoginClient
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
	
	func login(email: String?, password: String?, completion: @escaping (LoginResult) -> Void) {
		guard let email = email, emailPasswordValidator.isValidEmail(email) else {
			completion(.failure(LoginError.email))
			return
		}
		
		guard let password = password, emailPasswordValidator.isValidPassword(password) else {
			completion(.failure(LoginError.password))
			return
		}
		
		emailLoginClient.login(email: email, password: password) { result in
			switch result {
			case .failure:
				completion(.failure(LoginError.auth))
			case .success:
				completion(.success(true))
			}
		}
	}
	
	init(emailLoginClient: EmailLoginClient, emailPasswordValidator: EmailPasswordValidation) {
		self.emailLoginClient = emailLoginClient
		self.emailPasswordValidator = emailPasswordValidator
	}
}
