//
//  LoginViewControllerInteractorTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/9.
//

import XCTest
@testable import ProjexSync

final class LoginViewControllerInteractorTests: XCTestCase {
	func test_login_loginServiceDidCall() {
		let (sut, _, loginService) = makeSut()
		
		sut.loginWith(email: anyEmail(), password: anyPassword())
		
		XCTAssertEqual(loginService.loginCallCount, 1)
	}
	
	func test_login_presenterShowLoginIndicatorWhenLoginNotFinish() {
		let (sut, presenter, _) = makeSut()
		
		sut.loginWith(email: anyEmail(), password: anyPassword())

		XCTAssertEqual(presenter.isIndicatorLoading, true)
	}
	
	func test_login_presenterHideShowLoginIndicatorWhenLoginFinish() {
		let (sut, presenter, loginService) = makeSut()
		
		sut.loginWith(email: anyEmail(), password: anyPassword())

		loginService.completeLoginSuccess()
		
		XCTAssertEqual(presenter.isIndicatorLoading, false)
	}
	
	func test_login_presenterShowLoginInSuccessWhenLoginSuccess() {
		let (sut, presenter, loginService) = makeSut()
		
		sut.loginWith(email: anyEmail(), password: anyPassword())

		loginService.completeLoginSuccess()
		
		XCTAssertEqual(presenter.showLoginSuccessCallCount, 1)
	}
	
	func test_login_presenterShowLoginFailureWhenLoginFail() {
		let (sut, presenter, loginService) = makeSut()
		
		sut.loginWith(email: anyEmail(), password: anyPassword())

		let loginError = NSError(domain: "", code: 1)
		
		loginService.completeLoginFailure(with: loginError)
		
		XCTAssertEqual(presenter.showLoginFailureCallCount, 1)
	}
	
	// MARK: - Helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (LoginViewControllerInteractor, LoginViewControllerPresenterSpy, EmailLoginClientMock) {
		let presenter = LoginViewControllerPresenterSpy()
		let emailLoginClient = EmailLoginClientMock()
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
	
	private final class LoginViewControllerPresenterSpy: LoginViewControllerPresentationLogic {
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
	
	private final class EmailLoginClientMock: EmailLoginClient {
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
