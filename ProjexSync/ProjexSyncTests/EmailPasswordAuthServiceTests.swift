//
//  ProjexSyncTests.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/6.
//

import XCTest
import ProjexSync

final class EmailPasswordAuthServiceTests: XCTestCase {
	func test_login_getCorrectEmailAndPassword() {
		let email = "Email"
		let password = "Password"
		let (sut, authClient) = makeSut(email: email, password: password)
		
		sut.login { _ in }
		
		XCTAssertEqual(authClient.receivedInfo.first?.email, email)
		XCTAssertEqual(authClient.receivedInfo.first?.password, password)
	}
	
	func test_login_completeWithLoginError() {
		let (sut, authClient) = makeSut()
		let expectedError: EmailPasswordAuthService.Error = .login

		expect(sut, toCompleteWith: expectedError) {
			authClient.completeLoginWithError(with: expectedError)
		}
	}
	
	func test_login_completeWithLoginWithoutError() {
		let (sut, authClient) = makeSut()
		
		expect(sut, toCompleteWith: nil) {
			authClient.completeLoginWithSuccess()
		}
	}
	
	// MARK: - Helpers
	
	private func makeSut(email: String = "", password: String = "") -> (EmailPasswordAuthService, EmailPasswordAuthClientSpy) {
		let authClient = EmailPasswordAuthClientSpy()
		let sut = EmailPasswordAuthService(authClient: authClient, email: email, password: password)
		
		trackForMemoryleaks(authClient)
		trackForMemoryleaks(sut)

		return (sut, authClient)
	}
	
	private func expect(_ sut: EmailPasswordAuthService, toCompleteWith expectedResult: Error?, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
		let exp = expectation(description: "Wait for login completion")
		
		sut.login { receivedError in
			XCTAssertEqual(receivedError as? EmailPasswordAuthService.Error, expectedResult as? EmailPasswordAuthService.Error, file: file, line: line)
			exp.fulfill()
		}
		
		action()
		wait(for: [exp], timeout: 1.0)
	}
	
	private class EmailPasswordAuthClientSpy: EmailPasswordAuthClient {
		struct ReceivedInfo {
			let email: String
			let password: String
		}
		
		private(set) var receivedInfo = [ReceivedInfo]()
		private var loginCompletions = [LoginCompletion]()
		
		func login(email: String, password: String, completion: @escaping LoginCompletion) {
			receivedInfo.append(ReceivedInfo(email: email, password: password))
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
