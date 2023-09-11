//
//  LoginViewControllerInteractorTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/9.
//

import XCTest
@testable import ProjexSync

final class LoginViewControllerInteractorTests: XCTestCase {
	func test_login_loginClientDidCall() {
		let (sut, _, loginClient) = makeSut()
		
		sut.loginWith(email: anyEmail(), password: anyPassword())
		
		XCTAssertEqual(loginClient.loginCallCount, 1)
	}
	
	func test_login_presenterShowLoginIndicatorWhenLoginNotFinish() {
		let (sut, presenter, _) = makeSut()
		
		sut.loginWith(email: anyEmail(), password: anyPassword())

		XCTAssertEqual(presenter.isIndicatorLoading, true)
	}
	
	func test_login_presenterHideShowLoginIndicatorWhenLoginFinish() {
		let (sut, presenter, loginClient) = makeSut()
		
		sut.loginWith(email: anyEmail(), password: anyPassword())

		loginClient.completeLoginSuccess()
		
		XCTAssertEqual(presenter.isIndicatorLoading, false)
	}
	
	func test_login_presenterShowLoginInSuccessWhenLoginSuccess() {
		let (sut, presenter, loginClient) = makeSut()
		
		sut.loginWith(email: anyEmail(), password: anyPassword())

		loginClient.completeLoginSuccess()
		
		XCTAssertEqual(presenter.showLoginSuccessCallCount, 1)
	}
	
	func test_login_presenterShowLoginFailureWhenLoginFail() {
		let (sut, presenter, loginClient) = makeSut()
		
		sut.loginWith(email: anyEmail(), password: anyPassword())

		let loginError = NSError(domain: "", code: 1)
		
		loginClient.completeLoginFailure(with: loginError)
		
		XCTAssertEqual(presenter.showLoginFailureCallCount, 1)
	}
	
	// MARK: - Helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (LoginViewControllerInteractor, LoginViewControllerPresenterMock, EmailLoginClientSpy) {
		let presenter = LoginViewControllerPresenterMock()
		let emailLoginClient = EmailLoginClientSpy()
		let sut = LoginViewControllerInteractor(presenter: presenter, loginClient: emailLoginClient)
		
		trackForMemoryleaks(presenter, file: file, line: line)
		trackForMemoryleaks(emailLoginClient, file: file, line: line)
		trackForMemoryleaks(sut, file: file, line: line)

		return (sut, presenter, emailLoginClient)
	}
	
	func anyEmail() -> String {
		return "email@gmail.com"
	}
	
	func anyPassword() -> String {
		return "AnyPassword"
	}
	
	private final class LoginViewControllerPresenterMock: LoginViewControllerPresentationLogic {
		var isIndicatorLoading = false
		var showLoginSuccessCallCount = 0
		var showLoginFailureCallCount = 0
		
		func showLoginFailure(message: String) {
			showLoginFailureCallCount += 1
		}
		
		func showLoginSuccess() {
			showLoginSuccessCallCount += 1
		}
		
		func loginLoadingIndicator(isLoading: Bool) {
			isIndicatorLoading = isLoading
		}
	}
	
	private final class EmailLoginClientSpy: EmailLoginClient {
		var loginCallCount = 0
		var loginCompletions: [LoginCompletion] = []
		
		func login(email: String, password: String, completion: @escaping LoginCompletion) {
			loginCallCount += 1
			loginCompletions.append(completion)
		}
		
		func completeLoginSuccess(at index: Int = 0) {
			loginCompletions[index](.success(true))
		}
		
		func completeLoginFailure(with error: Error, at index: Int = 0) {
			loginCompletions[index](.failure(error))
		}
	}
}
