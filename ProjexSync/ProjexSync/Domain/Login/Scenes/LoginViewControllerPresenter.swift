//
//  LoginPresenter.swift
//  ProjexSync
//
//  Created by Hsueh Peng Tseng on 2023/9/8.
//

import Foundation

protocol LoginViewControllerPresentationLogic: AnyObject {
	func showLoginFailure(message: String)
	func showLoginSuccess()
	func loginLoadingIndicator(isLoading: Bool)
}

class LoginViewControllerPresenter: LoginViewControllerPresentationLogic {
	weak var viewController: LoginViewControllerDisplayLogic?
	
	func showLoginFailure(message: String) {
		viewController?.showLoginFailureView(viewModel: message)
	}
	
	func showLoginSuccess() {
		viewController?.showLoginSuccessView()
	}
	
	func loginLoadingIndicator(isLoading: Bool) {
		viewController?.loginLoadingIndicator(shouldShow: isLoading)
	}
	
	
}
