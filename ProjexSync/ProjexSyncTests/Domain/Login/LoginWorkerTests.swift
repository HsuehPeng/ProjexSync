//
//  LoginWorker.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/17.
//

import XCTest
import ProjexSync

protocol LoginLogic {
	typealias LoginResult = Result<Bool, Error>
	
	func login(email: String, password: String, completion: @escaping (LoginResult) -> Void)
}

final class LoginWorker: LoginLogic {
	let emailLoginClient: EmailLoginClient
	let emailPasswordValidator: EmailPasswordValidation
	
	enum LoginError: Error {
		case email
		case password
		case client
	}
	
	func login(email: String, password: String, completion: @escaping (LoginResult) -> Void) {
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
			case .failure(let error):
				completion(.failure(LoginError.client))
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

final class LoginWorkerTests: XCTestCase {
	func test_login_loginWithWrongFormattedEmail_deliverWrongEmailFormateError() {
		let emailPasswordValidator = EmailPasswordValidatorMock(isEmailValid: false, isPasswordValid: true)
		let (sut, _) = makeSut(validator: emailPasswordValidator)
		expect(sut, completeWith: .failure(LoginWorker.LoginError.email), when: {})
	}
	
	func test_login_loginWithWrongFormattedPassword_deliverWrongPasswordFormateError() {
		let emailPasswordValidator = EmailPasswordValidatorMock(isEmailValid: true, isPasswordValid: false)
		let (sut, _) = makeSut(validator: emailPasswordValidator)
		
		expect(sut, completeWith: .failure(LoginWorker.LoginError.password), when: {})
	}
	
	func test_login_loginWithCorrectFormattedEmailAndPassword_emailLoginClientCallsLogin() {
		let emailPasswordValidator = EmailPasswordValidatorMock(isEmailValid: true, isPasswordValid: true)
		let (sut, emailLoginClient) = makeSut(validator: emailPasswordValidator)
		let anyEmail = anyEmail()
		let anyPassword = anyPassword()

		sut.login(email: anyEmail, password: anyPassword) { _ in }
				
		XCTAssertEqual(emailLoginClient.messages, [.login])
	}
	
	func test_login_loginWithCorrectFormattedEmailAndPassword_failToAuthenticateFromServer_deliverClientLoginError() {
		let emailPasswordValidator = EmailPasswordValidatorMock(isEmailValid: true, isPasswordValid: true)
		let (sut, emailLoginClient) = makeSut(validator: emailPasswordValidator)
		let anyNSError = NSError(domain: "", code: 1)
		
		expect(sut, completeWith: .failure(LoginWorker.LoginError.client), when: {
			emailLoginClient.completeWith(.failure(anyNSError))
		})
	}
	
	func test_login_loginWithCorrectFormattedEmailAndPassword_succeedToAuthenticateFromServer_deliverLoginSuccess() {
		let emailPasswordValidator = EmailPasswordValidatorMock(isEmailValid: true, isPasswordValid: true)
		let (sut, emailLoginClient) = makeSut(validator: emailPasswordValidator)
		
		expect(sut, completeWith: .success(true), when: {
			emailLoginClient.completeWith(.success(true))
		})
	}
	
	// MARK: - Helpers
	
	private func makeSut(validator: EmailPasswordValidation) -> (LoginWorker, EmailLoginClientSpy) {
		let emailLoginClient = EmailLoginClientSpy()
		let sut = LoginWorker(emailLoginClient: emailLoginClient, emailPasswordValidator: validator)
		
		return (sut, emailLoginClient)
	}
	
	private func expect(_ sut: LoginLogic, completeWith expectedResult: LoginLogic.LoginResult, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line ) {
		let exp = expectation(description: "Wait for login completion")
		let anyEmail = anyEmail()
		let anyPassword = anyPassword()
		
		sut.login(email: anyEmail, password: anyPassword) { receivedResult in
			switch (expectedResult, receivedResult) {
			case (.success, .success):
				XCTAssertTrue(true)
			case let (.failure(expectedError as LoginWorker.LoginError), .failure(receivedError as LoginWorker.LoginError)):
				XCTAssertEqual(expectedError, receivedError, file: file, line: line)
			default:
				XCTFail("Expected result \(expectedResult), got \(receivedResult) instead")
			}
			
			exp.fulfill()
		}
		
		action()
				
		wait(for: [exp], timeout: 1.0)
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


