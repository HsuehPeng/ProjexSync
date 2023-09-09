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
		
		loginService.completeLogin(with: nil)
		
		XCTAssertEqual(presenter.isIndicatorLoading, false)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (LoginInteractor, LoginViewControllerPresenterMock, LoginServiceMock) {
		let presenter = LoginViewControllerPresenterMock()
		let loginService = LoginServiceMock()
		let sut = LoginInteractor(presenter: presenter, loginService: loginService)
		
		trackForMemoryleaks(presenter)
		trackForMemoryleaks(loginService)
		trackForMemoryleaks(sut)

		return (sut, presenter, loginService)
	}
	
	private final class LoginViewControllerPresenterMock: LoginViewControllerPresentationLogic {
		var isIndicatorLoading = false
		
		func showLoginFailure() {
			
		}
		
		func showLoginSuccess() {
			
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
		
		func completeLogin(with result: Error?, at index: Int = 0) {
			loginCompletions[index](result)
		}
	}
}
