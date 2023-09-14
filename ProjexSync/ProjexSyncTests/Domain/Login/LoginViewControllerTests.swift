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
		
		sut.didTapSignInButton()
		
		XCTAssertEqual(interactor.loginCallCount, 1)
	}
	
	func test_showLoginFailureView_routerDidShowFailureView() {
		let (sut, _, router) = makeSut()
		
		let viewModel = "Failure"
		let expectedMessage: [LoginViewControllerRouterSpy.Message] = [.showLoginFailureView(viewModel)]
		sut.showLoginFailureView(viewModel: viewModel)
		
		XCTAssertEqual(expectedMessage, router.messages)
	}
	
	func test_showLoginSuccessView_routerDidShowSuccessView() {
		let (sut, _, router) = makeSut()
		
		let expectedMessage: [LoginViewControllerRouterSpy.Message] = [.showLoginSuccessView]
		sut.showLoginSuccessView()
		
		XCTAssertEqual(expectedMessage, router.messages)
	}
	
	func test_loginLoadingIndicator_loadingIndicatorShouldStartAnimatingWhenAsked() {
		let (sut, _, _) = makeSut()
		let isAnimating = true
		let notAnimating = false
		
		sut.loginLoadingIndicator(shouldShow: isAnimating)
		XCTAssertEqual(sut.contentView.loadingIndicator.isAnimating, isAnimating)
		
		sut.loginLoadingIndicator(shouldShow: notAnimating)
		XCTAssertEqual(sut.contentView.loadingIndicator.isAnimating, notAnimating)
	}
	
	// MARK: - helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (LoginViewController, LoginViewControllerInteractorMock, LoginViewControllerRouterSpy) {
		let interactor = LoginViewControllerInteractorMock()
		let router = LoginViewControllerRouterSpy()
		let sut = LoginViewController(interactor: interactor)
		sut.router = router
		
		trackForMemoryleaks(interactor, file: file, line: line)
		trackForMemoryleaks(sut, file: file, line: line)

		return (sut, interactor, router)
	}
	
	private final class LoginViewControllerInteractorMock: LoginViewControllerBusinessLogic {
		var loginCallCount = 0
		
		func loginWith(email: String?, password: String?) {
			loginCallCount += 1
		}
	}
	
	private final class LoginViewControllerRouterSpy: LoginViewControllerRoutingLogic {
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
		
		func dismiss() {
			
		}
	}
	
}
