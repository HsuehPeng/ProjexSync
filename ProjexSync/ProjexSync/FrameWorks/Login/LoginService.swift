//
//  AuthService.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/7.
//

public protocol LoginService {
	typealias LoginCompletion = (Error?) -> Void
	
	func login(completion: @escaping LoginCompletion)
}