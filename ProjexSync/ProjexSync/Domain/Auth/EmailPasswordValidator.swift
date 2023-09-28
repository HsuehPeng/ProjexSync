//
//  EmailPasswordValidator.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/16.
//

import Foundation

protocol EmailPasswordValidation {
	func isValidEmail(_ email: String) -> Bool
	func isValidPassword(_ password: String) -> Bool
}

final class EmailPasswordValidator: EmailPasswordValidation {
	func isValidEmail(_ email: String) -> Bool {
		let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
		let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
		return emailValidationPredicate.evaluate(with: email)
	}
	
	func isValidPassword(_ password: String) -> Bool {
		return password.count >= 6
	}
	
	init() {}
}
