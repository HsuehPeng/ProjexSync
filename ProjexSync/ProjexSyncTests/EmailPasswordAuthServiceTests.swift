//
//  ProjexSyncTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/6.
//

import XCTest
import ProjexSync

final class EmailPasswordAuthServiceTests: XCTestCase {
	func test_login_completeWithLoginError() {
		let (sut, authClient) = makeSut()
		let exp = expectation(description: "Wait for load completion")

		let loginError = EmailPasswordAuthService.Error.login
		let expectedResult: EmailPasswordAuthService.Result = .failure(loginError)
		
		sut.login { receivedResult in
			switch (expectedResult, receivedResult) {
			case let (.failure(receivedError as EmailPasswordAuthService.Error), .failure(expectedError as EmailPasswordAuthService.Error)):
				XCTAssertEqual(receivedError, expectedError)
			default:
				XCTFail("Expected result \(expectedResult), got \(receivedResult) instead")
			}
			exp.fulfill()
		}
		
		authClient.completeLoginWithError(with: loginError)
		
		wait(for: [exp], timeout: 1.0)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (EmailPasswordAuthService, EmailPasswordAuthClientSpy) {
		let authClient = EmailPasswordAuthClientSpy()
		let sut = EmailPasswordAuthService(authClient: authClient, email: "", password: "")
		return (sut, authClient)
	}
	
	private class EmailPasswordAuthClientSpy: EmailPasswordAuthClient {
		enum ReceivedMessage: Equatable {
			case login
		}
		
		private(set) var receivedMessages = [ReceivedMessage]()
		private var loginCompletions = [LoginCompletion]()
		
		func login(email: String, password: String, completion: @escaping LoginCompletion) {
			receivedMessages.append(.login)
			loginCompletions.append(completion)
		}
		
		func completeLoginWithError(with error: Error, at index: Int = 0) {
			loginCompletions[index](.failure(error))
		}
	}
}
