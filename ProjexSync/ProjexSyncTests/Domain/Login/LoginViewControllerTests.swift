//
//  LoginViewControllerTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/9.
//

import XCTest
@testable import ProjexSync

final class LoginViewControllerTests: XCTestCase {
	func test_didTapSignInButton_interactorCallsLogin() {
		let (sut, interactor, _) = makeSut()
		
		sut.signInButton.simulateTap()
		
		XCTAssertEqual(interactor.loginCallCount, 1)
	}
	
	func test_showLoginFailureView_routerDidShowFailureView() {
		let (sut, _, router) = makeSut()
		
		let viewModel = "Failure"
		let expectedMessage: [LoginViewControllerRouterMock.Message] = [.showLoginFailureView(viewModel)]
		sut.showLoginFailureView(viewModel: viewModel)
		
		XCTAssertEqual(expectedMessage, router.messages)
	}
	
	// MARK: - helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (LoginViewController, LoginViewControllerInteractorMock, LoginViewControllerRouterMock) {
		let interactor = LoginViewControllerInteractorMock()
		let router = LoginViewControllerRouterMock()
		let sut = LoginViewController(interactor: interactor)
		sut.router = router
		
		trackForMemoryleaks(interactor)
		trackForMemoryleaks(sut)

		return (sut, interactor, router)
	}
	
	private final class LoginViewControllerInteractorMock: LoginViewControllerBusinessLogic {
		var loginCallCount = 0
		
		func login() {
			loginCallCount += 1
		}
	}
	
	private final class LoginViewControllerRouterMock: LoginViewControllerRoutingLogic {
		enum Message: Equatable {
			case showLoginFailureView(String)
			case showLoginSuccessView
		}
		
		var messages = [Message]()
		
		func showLoginFailureView(viewModel: String) {
			messages.append(.showLoginFailureView(viewModel))
		}
		
		func showLoginSuccessView() {
			messages.append(.showLoginSuccessView)
		}
	}
	
}
