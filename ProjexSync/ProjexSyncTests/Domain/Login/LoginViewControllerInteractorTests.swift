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
	
	// MARK: - Helpers
	
	private func makeSut() -> (LoginInteractor, LoginViewControllerPresenterMock, LoginServiceMock) {
		let presenter = LoginViewControllerPresenterMock()
		let loginService = LoginServiceMock()
		let sut = LoginInteractor(presenter: presenter, loginService: loginService)
		
		return (sut, presenter, loginService)
	}
	
	private final class LoginViewControllerPresenterMock: LoginViewControllerPresentationLogic {
		func showLoginFailure(viewModel: LoginFailureViewModel) {
			
		}
		
		func showLoginSuccess(viewModel: LoginSuccessViewModel) {
			
		}
	}
	
	private final class LoginServiceMock: LoginService {
		var loginCallCount = 0
		
		func login(completion: @escaping LoginCompletion) {
			loginCallCount += 1
		}
	}
}
