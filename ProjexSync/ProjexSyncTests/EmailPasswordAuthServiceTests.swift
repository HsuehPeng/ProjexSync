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
		let exp = expectation(description: "Wait for login completion")
		let expectedError: EmailPasswordAuthService.Error = .login
		
		sut.login { receivedError in
			XCTAssertEqual(receivedError as? EmailPasswordAuthService.Error, expectedError)
			exp.fulfill()
		}
		
		authClient.completeLoginWithError(with: expectedError)
		
		wait(for: [exp], timeout: 1.0)
	}
	
	func test_login_completeWithLoginWithoutError() {
		let (sut, authClient) = makeSut()
		let exp = expectation(description: "Wait for login completion")
		
		sut.login { receivedError in
			XCTAssertNil(receivedError)
			exp.fulfill()
		}
		
		authClient.completeLoginWithSuccess()
		
		wait(for: [exp], timeout: 1.0)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (EmailPasswordAuthService, EmailPasswordAuthClientSpy) {
		let authClient = EmailPasswordAuthClientSpy()
		let sut = EmailPasswordAuthService(authClient: authClient, email: "", password: "")
		
		trackForMemoryleaks(authClient)
		trackForMemoryleaks(sut)

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
		
		func completeLoginWithSuccess(at index: Int = 0) {
			loginCompletions[index](.success(true))
		}
	}
}
