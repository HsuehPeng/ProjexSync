//
//  LoginWorker.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/17.
//

import XCTest
@testable import ProjexSync

final class LoginWorkerTests: XCTestCase {
	func test_login_loginWithWrongFormattedEmail_deliverWrongEmailFormateError() {
		let emailPasswordValidator = EmailPasswordValidatorMock(isEmailValid: false, isPasswordValid: true)
		let (sut, _) = makeSut(validator: emailPasswordValidator)
		expect(sut, completeWith: .failure(AuthWorker.LoginError.email), when: {})
	}
	
	func test_login_loginWithWrongFormattedPassword_deliverWrongPasswordFormateError() {
		let emailPasswordValidator = EmailPasswordValidatorMock(isEmailValid: true, isPasswordValid: false)
		let (sut, _) = makeSut(validator: emailPasswordValidator)
		
		expect(sut, completeWith: .failure(AuthWorker.LoginError.password), when: {})
	}
	
	func test_login_loginWithCorrectFormattedEmailAndPassword_emailLoginClientCallsLogin() {
		let emailPasswordValidator = EmailPasswordValidatorMock(isEmailValid: true, isPasswordValid: true)
		let (sut, emailLoginClient) = makeSut(validator: emailPasswordValidator)
		let anyEmail = anyEmail()
		let anyPassword = anyPassword()

		sut.auth(email: anyEmail, password: anyPassword) { _ in }
				
		XCTAssertEqual(emailLoginClient.messages, [.login])
	}
	
	func test_login_loginWithCorrectFormattedEmailAndPassword_failToAuthenticateFromServer_deliverClientLoginError() {
		let emailPasswordValidator = EmailPasswordValidatorMock(isEmailValid: true, isPasswordValid: true)
		let (sut, emailLoginClient) = makeSut(validator: emailPasswordValidator)
		let anyNSError = NSError(domain: "", code: 1)
		
		expect(sut, completeWith: .failure(AuthWorker.LoginError.auth), when: {
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
	
	private func makeSut(validator: EmailPasswordValidatorMock) -> (AuthWorker, EmailLoginClientSpy) {
		let emailLoginClient = EmailLoginClientSpy()
		let emailPasswordValidator = validator
        let sut = AuthWorker(client: emailLoginClient, emailPasswordValidator: emailPasswordValidator)
		
		trackForMemoryleaks(emailLoginClient)
		trackForMemoryleaks(emailPasswordValidator)
		trackForMemoryleaks(sut)
		
		return (sut, emailLoginClient)
	}
	
    private func expect(_ sut: AuthLogic, completeWith expectedResult: AuthLogic.AuthResult, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line ) {
		let exp = expectation(description: "Wait for login completion")
		let anyEmail = anyEmail()
		let anyPassword = anyPassword()
		
		sut.auth(email: anyEmail, password: anyPassword) { receivedResult in
			switch (expectedResult, receivedResult) {
			case (.success, .success):
				XCTAssertTrue(true)
			case let (.failure(expectedError as AuthWorker.LoginError), .failure(receivedError as AuthWorker.LoginError)):
				XCTAssertEqual(expectedError, receivedError, file: file, line: line)
			default:
				XCTFail("Expected result \(expectedResult), got \(receivedResult) instead")
			}
			
			exp.fulfill()
		}
		
		action()
				
		wait(for: [exp], timeout: 1.0)
	}
	
	
    final class EmailLoginClientSpy: AuthClient {
		enum Message {
			case login
		}
		
		var messages = [Message]()
		var completions = [AuthCompletion]()
		
		func auth(email: String, password: String, completion: @escaping AuthCompletion) {
			messages.append(.login)
			completions.append(completion)
		}
		
		func completeWith(_ completion: AuthResult, at index: Int = 0) {
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


