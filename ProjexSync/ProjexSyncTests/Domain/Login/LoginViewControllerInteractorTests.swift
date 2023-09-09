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
		
		sut.login()
		
		XCTAssertEqual(loginService.loginCallCount, 1)
	}
	
	func test_login_presenterShowLoginIndicatorWhenLoginNotFinish() {
		let (sut, presenter, _) = makeSut()
		
		sut.login()
		
		XCTAssertEqual(presenter.isIndicatorLoading, true)
	}
	
	func test_login_presenterHideShowLoginIndicatorWhenLoginFinish() {
		let (sut, presenter, loginService) = makeSut()
		
		sut.login()
		
		loginService.completeLoginWithSuccess()
		
		XCTAssertEqual(presenter.isIndicatorLoading, false)
	}
	
	func test_login_presenterShowLoginInSuccessWhenLoginSuccess() {
		let (sut, presenter, loginService) = makeSut()
		
		sut.login()
		
		loginService.completeLoginWithSuccess()
		
		XCTAssertEqual(presenter.showLoginSuccessCallCount, 1)
	}
	
	func test_login_presenterShowLoginFailureWhenLoginFail() {
		let (sut, presenter, loginService) = makeSut()
		
		sut.login()
		
		let loginError = NSError(domain: "", code: 1)
		
		loginService.completeLoginWithError(error: loginError)
		
		XCTAssertEqual(presenter.showLoginFailureCallCount, 1)
	}
	
	// MARK: - Helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (LoginViewControllerInteractor, LoginViewControllerPresenterSpy, LoginServiceMock) {
		let presenter = LoginViewControllerPresenterSpy()
		let loginService = LoginServiceMock()
		let sut = LoginViewControllerInteractor(presenter: presenter, loginService: loginService)
		
		trackForMemoryleaks(presenter, file: file, line: line)
		trackForMemoryleaks(loginService, file: file, line: line)
		trackForMemoryleaks(sut, file: file, line: line)

		return (sut, presenter, loginService)
	}
	
	private final class LoginViewControllerPresenterSpy: LoginViewControllerPresentationLogic {
		var isIndicatorLoading = false
		var showLoginSuccessCallCount = 0
		var showLoginFailureCallCount = 0
		
		func showLoginFailure() {
			showLoginFailureCallCount += 1
		}
		
		func showLoginSuccess() {
			showLoginSuccessCallCount += 1
		}
		
		func showLoginLoadingIndicator(isLoading: Bool) {
			isIndicatorLoading = isLoading
		}
	}
	
	private final class LoginServiceMock: LoginService {
		var loginCallCount = 0
		var loginCompletions: [LoginCompletion] = []
		
		func login(completion: @escaping LoginCompletion) {
			loginCallCount += 1
			loginCompletions.append(completion)
		}
		
		func completeLoginWithSuccess(at index: Int = 0) {
			completeLogin(with: nil, at: index)
		}
		
		func completeLoginWithError(error: Error, at index: Int = 0) {
			completeLogin(with: error, at: index)
		}
		
		private func completeLogin(with result: Error?, at index: Int = 0) {
			loginCompletions[index](result)
		}
	}
}
