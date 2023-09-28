//
//  EmailPasswordAuthClient.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/7.
//

public protocol AuthClient {
	typealias AuthResult = Result<Bool, Error>
	typealias AuthCompletion = (AuthResult) -> Void
	
	func auth(email: String, password: String, completion: @escaping AuthCompletion)
}
