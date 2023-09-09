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
	 
	// MARK: - Helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (LoginViewControllerPresenter, LoginViewControllerSpy) {
		let sut = LoginViewControllerPresenter()
		let loginViewControllerMock = LoginViewControllerSpy()
		sut.viewController = loginViewControllerMock
		
		trackForMemoryleaks(sut)
		trackForMemoryleaks(loginViewControllerMock)
		
		return (sut, loginViewControllerMock)
	}
	
	private final class LoginViewControllerSpy: LoginViewControllerDisplayLogic {
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
