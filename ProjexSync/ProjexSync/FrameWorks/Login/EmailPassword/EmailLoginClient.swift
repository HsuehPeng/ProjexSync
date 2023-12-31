//
//  EmailPasswordAuthClient.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/7.
//

public protocol EmailLoginClient {
	typealias LoginResult = Result<Bool, Error>
	typealias LoginCompletion = (LoginResult) -> Void
	
	func login(email: String, password: String, completion: @escaping LoginCompletion)
}
