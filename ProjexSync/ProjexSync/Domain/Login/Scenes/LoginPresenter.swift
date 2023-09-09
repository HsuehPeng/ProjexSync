//
//  LoginPresenter.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import Foundation

protocol LoginViewControllerPresentationLogic: AnyObject {
	func showLoginFailure()
	func showLoginSuccess()
	func showLoginLoadingIndicator(isLoading: Bool)
}

class LoginPresenter {

}
