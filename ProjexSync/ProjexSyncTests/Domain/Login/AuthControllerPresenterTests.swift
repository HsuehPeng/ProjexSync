//
//  LoginViewControllerPresenter.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/9.
//

import XCTest
@testable import ProjexSync

final class LoginViewControllerPresenterTests: XCTestCase {
	func test_showLoginFailure_loginViewShowFailureData() {
		let (sut, loginViewController) = makeSut()
		
		let errorMessage = "Error message"
		let expectedResult = [LoginViewControllerSpy.Message.showLoginFailureView(errorMessage)]
		sut.showLoginFailure(message: errorMessage)
		
		XCTAssertEqual(expectedResult, loginViewController.messages)
	}
	
	func test_showLoginFailure_loginViewShowSuccessData() {
		let (sut, loginViewController) = makeSut()
		
		let expectedResult = [LoginViewControllerSpy.Message.showLoginSuccessView]
		sut.showLoginSuccess()
		
		XCTAssertEqual(expectedResult, loginViewController.messages)
	}
	
	func test_loginLoadingIndicator_loginViewShowLoadingIndicator() {
		let (sut, loginViewController) = makeSut()
		
		let expectedResult = [LoginViewControllerSpy.Message.loginLoadingIndicator(true)]
		sut.loginLoadingIndicator(isLoading: true)
		
		XCTAssertEqual(expectedResult, loginViewController.messages)
	}
	 
	// MARK: - Helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (AuthControllerPresenter, LoginViewControllerSpy) {
		let sut = AuthControllerPresenter()
		let loginViewControllerMock = LoginViewControllerSpy()
		sut.viewController = loginViewControllerMock
		
		trackForMemoryleaks(sut, file: file, line: line)
		trackForMemoryleaks(loginViewControllerMock, file: file, line: line)
		
		return (sut, loginViewControllerMock)
	}
	
    private final class LoginViewControllerSpy: AuthDisplayLogic {
		enum Message: Equatable {
			case showLoginFailureView(String)
			case showLoginSuccessView
			case loginLoadingIndicator(Bool)
		}
		
		var loadingIndicatorIsLoading: Bool = false
		var messages = [Message]()
		
		func showAutnFailureView(viewModel: String) {
			messages.append(.showLoginFailureView(viewModel))
		}
		
		func showAuthSuccessView() {
			messages.append(.showLoginSuccessView)
		}
		
		func loadingIndicator(shouldShow: Bool) {
			messages.append(.loginLoadingIndicator(shouldShow))
		}
	}
}
