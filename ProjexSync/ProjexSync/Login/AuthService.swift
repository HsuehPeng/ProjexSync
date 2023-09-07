//
//  AuthService.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/7.
//

public protocol AuthService {
	typealias LoginResult = Swift.Result<Bool, Error>
	typealias LoginCompletion = (LoginResult) -> Void
	
	func login(completion: @escaping LoginCompletion)
}
