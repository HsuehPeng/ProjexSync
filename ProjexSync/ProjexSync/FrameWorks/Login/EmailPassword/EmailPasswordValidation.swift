//
//  EmailPasswordValidation.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/17.
//

import Foundation

public protocol EmailPasswordValidation {
	func isValidEmail(_ email: String) -> Bool
	func isValidPassword(_ password: String) -> Bool
}
