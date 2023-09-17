//
//  LoginWorker.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/17.
//

import XCTest
import ProjexSync

protocol LoginLogic {
	func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}

final class LoginWorker: LoginLogic {
	let emailLoginClient: EmailLoginClient
	let emailPasswordValidator: EmailPasswordValidation
	
	enum LoginError: Error {
		case email
		case password
	}
	
	func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
		guard emailPasswordValidator.isValidEmail(email) else {
			completion(.failure(LoginError.email))
			return
		}
		
		guard emailPasswordValidator.isValidPassword(password) else {
			completion(.failure(LoginError.password))
			return
		}
		
		emailLoginClient.login(email: email, password: password) { result in
			switch result {
			default:
				return
			}
		}
	}
	
	init(emailLoginClient: EmailLoginClient, emailPasswordValidator: EmailPasswordValidation) {
		self.emailLoginClient = emailLoginClient
		self.emailPasswordValidator = emailPasswordValidator
	}
}

final class LoginWorkerTests: XCTestCase {
	func test_login_loginWithWrongFormattedEmail_deliverWrongEmailFormateError() {
		let emailPasswordValidator = EmailPasswordValidatorMock(isEmailValid: false, isPasswordValid: true)
		let sut = makeSut(validator: emailPasswordValidator)
		let wrongEmail = "0000"
		let anyPassword = "000000"
		let expectedError = LoginWorker.LoginError.email
		let exp = expectation(description: "Wait for load completion")

		sut.login(email: wrongEmail, password: anyPassword) { result in
			switch result {
			case .success:
				XCTFail("Expected login failure but got success instead")
			case .failure(let receivedError as LoginWorker.LoginError):
				XCTAssertEqual(receivedError, expectedError)
			default:
				XCTFail("Expected result \(expectedError), got \(result) instead")
			}
			
			exp.fulfill()
		}
				
		wait(for: [exp], timeout: 1.0)
	}
	
	// MARK: - Helpers
	
	private func makeSut(validator: EmailPasswordValidation) -> LoginWorker {
		let emailLoginClient = EmailLoginClientSpy()
		let sut = LoginWorker(emailLoginClient: emailLoginClient, emailPasswordValidator: validator)
		
		return sut
	}
	
	final class EmailLoginClientSpy: EmailLoginClient {
		enum Message {
			case login
		}
		
		var messages = [Message]()
		var completions = [LoginCompletion]()
		
		func login(email: String, password: String, completion: @escaping LoginCompletion) {
			messages.append(.login)
			completions.append(completion)
		}
		
		func completeWith(_ completion: LoginResult, at index: Int = 0) {
			completions[index](completion)
		}
	}
	
	final class EmailPasswordValidatorMock: EmailPasswordValidation {
		let isEmailValid: Bool
		let isPasswordValid: Bool
		
		func isValidEmail(_ email: String) -> Bool {
			return isEmailValid
		}
		
		func isValidPassword(_ password: String) -> Bool {
			return isPasswordValid
		}
		
		init(isEmailValid: Bool, isPasswordValid: Bool) {
			self.isEmailValid = isEmailValid
			self.isPasswordValid = isPasswordValid
		}
	}
}


