//
//  EmailPasswordValidator.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/16.
//

import XCTest

class EmailPasswordValidator {
	func isValidEmail(_ email: String) -> Bool {
		let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
		let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
		return emailValidationPredicate.evaluate(with: email)
	}
	
	func isValidPassword(_ password: String) -> Bool {
		return password.count >= 6
	}
}

final class EmailPasswordValidatorTests: XCTestCase {
	func test_validateEmail_returnFalseWhenEmailIsWrong() {
		let sut = EmailPasswordValidator()
		let wrongEmail = "WrongEmail"
		
		let isValidEmail = sut.isValidEmail(wrongEmail)
		
		XCTAssertEqual(isValidEmail, false)
	}
	
	func test_validateEmail_returnTrueWhenEmailIsCorrect() {
		let sut = EmailPasswordValidator()
		let correctEmail = "123@gmail.com"
		
		let isValidEmail = sut.isValidEmail(correctEmail)
		
		XCTAssertEqual(isValidEmail, true)
	}
	
	func test_validatePassword_returnFalseWhenPasswordFormateIsInValid() {
		let sut = EmailPasswordValidator()
		let wrongPassword = "00000"
		
		let isValidPassword = sut.isValidPassword(wrongPassword)
		
		XCTAssertEqual(isValidPassword, false)
	}
	
	func test_validatePassword_returnTrueWhenPasswordFormateIsInValid() {
		let sut = EmailPasswordValidator()
		let correctPassword = "000000"
		
		let isValidPassword = sut.isValidPassword(correctPassword)
		
		XCTAssertEqual(isValidPassword, true)
	}
	
}
