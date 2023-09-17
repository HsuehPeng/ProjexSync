//
//  EmailPasswordValidator.swift
//  ProjexSyncTests
//
//  Created by Hsueh Peng Tseng on 2023/9/16.
//

import XCTest
@testable import ProjexSync

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
