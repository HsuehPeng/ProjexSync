//
//  EmailPasswordValidator.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/16.
//

import XCTest

class EmailPasswordValidator {
	func validateEmail(_ email: String) -> Bool {
		return false
	}
}

final class EmailPasswordValidatorTests: XCTestCase {
	func test_validateEmail_returnFalseWhenEmailIsWrong() {
		let sut = EmailPasswordValidator()
		let wrongEmail = "WrongEmail"
		
		let isValidEmail = sut.validateEmail(wrongEmail)
		
		XCTAssertEqual(isValidEmail, false)
	}
}
