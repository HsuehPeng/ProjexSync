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
		let (sut, interactor) = makeSut()
		
		sut.signInButton.simulateTap()
		
		XCTAssertEqual(interactor.loginCallCount, 1)
	}
	
	// MARK: - helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (LoginViewController, LoginViewControllerInteractorMock) {
		let interactor = LoginViewControllerInteractorMock()
		let sut = LoginViewController(interactor: interactor)
		
		trackForMemoryleaks(interactor)
		trackForMemoryleaks(sut)

		return (sut, interactor)
	}
	
	private final class LoginViewControllerInteractorMock: LoginViewControllerBusinessLogic {
		var loginCallCount = 0
		
		func login() {
			loginCallCount += 1
		}
	}
	
}
