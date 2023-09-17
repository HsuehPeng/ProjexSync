//
//  LoginViewControllerInteractorTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/9.
//

import XCTest
@testable import ProjexSync

final class LoginViewControllerInteractorTests: XCTestCase {
	func test_login_loginWorkerDidCallLoginWithEmailAndPassword() {
		let (sut, _, loginWorker) = makeSut()
		
		sut.loginWith(email: anyEmail(), password: anyPassword())
		
		XCTAssertEqual(loginWorker.loginCallCount, 1)
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
	
	func test_login_loginClientDoesnotCallLoginWhenInteractorIsDeallocated() {
		let presenter = LoginViewControllerPresenterMock()
		let loginWorker = LoginWorkerSpy()
		var sut: LoginViewControllerInteractor? = LoginViewControllerInteractor(presenter: presenter, loginWorker: loginWorker)

		sut?.loginWith(email: anyEmail(), password: anyPassword())
		sut = nil
		loginWorker.completeLoginSuccess()
		
		XCTAssertEqual(presenter.showLoginFailureCallCount, 0)
		XCTAssertEqual(presenter.showLoginSuccessCallCount, 0)
	}
	
	// MARK: - Helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (LoginViewControllerInteractor, LoginViewControllerPresenterMock, LoginWorkerSpy) {
		let presenter = LoginViewControllerPresenterMock()
		let loginWorker = LoginWorkerSpy()
		let sut = LoginViewControllerInteractor(presenter: presenter, loginWorker: loginWorker)
		
		trackForMemoryleaks(presenter, file: file, line: line)
		trackForMemoryleaks(loginWorker, file: file, line: line)
		trackForMemoryleaks(sut, file: file, line: line)

		return (sut, presenter, loginWorker)
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
	
	private final class LoginWorkerSpy: LoginLogic {
		typealias LoginCompletion = (LoginResult) -> Void
		
		var loginCallCount = 0
		var loginCompletions: [LoginCompletion] = []
		
		func login(email: String?, password: String?, completion: @escaping LoginCompletion) {
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
