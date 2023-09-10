//
//  EmailPasswordAuthClient.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/7.
//

public protocol EmailLoginClient {
	typealias LoginCompletion = (Result<Bool, Error>) -> Void
	
	func login(email: String, password: String, completion: @escaping LoginCompletion)
}
